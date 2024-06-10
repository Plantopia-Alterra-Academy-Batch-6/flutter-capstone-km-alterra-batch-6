import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:get/get.dart';
import 'package:plantopia/controllers/add_plant_controller.dart';

class PlantCategoryWidget extends StatelessWidget {
  PlantCategoryWidget({super.key});

  final controller = Get.put(AddPlantController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Plant Category",
          style: TextStyleConstant.title.copyWith(fontWeight: FontWeight.w700),
        ),
        Wrap(
            children: List.generate(
                controller.plantCategoriesResponse!.data.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(top: 12, right: 12, bottom: 12),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                // TODO: Search plant by category
              },
              child: Container(
                width: 158,
                height: 52,
                decoration: BoxDecoration(
                    border: Border.all(width: 0.3),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                              controller
                                  .plantCategoriesResponse!.data[index].imageUrl,
                            ),
                            fit: BoxFit
                                .cover, // Optional: Specify how the image should fit within the container
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        controller.plantCategoriesResponse!.data[index].name
                            .toString(),
                        style: TextStyleConstant.subtitle
                            .copyWith(color: ColorConstant.neutral950),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        })),
      ],
    );
  }
}
