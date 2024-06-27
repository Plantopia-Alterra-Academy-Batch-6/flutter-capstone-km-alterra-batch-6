import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/views/global_widgets/shimmer_container_global_widget.dart';

class CardGlobalWidget extends StatelessWidget {
  const CardGlobalWidget(
      {super.key,
      required this.plantName,
      required this.plantCategory,
      required this.plantImageUrl});
  final String plantName;
  final String plantCategory;
  final String plantImageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 156,
      height: 200,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: ColorConstant.neutral200,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            Positioned(
                bottom: -10,
                left: 70,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  height: 130,
                  width: 93,
                  imageUrl: plantImageUrl,
                  placeholder: (context, url) {
                    return const ShimmerContainerGlobalWidget(
                        width: double.infinity,
                        height: double.infinity,
                        radius: 16);
                  },
                  errorWidget: (context, url, error) {
                    return Icon(
                      Icons.error,
                      color: ColorConstant.danger500,
                    );
                  },
                )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 100,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.00, -1.00),
                    end: Alignment(0, 1),
                    colors: [Color(0x0010B981), Color(0x1910B981)],
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 23),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plantName,
                    style: TextStyleConstant.subtitle.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    plantCategory,
                    style: TextStyleConstant.footer.copyWith(
                      color: ColorConstant.neutral400,
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
