import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/icon_constant.dart';

import 'package:plantopia/controllers/bottom_navigation_bar_controller.dart';
import 'package:plantopia/views/global_widgets/bottom_navigation_icon_global_widget.dart';
import 'package:plantopia/views/home/home_view.dart';
import 'package:plantopia/views/my_plant/my_plant_view.dart';
import 'package:plantopia/views/profile/profile_view.dart';
import 'package:plantopia/views/weather/weather_view.dart';
import 'package:plantopia/controllers/weather_controller.dart';

// ignore: must_be_immutable
class BottomNavigationBarGlobalWidget extends StatelessWidget {
  final int? index;

  const BottomNavigationBarGlobalWidget({
    super.key,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBarController controller =
        Get.put(BottomNavigationBarController());

    final WeatherController weatherController = Get.put(WeatherController());

    controller.setCurrentIndex(index ?? 0);

    return Scaffold(
      body: Obx(() {
        return IndexedStack(
          index: controller.currentIndex.value,
          children: [
            HomeView(),
            WeatherView(),
            MyPlantView(),
            const ProfileView()
          ],
        );
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          backgroundColor: ColorConstant.white,
          currentIndex: controller.currentIndex.value,
          onTap: (index) {
            controller.setCurrentIndex(index);

            if (index == 1) {
              weatherController.initLocationAndWeatherData();
            }
          },
          elevation: 0.0,
          type: BottomNavigationBarType.fixed,
          items: [
            _buildBottomNavigationBarItem(
              iconAssetPath: IconConstant.home,
              selectedIconAssetPath: IconConstant.homeSelected,
              label: 'Home',
              index: 0,
              controller: controller,
            ),
            _buildBottomNavigationBarItem(
              iconAssetPath: IconConstant.weatherSunCloudy,
              selectedIconAssetPath: IconConstant.weatherSelected,
              label: 'Weather',
              index: 1,
              controller: controller,
            ),
            _buildBottomNavigationBarItem(
              iconAssetPath: IconConstant.potPlant,
              selectedIconAssetPath: IconConstant.potPlantSelected,
              label: 'My Plant',
              index: 2,
              controller: controller,
            ),
            _buildBottomNavigationBarItem(
              iconAssetPath: IconConstant.profileNavbar,
              selectedIconAssetPath: IconConstant.profileNavbarSelected,
              label: 'Profile',
              index: 3,
              controller: controller,
            ),
          ],
        );
      }),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem({
    required String iconAssetPath,
    required String selectedIconAssetPath,
    required String label,
    required int index,
    required BottomNavigationBarController controller,
  }) {
    return BottomNavigationBarItem(
      icon: BottomNavigationIconWidget(
        iconAssetPath: controller.currentIndex.value == index
            ? selectedIconAssetPath
            : iconAssetPath,
        label: label,
        index: index,
        controller: controller,
      ),
      label: '',
    );
  }
}
