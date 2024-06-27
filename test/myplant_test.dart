import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:plantopia/controllers/my_plant_controller.dart';
import 'package:plantopia/views/my_plant/my_plant_view.dart';

void main() {
  setUpAll(() {
    Get.put(MyPlantController());
  });

  testWidgets('MyPlantView UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: MyPlantView(),
    ));

    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('My Plant'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'search query');
    await tester.pump(const Duration(milliseconds: 500));

    await tester.tap(find.byIcon(Icons.add_circle_outline));
    await tester.pumpAndSettle();
  });
}
