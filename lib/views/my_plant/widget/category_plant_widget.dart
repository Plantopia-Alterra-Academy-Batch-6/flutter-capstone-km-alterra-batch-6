import 'package:flutter/material.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';

class CategoryPlantWidget extends StatelessWidget {
  const CategoryPlantWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
                  height: 35,
                  width: double.infinity,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, int index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                              border: index == 0
                                  ? Border.all(color: ColorConstant.primary500)
                                  : Border.all(
                                      color: ColorConstant.primary100,
                                    ),
                              color: index == 0
                                  ? ColorConstant.primary100
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(
                                50,
                              )),
                          child: Center(
                            child: Text(
                              "Angiosperms",
                              style: index == 0
                                  ? TextStyleConstant.paragraph.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: ColorConstant.primary500,
                                    )
                                  : TextStyleConstant.paragraph,
                            ),
                          ),
                        );
                      }),
                );
  }
}