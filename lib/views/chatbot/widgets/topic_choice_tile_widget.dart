import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/controllers/my_plant_details_controller.dart';
import 'package:plantopia/views/global_widgets/shimmer_container_global_widget.dart';

import '../../../constants/text_style_constant.dart';

class TopicChoiceTileWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final VoidCallback onTap;
  final String imgUrl;

  const TopicChoiceTileWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.onTap,
    required this.imgUrl,
  });

  @override
  Widget build(BuildContext context) {
    final MyPlantDetailsController myPlantDetailsController =
        Get.put(MyPlantDetailsController());
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFD1D5DB),
            width: 1,
          ),
        ),
        clipBehavior: Clip.hardEdge,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              child: Container(
                  width: 78,
                  height: double.infinity,
                  margin: const EdgeInsets.only(right: 12),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: imgUrl,
                    placeholder: (context, url) {
                      return const ShimmerContainerGlobalWidget(
                          width: double.infinity,
                          height: double.infinity,
                          radius: 8);
                    },
                    errorWidget: (context, url, error) {
                      return Center(
                        child: Icon(
                          Icons.error,
                          color: ColorConstant.danger500,
                        ),
                      );
                    },
                  )),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    myPlantDetailsController.extractPlantName(
                        myPlantDetailsController.filterHtmlTag(title)),
                    textAlign: TextAlign.left,
                    style: TextStyleConstant.subtitle.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 38,
                    child: Text(
                      myPlantDetailsController.filterHtmlTag(subTitle),
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      style: TextStyleConstant.caption.copyWith(
                        fontSize: 12,
                        color: ColorConstant.neutral500,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
