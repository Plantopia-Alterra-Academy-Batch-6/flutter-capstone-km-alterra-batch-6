import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/plant_history_controller.dart';

class FilterButtonWidget extends StatelessWidget {
  FilterButtonWidget({super.key});

  final PlantHistoryController plantHistoryController = Get.find();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      padding: EdgeInsets.zero, 
      position: PopupMenuPosition.under,
      color: ColorConstant.white,
      icon: Icon(Icons.filter_list, color: ColorConstant.neutral950),
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            padding: EdgeInsets.zero,
            value: 1,
            child: Center(
              child: Text(
                'Latest',
                style: TextStyleConstant.subtitle
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          PopupMenuItem(
            height: 40,
            value: 2,
            child: Center(
              child: Text('Oldest',
                  style: TextStyleConstant.subtitle
                      .copyWith(fontWeight: FontWeight.w600)),
            ),
          ),
          PopupMenuItem(
            height: 40,
            value: 3,
            child: Center(
              child: Text('A to Z',
                  style: TextStyleConstant.subtitle
                      .copyWith(fontWeight: FontWeight.w600)),
            ),
          ),
          PopupMenuItem(
            height: 40,
            value: 4,
            child: Center(
              child: Text('Z to A',
                  style: TextStyleConstant.subtitle
                      .copyWith(fontWeight: FontWeight.w600)),
            ),
          ),
        ];
      },
      onSelected: (value) {
        switch (value) {
          case 1:
            plantHistoryController.isFiltering.value = false;
            break;
          case 2:
            plantHistoryController.getPlantingHistory();
            break;
          case 3:
            plantHistoryController.sortAtoZ();
            break;
          case 4:
            plantHistoryController.sortZtoA();
            break;
          default:
        }
        if (kDebugMode) {
          print('You selected filter: $value');
        }
      },
    );
  }
}
