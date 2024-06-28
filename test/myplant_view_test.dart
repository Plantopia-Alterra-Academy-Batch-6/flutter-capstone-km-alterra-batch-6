import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:plantopia/controllers/my_plant_controller.dart';
import 'package:plantopia/utils/app_routes.dart';
import 'package:plantopia/views/global_widgets/recommended_widget.dart';
import 'package:plantopia/views/my_plant/my_plant_view.dart';
import 'package:plantopia/views/my_plant/widget/my_plant_list_widget.dart';
import 'package:plantopia/views/my_plant/widget/search_bar_widget.dart';
import 'package:plantopia/views/my_plant/widget/single_result_widget.dart';

void main() {
  group('MyPlantView Widget Tests', () {
    setUp(() {
      Get.lazyPut<MyPlantController>(() => MyPlantController());
    });

    testWidgets('should display the heading and number of plants',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          home: MyPlantView(),
        ),
      );

      expect(find.text('My Plant'), findsOneWidget);
    });

    testWidgets('should display SearchBarWidget', (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          home: MyPlantView(),
        ),
      );

      expect(find.byType(SearchBarWidget), findsOneWidget);
    });

    testWidgets('should display SingleResultWidget when search is found',
        (WidgetTester tester) async {
      final MyPlantController myPlantController = Get.find<MyPlantController>();
      myPlantController.isSearchFound.value = true;
      myPlantController.searchController.text = "Plant";

      await tester.pumpWidget(
        GetMaterialApp(
          home: MyPlantView(),
        ),
      );

      expect(find.byType(SingleResultWidget), findsOneWidget);
      expect(find.byType(MyPlantListWidget), findsNothing);
    });

    testWidgets('should display MyPlantListWidget when search is not found',
        (WidgetTester tester) async {
      final MyPlantController myPlantController = Get.find<MyPlantController>();
      myPlantController.isSearchFound.value = false;
      myPlantController.searchController.text = "";

      await tester.pumpWidget(
        GetMaterialApp(
          home: MyPlantView(),
        ),
      );

      expect(find.byType(SingleResultWidget), findsNothing);
      expect(find.byType(MyPlantListWidget), findsOneWidget);
    });

    testWidgets('should display RecommendedWidget',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          home: MyPlantView(),
        ),
      );

      expect(find.byType(RecommendedWidget), findsOneWidget);
    });

    testWidgets(
        'should show FloatingActionButton and navigate to add plant page',
        (WidgetTester tester) async {
      final MyPlantController myPlantController = Get.find<MyPlantController>();
      myPlantController.showFloatingButton.value = true;

      await tester.pumpWidget(
        GetMaterialApp(
          initialRoute: '/',
          getPages: [
            GetPage(name: '/', page: () => MyPlantView()),
            GetPage(name: AppRoutes.addPlant, page: () => Container()),
          ],
        ),
      );

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      expect(Get.currentRoute, AppRoutes.addPlant);
    });
  });
}
