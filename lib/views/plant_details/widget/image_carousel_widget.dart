import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/controllers/plant_details_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImageCarouselWidget extends StatelessWidget {
  ImageCarouselWidget({super.key});

  final controller = Get.put(PlantDetailsController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Stack(
          children: [
            CarouselSlider.builder(
              itemCount: controller.plantByIdResponse!.data!.plantImages?.length ?? 0,
              itemBuilder: (context, index, realIndex) {
                return Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/tomato_dummy.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                height: 380,
                viewportFraction: 1.0, // Ensure full-width images
                onPageChanged: (index, reason) {
                  controller.activeIndex.value = index;
                },
              ),
            ),
            Positioned(
              bottom: 55,
              left: 0,
              right: 0,
              child: Center(
                child: AnimatedSmoothIndicator(
                  activeIndex: controller.activeIndex.value,
                  count: controller.plantByIdResponse!.data!.plantImages?.length ?? 0,
                  effect: ScrollingDotsEffect(
                    activeDotColor: Colors.green,
                    dotColor: Colors.white.withOpacity(0.5),
                    dotHeight: 6,
                    dotWidth: 6,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
