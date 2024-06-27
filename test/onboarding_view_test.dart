import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:plantopia/controllers/auth_controller.dart';
import 'package:plantopia/utils/app_routes.dart';
import 'package:plantopia/views/onboarding/onboarding_view.dart';
import 'package:plantopia/views/onboarding/widgets/carousel_widget.dart';

void main() {
  group('OnboardingView Widget Tests', () {
    setUp(() {
      Get.put(AuthController());
    });

    testWidgets('should display logo and language option',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const GetMaterialApp(
          home: OnboardingView(),
        ),
      );

      expect(find.text('EN'), findsOneWidget);
    });

    testWidgets('should display CarouselWidget', (WidgetTester tester) async {
      await tester.pumpWidget(
        const GetMaterialApp(
          home: OnboardingView(),
        ),
      );

      expect(find.byType(CarouselWidget), findsOneWidget);
    });

    testWidgets('should display Log in and Sign Up buttons',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const GetMaterialApp(
          home: OnboardingView(),
        ),
      );

      expect(find.text('Log in'), findsOneWidget);
      expect(find.text('Sign Up'), findsOneWidget);
    });

    testWidgets(
        'should navigate to auth page and set authSection when Log in button is pressed',
        (WidgetTester tester) async {
      final AuthController authController = Get.find();

      await tester.pumpWidget(
        GetMaterialApp(
          initialRoute: '/',
          getPages: [
            GetPage(name: '/', page: () => const OnboardingView()),
            GetPage(name: AppRoutes.auth, page: () => Container()),
          ],
        ),
      );

      await tester.tap(find.text('Log in'));
      await tester.pumpAndSettle();

      expect(authController.authSection.value, 0);
      expect(Get.currentRoute, AppRoutes.auth);
    });

    testWidgets(
        'should navigate to auth page and set authSection when Sign Up button is pressed',
        (WidgetTester tester) async {
      final AuthController authController = Get.find();

      await tester.pumpWidget(
        GetMaterialApp(
          initialRoute: '/',
          getPages: [
            GetPage(name: '/', page: () => const OnboardingView()),
            GetPage(name: AppRoutes.auth, page: () => Container()),
          ],
        ),
      );

      await tester.tap(find.text('Sign Up'));
      await tester.pumpAndSettle();

      expect(authController.authSection.value, 1);
      expect(Get.currentRoute, AppRoutes.auth);
    });
  });
}
