import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../constants/icon_constant.dart';
import 'topic_choice_tile_widget.dart';

class PlantOptionsBottomSheetWidget extends StatelessWidget {
  const PlantOptionsBottomSheetWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<String> plantOptions = [
      'Rose',
      'Tulip',
      'Daisy',
      'Sunflower',
      'Orchid',
      'Lily',
      'Rose',
      'Tulip',
      'Daisy',
      'Sunflower',
      'Orchid',
      'Lily',
    ];

    return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
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
                const Text(
                  '2/2',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
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
                const Text(
                  'Choose 1 plant',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: ListView.builder(
                    itemCount: plantOptions.length,
                    itemBuilder: (context, index) {
                      return TopicChoiceTileWidget(
                        title: plantOptions[index],
                        subTitle:
                            'Shiny red fruits thrives in \nall weather conditions.',
                        onTap: () {
                          Get.back(result: plantOptions[index]);
                        },
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
                },
                icon: SvgPicture.asset(IconConstant.close),
              ),
            ),
          ],
        ));
  }
}
