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
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 4.0,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _myPlantController.searchController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorConstant.neutral300,
                  ),
                  borderRadius: BorderRadius.circular(
                    8,
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorConstant.neutral300,
                  ),
                  borderRadius: BorderRadius.circular(
                    8,
                  ),
                ),
                hintText: "Search",
                prefixIconConstraints: const BoxConstraints(
                  minHeight: 16,
                  minWidth: 16,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: SvgPicture.asset(
                    IconConstant.search,
                  ),
                ),
                suffixIconConstraints: const BoxConstraints(
                  minHeight: 16,
                  minWidth: 16,
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: InkWell(
                    onTap: () {},
                    child: SvgPicture.asset(
                      IconConstant.filter,
                    ),
                  ),
                ),
              ),
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
    );
  }
}
