import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:plantopia/controllers/bottom_navigation_bar_controller.dart';
import 'package:plantopia/views/home/home_view.dart';
import 'package:plantopia/views/weather/weather_view.dart';

class BottomNavigationBarGlobalWidget extends StatelessWidget {
  const BottomNavigationBarGlobalWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(
      BottomNavigationBarController(),
    );
    return Scaffold(
      body: Obx(() {
        final controller = Get.find<BottomNavigationBarController>();
        return IndexedStack(
          index: controller.currentIndex.value,
          children: [
            const HomeView(),
            WeatherView(),
          ],
        );
      }),
      bottomNavigationBar: Obx(() {
        final controller = Get.find<BottomNavigationBarController>();
        return BottomNavigationBar(
          backgroundColor: Theme.of(
            context,
          ).colorScheme.primary,
          currentIndex: controller.currentIndex.value,
          onTap: (
            index,
          ) {
            controller.setCurrentIndex(
              index,
            );
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Theme.of(
                  context,
                ).colorScheme.outlineVariant,
              ),
              label: 'Home',
              activeIcon: Icon(
                Icons.home,
                color: Theme.of(
                  context,
                ).colorScheme.onPrimary,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search_rounded,
                color: Theme.of(
                  context,
                ).colorScheme.outlineVariant,
              ),
              label: 'Weather',
              activeIcon: Icon(
                Icons.search_rounded,
                color: Theme.of(
                  context,
                ).colorScheme.onPrimary,
              ),
            ),
          ],
          selectedItemColor: Theme.of(
            context,
          ).colorScheme.onPrimary,
          unselectedItemColor: Theme.of(
            context,
          ).colorScheme.outlineVariant,
        );
      }),
    );
  }
}