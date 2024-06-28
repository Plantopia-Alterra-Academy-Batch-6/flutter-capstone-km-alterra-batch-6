import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/icon_constant.dart';
import 'package:get/get.dart';
import 'package:plantopia/controllers/my_plant_controller.dart';
import 'package:plantopia/utils/app_routes.dart';

class SearchBarWidget extends StatelessWidget {
  SearchBarWidget({super.key});

  final MyPlantController _myPlantController = Get.put(MyPlantController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 18,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 4.0,
          ),
          child: Row(
            children: [
              Expanded(
                child: SearchBar(
                  controller: _myPlantController.searchController,
                  backgroundColor: WidgetStateProperty.all(ColorConstant.white),
                  leading: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: SvgPicture.asset(
                      IconConstant.search,
                      height: 16,
                      width: 16,
                    ),
                  ),
                  trailing: [
                    Obx(
                      () => Visibility(
                          visible: _myPlantController.isActive.value &&
                              _myPlantController
                                  .searchController.text.isNotEmpty,
                          child: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _myPlantController.searchController.clear();
                                _myPlantController.isActive.value = false;
                                _myPlantController.isSearchFound.value = false;
                              })),
                    ),
                  ],
                  hintText: "Search",
                  hintStyle: WidgetStateProperty.all(
                    TextStyle(color: ColorConstant.neutral300),
                  ),
                  onChanged: (value) async {
                    if (value.isEmpty) {
                      _myPlantController.isSearchFound(false);
                    } else {
                      _myPlantController.isSearchFound(false);
                      await _myPlantController.searchPlant(value);
                    }
                    if (_myPlantController.searchController.text != "" ||
                        _myPlantController.searchController.text.isNotEmpty) {
                      _myPlantController.isActive.value = true;
                    } else {
                      _myPlantController.isActive.value = false;
                    }
                  },
                  onSubmitted: (value) async {
                    await _myPlantController.searchPlant(value);
                  },
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: const BorderSide(
                        color: Color(0xffD1D5DB),
                      ),
                    ),
                  ),
                  elevation: WidgetStateProperty.all(0),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.historyPlant);
                },
                child: SvgPicture.asset(
                  IconConstant.history,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}