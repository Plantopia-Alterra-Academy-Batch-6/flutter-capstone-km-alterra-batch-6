part of '../home_view.dart';

class PlantGuideWidget extends StatelessWidget {
  const PlantGuideWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 24,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Text(
                'Plant Guide',
                style: TextStyleConstant.heading4.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              // TODO 1: Add DotIndicatorWidget
            ],
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        SizedBox(
          height: 76,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            // TODO 2: Make it full width
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: const [
              PlantGuideFirstItemWidget(),
              SizedBox(
                width: 8,
              ),
              PlantGuideSecondItemWidget(),
              SizedBox(
                width: 8,
              ),
              PlantGuideThirdItemWidget(),
            ],
          ),
        ),
      ],
    );
  }
}
