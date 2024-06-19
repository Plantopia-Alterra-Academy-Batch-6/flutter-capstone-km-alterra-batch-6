import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/watering_history_controller.dart';
import 'package:plantopia/views/global_widgets/shimmer_container_global_widget.dart';

class SortWateringHistoryWidget extends StatelessWidget {
  SortWateringHistoryWidget({super.key});

  final WateringHistoryController wateringHistoryController =
      Get.put(WateringHistoryController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: wateringHistoryController.listWateringHistory.length,
            itemBuilder: (context, int index) {
              return Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Container(
                  width: double.infinity,
                  height: 184,
                  decoration: BoxDecoration(
                    color: ColorConstant.neutral50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Container(
                          width: 147,
                          height: 160,
                          decoration: ShapeDecoration(
                            color: ColorConstant.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1,
                                color: ColorConstant.neutral200,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: wateringHistoryController
                                      .listWateringHistory[index]
                                      .plant
                                      ?.plantImage?[0]
                                      .fileName ??
                                  "-",
                              progressIndicatorBuilder:
                                  (context, url, progress) {
                                return const ShimmerContainerGlobalWidget(
                                  width: 147,
                                  height: 160,
                                  radius: 0,
                                );
                              },
                              errorWidget: (context, url, error) {
                                return Icon(
                                  Icons.error,
                                  color: ColorConstant.danger500,
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              wateringHistoryController
                                      .listWateringHistory[index].plant?.name ??
                                  "-",
                              style: TextStyleConstant.heading4.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 0.5,
                                    color: ColorConstant.neutral400),
                              ),
                              width: double.infinity,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Time",
                                  style: TextStyleConstant.caption.copyWith(
                                    color: ColorConstant.neutral400,
                                  ),
                                ),
                                Text(
                                  wateringHistoryController.parseHour(
                                    wateringHistoryController
                                            .listWateringHistory[index]
                                            .createdAt ??
                                        DateTime(
                                          -1,
                                        ),
                                  ),
                                  style: TextStyleConstant.caption.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Date",
                                  style: TextStyleConstant.caption.copyWith(
                                    color: ColorConstant.neutral400,
                                  ),
                                ),
                                Text(
                                  wateringHistoryController.parseDate(
                                      wateringHistoryController
                                              .listWateringHistory[index]
                                              .createdAt ??
                                          DateTime(-1)),
                                  style: TextStyleConstant.caption.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ))
                      ],
                    ),
                  ),
                ),
              );
            })
      ],
    );
  }
}
