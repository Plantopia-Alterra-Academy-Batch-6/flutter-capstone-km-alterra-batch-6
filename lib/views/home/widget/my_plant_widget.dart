part of '../home_view.dart';

class MyPlantWidget extends StatelessWidget {
  const MyPlantWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      // TODO 1: Add Conditional with plant data
      // TODO 2: Add PlantItemWidget
      // TODO 3: Add ListPlantItemWidget
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 24,
        ),
        Text(
          'My Plant',
          style: TextStyleConstant.heading4.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
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
                ImageConstant.g10,
                height: 58,
                width: 58,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                "Let’s get started by adding\nyour first plant!",
                textAlign: TextAlign.center,
                style: TextStyleConstant.paragraph,
              ),
              const SizedBox(
                height: 12,
              ),
              InkWell(
                onTap: () {},
                child: Ink(
                  decoration: BoxDecoration(
                    color: ColorConstant.primary100,
                    borderRadius: BorderRadius.circular(
                      8,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(
                      14,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          IconConstant.add,
                          height: 20,
                          width: 20,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          "Add Plant",
                          style: TextStyleConstant.subtitle.copyWith(
                            color: ColorConstant.primary500,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
