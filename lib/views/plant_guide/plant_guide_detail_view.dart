import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
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
  final List<PlantInstruction> allInstructions =
      Get.arguments['allInstructions'];
  final List<PlantInstruction> categoryInstructions =
      Get.arguments['categoryInstructions'];
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
    int currentIndex =
        allInstructions.indexWhere((instr) => instr.id == instruction.id);

    String buttonText;
    if (currentIndex < allInstructions.length - 1) {
      buttonText =
          'Proceed to ${allInstructions[currentIndex + 1].instructionCategory!.name?.toLowerCase()}';
    } else {
      buttonText = 'Finished';
    }

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
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: categoryInstructions.asMap().entries.map((entry) {
                  int index = entry.key;
                  PlantInstruction instr = entry.value;
                  return PlantGuideInstructionDetailWidget(
                    categoryDescription: instr.instructionCategory?.description ?? 'No Description',
                    categoryTitle: instr.instructionCategory?.name ?? 'No Title',
                    imageUrl: instr.stepImageUrl ?? '',
                    stepNumber: instr.stepNumber ?? 0,
                    stepTitle: instr.stepTitle ?? 'No Title',
                    stepDescription: instr.stepDescription ?? 'No Description',
                    showCategory: index == 0, 
                  );
                }).toList(),
              ),
              FutureBuilder<String>(
                future: getAiSuggestion(instruction.stepDescription ?? 'No Description'),
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
                                child: HtmlWidget(
                                  snapshot.data!,
                                  textStyle: TextStyleConstant.paragraph,
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
      bottomNavigationBar: PlantGuideButtonEndWidget(
        textButton: buttonText,
      ),
    );
  }
}
