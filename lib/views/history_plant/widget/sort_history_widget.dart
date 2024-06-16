import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/plant_history_controller.dart';
import 'package:plantopia/models/get_panting_history_response.dart';
import 'package:plantopia/views/global_widgets/shimmer_container_global_widget.dart';

class SortHistoryWidget extends StatelessWidget {
  SortHistoryWidget({
    super.key,
    required this.sortListHistory,
    required this.sortingName,
  });
  final List<PlantHistory> sortListHistory;
  final String sortingName;

  final PlantHistoryController plantHistoryController =
      Get.put(PlantHistoryController());

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: sortListHistory.isNotEmpty,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sortingName,
            style: TextStyleConstant.title.copyWith(
              fontWeight: FontWeight.w700,
              color: ColorConstant.neutral500,
            ),
          ),
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: sortListHistory.length,
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
                            decoration: BoxDecoration(
                              color: ColorConstant.white,
                              border: Border.all(
                                width: 1,
                                color: ColorConstant.neutral200,
                              ),
                              borderRadius: BorderRadius.circular(
                                8,
                              ),
                            ),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: sortListHistory[index].imageUrl ?? "-",
                              width: 147,
                              height: 160,
                              progressIndicatorBuilder:
                                  (context, url, progress) {
                                return const ShimmerContainerGlobalWidget(
                                    width: 147, height: 160, radius: 0);
                              },
                              errorWidget: (context, url, error) {
                                return Icon(
                                  Icons.error,
                                  color: ColorConstant.danger500,
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                sortListHistory[index].plantName ?? "-",
                                style: TextStyleConstant.heading4.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                sortListHistory[index].plantCategory ?? "-",
                                style: TextStyleConstant.footer.copyWith(
                                  color: ColorConstant.neutral400,
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                "Planted on",
                                style: TextStyleConstant.caption,
                              ),
                              Text(
                                plantHistoryController.parseDate(
                                    sortListHistory[index].createdAt ??
                                        DateTime(-1)),
                                style: TextStyleConstant.caption.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
                          ))
                        ],
                      ),
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }
}
