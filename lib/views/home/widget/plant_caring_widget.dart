part of '../home_view.dart';

class PlantCaringWidget extends StatelessWidget {
  PlantCaringWidget({super.key});

  final MyPlantController myPlantController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (myPlantController.plantCaringStatus.value) {
        case Status.loading:
          return const Column(
            children: [
              SizedBox(
                height: 24,
              ),
              ShimmerContainerGlobalWidget(
                  width: double.infinity, height: 144, radius: 24),
            ],
          );
        case Status.loaded:
          return myPlantController.plantCaringData.isEmpty
              ? Column(
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
                    DottedBorder(
                      padding: const EdgeInsets.all(
                        16,
                      ),
                      color: ColorConstant.neutral300,
                      radius: const Radius.circular(16),
                      borderType: BorderType.RRect,
                      strokeWidth: 1.2,
                      dashPattern: const [11],
                      child: Center(
                        child: Column(
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
                  ],
                )
              : Column(
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
                    PlantCaringCardWidget(),
                  ],
                );
        case Status.error:
          return Container(
              width: 328,
              height: 144,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: Center(
                child: Text(
                  "Failed to get plant caring data",
                  style: TextStyleConstant.heading4.copyWith(
                    fontWeight: FontWeight.w700,
                    color: ColorConstant.danger500,
                  ),
                ),
              ));
        default:
          return const SizedBox.shrink();
      }
    });
  }
}
