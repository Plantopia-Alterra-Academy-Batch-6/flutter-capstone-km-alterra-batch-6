import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:plantopia/controllers/auth_controller.dart';
import 'package:plantopia/controllers/login_form_controller.dart';
import 'package:plantopia/views/auth/auth_view.dart';
import 'package:plantopia/views/auth/widgets/custom_auth_appbar_widget.dart';

void main() {
  group('AuthView Widget Tests', () {
    setUp(() {
      Get.put(LoginFormController());
      Get.put(AuthController());
    });

    testWidgets('should show CircularProgressIndicator when loading',
        (WidgetTester tester) async {
      final AuthController authController = Get.find();
      authController.isLoading.value = true;

      await tester.pumpWidget(
        const GetMaterialApp(
          home: AuthView(),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(CustomAuthAppbarWidget), findsNothing);
    });

    testWidgets('should show login and signup tabs when not loading',
        (WidgetTester tester) async {
      final AuthController authController = Get.find();
      authController.isLoading.value = false;

      await tester.pumpWidget(
        const GetMaterialApp(
          home: AuthView(),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(CustomAuthAppbarWidget), findsOneWidget);
      expect(find.text('Log in'), findsOneWidget);
      expect(find.text('Sign Up'), findsOneWidget);
    });

    testWidgets('should switch between login and signup tabs',
        (WidgetTester tester) async {
      final AuthController authController = Get.find();
      authController.isLoading.value = false;

      await tester.pumpWidget(
        const GetMaterialApp(
          home: AuthView(),
        ),
      );

      await tester.tap(find.text('Sign Up'));
      await tester.pumpAndSettle();

      expect(authController.authSection.value, 1);

      await tester.tap(find.text('Log in'));
      await tester.pumpAndSettle();

      expect(authController.authSection.value, 0);
    });
  });
}
