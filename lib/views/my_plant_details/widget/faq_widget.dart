import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/my_plant_details_controller.dart';
import 'package:plantopia/models/get_my_plant_response_model.dart';

class FaqWidget extends StatelessWidget {
  FaqWidget({super.key});

  final controller = Get.put(MyPlantDetailsController());

  @override
  Widget build(BuildContext context) {
    final Map arguments = Get.arguments;
    final PlantElement detailMyPlant = arguments['myPlantDetails'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(
          "People Often Ask",
          style:
              TextStyleConstant.heading4.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 14),
        Column(
          children: List.generate(
            detailMyPlant.plant?.plantFaqs?.length ?? 0,
            (value) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: controller.customIcon.value
                            ? Colors.black
                            : ColorConstant.neutral500),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      title: Text(
                        detailMyPlant.plant?.plantFaqs?[value].question ?? "-",
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
                          child: Row(
                            children: [
                              Text(
                                  detailMyPlant
                                          .plant?.plantFaqs?[value].answer! ??
                                      "-",
                                  style: TextStyleConstant.paragraph),
                            ],
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
            },
          ),
        ),
      ],
    );
  }
}
