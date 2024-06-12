part of '../home_view.dart';

class MyPlantWidget extends StatelessWidget {
  MyPlantWidget({super.key});

  final MyPlantController myPlantController = Get.put(MyPlantController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 24,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "My Plant",
              style: TextStyleConstant.heading4.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "View more",
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
        Obx(() {
          switch (myPlantController.myPlantData.value) {
            case Status.loading:
              return SizedBox(
                height: 200,
                width: double.infinity,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: myPlantController.listMyPlant.length,
                    itemExtent: 156,
                    itemBuilder: (context, int index) {
                      return const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: ShimmerContainerGlobalWidget(
                          width: 156,
                          height: 200,
                          radius: 24,
                        ),
                      );
                    }),
              );
            case Status.loaded:
              return SizedBox(
                height: 200,
                width: double.infinity,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: myPlantController.listMyPlant.length,
                    itemExtent: 156,
                    itemBuilder: (context, int index) {
                      return Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(AppRoutes.myPlantDetails, arguments: {
                                'myPlantDetails':
                                    myPlantController.listMyPlant[index]
                              })?.then((value) {
                                myPlantController.getMyPlant();
                              });
                            },
                            child: CardGlobalWidget(
                                plantName: myPlantController
                                        .listMyPlant[index].plant?.name ??
                                    "-",
                                plantCategory: myPlantController
                                        .listMyPlant[index]
                                        .plant
                                        ?.plantCategory
                                        ?.name ??
                                    "-",
                                plantImageUrl: myPlantController
                                        .listMyPlant[index]
                                        .plant
                                        ?.plantImages?[0]
                                        .fileName ??
                                    "-"),
                          ));
                    }),
              );
            case Status.error:
              return Text(
                "Failed to load my plant data",
                style: TextStyleConstant.heading4.copyWith(
                  color: ColorConstant.danger500,
                ),
              );

            default:
              return const EmptyMyPlantWidget();
          }
        }),
      ],
    );
  }
}
