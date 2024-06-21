import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:plantopia/controllers/my_plant_controller.dart';
import 'package:plantopia/models/get_my_plant_response_model.dart';
import '../../../constants/icon_constant.dart';
import '../../../constants/image_constant.dart';
import 'plant_options_bottom_sheet_widget.dart';
import 'topic_choice_item_widget.dart';

class TopicChoiceBottomSheet extends StatelessWidget {
  final Function(String) onSelectTopic;
  final Function(bool) isSecondBottomSheet;
  final Function(bool) isBottomSheetClosed;
  final MyPlantController myPlantController = Get.find();

  TopicChoiceBottomSheet({
    super.key,
    required this.onSelectTopic,
    required this.isSecondBottomSheet,
    required this.isBottomSheetClosed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      width: double.infinity,
      height: 321,
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
            children: <Widget>[
              const Text(
                '1/2',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'What do you want to\ntalk about?',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TopicChoiceItem(
                    vector: ImageConstant.chatbotOption1,
                    text: 'Consultate about\nplanting or others',
                    onTap: () {
                      Get.back();
                      onSelectTopic('Consultate about planting or others');
                      isSecondBottomSheet(false);
                      isBottomSheetClosed(true);
                    },
                  ),
                  if (myPlantController.listMyPlant.isNotEmpty)
                    TopicChoiceItem(
                      vector: ImageConstant.chatbotOption2,
                      text: 'Consultate about my plant',
                      onTap: () => handleSelectTopic(
                          'Consultate about my plant', context),
                    ),
                ],
              )
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
      ),
    );
  }

  void handleSelectTopic(String topic, BuildContext context) {
    if (topic == 'Consultate about my plant') {
      Get.back();
      _showPlantOptions(context, myPlantController.listMyPlant);
    } else {
      onSelectTopic(topic);
    }
  }

  void _showPlantOptions(
      BuildContext context, List<PlantElement> plantOptions) {
    Get.bottomSheet(
      PlantOptionsBottomSheetWidget(
        isBottomSheetClosed: (isClose) {
          if (isClose) {
            isBottomSheetClosed(true);
          }
        },
        plantOptions: plantOptions,
      ),
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
    ).then((value) {
      if (value != null) {
        onSelectTopic(value);
        isSecondBottomSheet(true);
        isBottomSheetClosed(true);
      }
    });
  }
}
