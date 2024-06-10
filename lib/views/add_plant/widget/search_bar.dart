import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantopia/constants/icon_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:get/get.dart';
import 'package:plantopia/utils/app_routes.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.searchPlant);
            },
            child: AbsorbPointer(
              child: SearchBar(
                backgroundColor: WidgetStateProperty.all(Colors.white),
                trailing: [
                  InkWell(
                    child: SvgPicture.asset(
                      IconConstant.search,
                    ),
                  ),
                ],
                hintText: 'Enter search terms',
                hintStyle: WidgetStateProperty.all(
                  TextStyleConstant.paragraph,
                ),
                elevation: WidgetStateProperty.all(0),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide(
                      color: Color.fromARGB(255, 12, 12, 12),
                      width: 0.3,
                    ),
                  ),
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
            onTap: () {},
            child: SvgPicture.asset(
              IconConstant.filter,
            ),
          ),
        ),
      ],
    );
  }
}
