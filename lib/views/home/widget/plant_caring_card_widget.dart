import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/my_plant_controller.dart';
import 'package:plantopia/views/global_widgets/shimmer_container_global_widget.dart';
import 'package:plantopia/views/my_plant_details/widget/button_widget.dart';

class PlantCaringCardWidget extends StatelessWidget {
  PlantCaringCardWidget({super.key});

  final MyPlantController myPlantController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 160,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: ColorConstant.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      child: Stack(
        children: [
          Container(
            width: 156,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0x0010B981).withOpacity(0.06),
                  const Color(0x1910B981).withOpacity(0.0)
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 22),
            child: Row(
              children: [
                CachedNetworkImage(
                    width: 100,
                    height: 100,
                    placeholder: (context, url) {
                      return const ShimmerContainerGlobalWidget(
                          width: double.infinity,
                          height: double.infinity,
                          radius: 8);
                    },
                    imageUrl: myPlantController.plantByIdResponse?.data
                            ?.plantImages?[0].fileName ??
                        "-"),
                const SizedBox(
                  width: 16,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "💧",
                              style: TextStyleConstant.heading4,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Next watering on",
                                  style: TextStyleConstant.paragraph.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: ColorConstant.neutral400,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  myPlantController.parseHour(myPlantController
                                          .plantCaringData[0]
                                          .plant
                                          ?.wateringSchedule
                                          ?.wateringTime ??
                                      "-"),
                                  style: TextStyleConstant.paragraph.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 11,
                        ),
                        ButtonWidget(
                          onTap: () async {
                            await myPlantController.postWatering(
                                myPlantController.plantByIdResponse?.data?.id ??
                                    -1);
                          },
                          buttonName: "Finish Watering",
                          boxDecoration: BoxDecoration(
                              color: ColorConstant.primary500,
                              borderRadius: BorderRadius.circular(8)),
                          textStyle: TextStyleConstant.subtitle.copyWith(
                            color: ColorConstant.white,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
