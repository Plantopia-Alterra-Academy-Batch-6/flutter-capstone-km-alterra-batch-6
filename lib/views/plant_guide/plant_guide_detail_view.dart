import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/models/get_my_plant_response_model_new.dart';
import 'package:plantopia/views/plant_guide/widget/plant_guide_button_end_widget.dart';
import 'package:plantopia/views/plant_guide/widget/plant_guide_instruction_detail_widget.dart';
import 'package:plantopia/controllers/plant_guide_controller.dart';

import '../global_widgets/shimmer_container_global_widget.dart';

class PlantGuideDetailView extends StatelessWidget {
  PlantGuideDetailView({super.key});

  final PlantInstruction instruction = Get.arguments['instruction'];
  final controller = Get.put(GetMyPlantGuideController());

  Future<String> getAiSuggestion(String description) async {
    final openAI = OpenAI.instance.build(
      token: dotenv.env['CHATBOT_API_KEY'],
      baseOption: HttpSetup(
        receiveTimeout: const Duration(seconds: 20),
      ),
    );

    final request = ChatCompleteText(
      messages: [
        {
          "role": "system",
          "content":
              "Please provide a detailed explanation in no more than 2 paragraphs.",
        },
        {
          "role": "user",
          "content": description,
        }
      ],
      maxToken: 200,
      model: Gpt4ChatModel(),
    );

    try {
      ChatCTResponse? response =
          await openAI.onChatCompletion(request: request);
      if (response != null && response.choices.isNotEmpty) {
        return response.choices.first.message?.content ??
            "No suggestion available";
      } else {
        return "No suggestion available";
      }
    } catch (e) {
      return "Error fetching suggestion";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.white,
      extendBody: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        title: Text(
          instruction.instructionCategory?.name ?? 'No Title',
          style:
              TextStyleConstant.heading4.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PlantGuideInstructionDetailWidget(
                categoryDescription:
                    instruction.instructionCategory?.description ??
                        'No Description',
                categoryTitle:
                    instruction.instructionCategory?.name ?? 'No Title',
                imageUrl: instruction.stepImageUrl ?? '',
                stepNumber: instruction.stepNumber ?? 0,
                stepTitle: instruction.stepTitle ?? 'No Title',
                stepDescription:
                    instruction.stepDescription ?? 'No Description',
              ),
              FutureBuilder<String>(
                future: getAiSuggestion(
                    instruction.stepDescription ?? 'No Description'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const ShimmerContainerGlobalWidget(
                      width: double.infinity,
                      height: 50,
                      radius: 5,
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                        child: Text('Error loading AI suggestion'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text('No AI suggestion available'));
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: controller.customIcon.value
                                ? Colors.black
                                : ColorConstant.neutral500,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Theme(
                          data: Theme.of(context)
                              .copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            title: Text(
                              "Planbot's Recommendation about ${instruction.instructionCategory?.name}",
                              style: TextStyleConstant.subtitle
                                  .copyWith(fontWeight: FontWeight.w700),
                            ),
                            trailing: Icon(controller.customIcon.value
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down),
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, bottom: 16),
                                child: Text(
                                  snapshot.data!,
                                  style: TextStyleConstant.paragraph,
                                ),
                              ),
                            ],
                            onExpansionChanged: (value) {
                              controller.customIcon(value);
                            },
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const PlantGuideButtonEndWidget(),
    );
  }
}
