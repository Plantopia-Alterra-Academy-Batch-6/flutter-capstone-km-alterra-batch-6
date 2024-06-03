part of '../home_view.dart';

class RecommendedWidget extends StatelessWidget {
  const RecommendedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 24,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'My Plant',
              style: TextStyleConstant.heading4.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "View More",
                style: TextStyleConstant.paragraph.copyWith(
                  color: ColorConstant.link500,
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        // TODO 1: Add PlantCategoryItemWidget
        // TODO 2: Add ListView.builder PlantCategoryItemWidget
        // TODO 3: Add PlantItemWidget
        // TODO 4: Add ListPlantItemWidget
      ],
    );
  }
}
