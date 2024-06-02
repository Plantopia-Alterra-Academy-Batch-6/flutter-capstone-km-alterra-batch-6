import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController locationController = Get.put(HomeController());

    return Scaffold(
      body: Center(
        child: Obx(() {
          if (!locationController.locationPermissionGranted.value) {
            return const Text('Permission not granted');
          }

          if (locationController.userLocation.value == null) {
            return const CircularProgressIndicator();
          }

          final position = locationController.userLocation.value;
          return Text(
              'Location: ${position?.latitude}, ${position?.longitude}');
        }),
      ),
    );
  }
}
