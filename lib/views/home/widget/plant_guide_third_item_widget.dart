part of '../home_view.dart';

class PlantGuideThirdItemWidget extends StatelessWidget {
  const PlantGuideThirdItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: ColorConstant.warning50,
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
              color: ColorConstant.warning100,
            ),
            child: Image.asset(
              ImageConstant.sun,
              height: 24,
              width: 24,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Text(
            "Some plants love sun! So if your plant\ndo, just let them enjoy the sun~",
            style: TextStyleConstant.paragraph,
          ),
        ],
      ),
    );
  }
}
