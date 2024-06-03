part of '../home_view.dart';

class PlantGuideFirstItemWidget extends StatelessWidget {
  const PlantGuideFirstItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: ColorConstant.primary50,
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
              color: ColorConstant.primary100,
            ),
            // TODO: Change the image path
            child: SvgPicture.asset(
              ImageConstant.g10,
              height: 24,
              width: 24,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Text(
            "Let’s get started by adding your first\nplant now!",
            style: TextStyleConstant.paragraph,
          ),
        ],
      ),
    );
  }
}
