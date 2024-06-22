part of '../home_view.dart';

class PlantCaringWidget extends StatelessWidget {
  const PlantCaringWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 24,
        ),
        Text(
          'Plant Caring',
          style: TextStyleConstant.heading4.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        // TODO: Make it conditional with plant data
        SizedBox(
          width: double.infinity,
          height: 160,
          child: DottedBorder(
            padding: const EdgeInsets.all(
              24,
            ),
            color: ColorConstant.neutral300,
            radius: const Radius.circular(6),
            borderType: BorderType.RRect,
            strokeWidth: 1.2,
            dashPattern: const [11],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    ImageConstant.emptyPlantCaring,
                    height: 60,
                    width: 60,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "No plants added yet! \nAdd your first plant to begin",
                    textAlign: TextAlign.center,
                    style: TextStyleConstant.paragraph,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
