import 'package:flutter/material.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/image_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';

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
              //alignment: Alignment.bottomRight,
              bottom: -10,
              left: 70,
              child: Image.asset(
                ImageConstant.plantDummy,
                height: 130,
                width: 93,
              ),
              //     CachedNetworkImage(
              //   height: 130,
              //   width: 93,
              //   imageUrl: plantImageUrl,
              //   placeholder: (context, url) {
              //     return const CircularProgressIndicator();
              //   },
              //   errorWidget: (context, url, error) {
              //     return Icon(
              //       Icons.error,
              //       color: ColorConstant.danger500,
              //     );
              //   },
              // )
            ),
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
