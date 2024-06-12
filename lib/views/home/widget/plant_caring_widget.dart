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
        Container(
          padding: const EdgeInsets.all(
            16,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: ColorConstant.neutral300,
            ),
            borderRadius: BorderRadius.circular(
              16,
            ),
          ),
          alignment: Alignment.center,
          child: Column(
            children: [
              SvgPicture.asset(
                ImageConstant.g11,
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
      ],
    );
  }
}
