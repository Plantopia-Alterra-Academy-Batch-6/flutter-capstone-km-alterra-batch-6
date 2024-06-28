import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/controllers/my_plant_details_controller.dart';
import 'package:plantopia/models/get_my_plant_response_model.dart';
import '../../../constants/icon_constant.dart';
import 'topic_choice_tile_widget.dart';

class PlantOptionsBottomSheetWidget extends StatelessWidget {
  final Function(bool) isBottomSheetClosed;
  final List<PlantElement> plantOptions;

  const PlantOptionsBottomSheetWidget({
    super.key,
    required this.isBottomSheetClosed,
    required this.plantOptions,
  });

  @override
  Widget build(BuildContext context) {
    final MyPlantDetailsController myPlantDetailsController =
        Get.put(MyPlantDetailsController());
    return Container(
        decoration:  BoxDecoration(
          color: ColorConstant.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        height: 514,
        padding: const EdgeInsets.only(
          top: 24,
          left: 16,
          bottom: 8,
          right: 16,
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                  '2/2',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: ColorConstant.neutral500,
                  ),
                ),
                const SizedBox(height: 4),
                 const Text(
                  'Choose the topic that\nyou want to consult about',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                 Text(
                  'Choose 1 plant',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: ColorConstant.neutral500,
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: ListView.builder(
                    itemCount: plantOptions.length,
                    itemBuilder: (context, index) {
                      return TopicChoiceTileWidget(
                        title: plantOptions[index].customizeName != ""
                            ? plantOptions[index].customizeName ?? "-"
                            : plantOptions[index].plant?.name ?? "",
                        subTitle: plantOptions[index].plant?.description ?? "",
                        onTap: () {
                          Get.back(
                              result: myPlantDetailsController.extractPlantName(
                                  plantOptions[index].plant?.name ?? "-"));
                          isBottomSheetClosed(true);
                        },
                        imgUrl: plantOptions[index]
                                .plant
                                ?.plantImages?[0]
                                .fileName ??
                            '-',
                      );
                    },
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                onPressed: () {
                  Get.back();
                  isBottomSheetClosed(true);
                },
                icon: SvgPicture.asset(IconConstant.close),
              ),
            ),
          ],
        ));
  }
}
