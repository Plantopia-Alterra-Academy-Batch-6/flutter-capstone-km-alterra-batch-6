import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/icon_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/search_plant_controller.dart';
import 'package:plantopia/utils/app_routes.dart';

class SearchBarWidget extends StatelessWidget {
  SearchBarWidget({super.key});

  final controller = Get.put(SearchPlantController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: SearchBar(
                controller: controller.searchPlantText,
                backgroundColor: WidgetStateProperty.all(Colors.white),
                leading: SvgPicture.asset(
                  IconConstant.search,
                ),
                trailing: [
                  InkWell(
                    onTap: () {
                      controller.searchPlantText.clear();
                    },
                    child: const Icon(Icons.clear, color: Colors.black),
                  ),
                ],
                hintText: 'Enter search terms',
                hintStyle: WidgetStateProperty.all(
                  TextStyleConstant.paragraph,
                ),
                onSubmitted: (value) {
                  controller.searchPlant(controller.searchPlantText.text);
                },
                onTap: () {
                  controller.isFirstTimeOpen.value = true;
                },
                autoFocus: true,
                elevation: WidgetStateProperty.all(0),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide(
                      color: Colors.grey,
                      width: 0.3,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 20,
              height: 20,
              child: InkWell(
                borderRadius: BorderRadius.circular(180),
                onTap: () {
                  Get.toNamed(AppRoutes.plantFilter);
                },
                child: SvgPicture.asset(
                  IconConstant.filter,
                ),
              ),
            ),
          ],
        ),
        Obx(() {
          if (controller.isFirstTimeOpen.value &&
              controller.searchHistory.isNotEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: controller.searchHistory
                  .take(2)
                  .map((history) => ListTile(
                        dense: true,
                        title: Text(history),
                        titleTextStyle: TextStyleConstant.paragraph,
                        leading: SvgPicture.asset(
                            'assets/icons/search_history_icon.svg'),
                        onTap: () {
                          controller.searchPlant(history);
                          controller.searchPlantText.text = history;
                          controller.isFirstTimeOpen.value = false;
                        },
                      ))
                  .toList(),
            );
          } else {
            return const SizedBox.shrink();
          }
        }),
      ],
    );
  }
}
