part of '../home_view.dart';

class PlantGuideSecondItemWidget extends StatelessWidget {
  const PlantGuideSecondItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: ColorConstant.link50,
        borderRadius: BorderRadius.circular(
          16,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(
              8,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                8,
              ),
              color: ColorConstant.link100,
            ),
            child: Image.asset(
              ImageConstant.water,
              height: 24,
              width: 24,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Text(
            "Don’t forget to water your plant based\non our reminder!",
            style: TextStyleConstant.paragraph,
          ),
        ],
      ),
    );
  }
}
