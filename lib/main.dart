import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:plantopia/service/firebase_messaging_service.dart';
import 'package:plantopia/utils/app_routes.dart';
import 'package:plantopia/views/add_plant/add_plant_view.dart';
import 'package:plantopia/views/allow_notif/allow_notif_view.dart';
import 'package:plantopia/views/auth/auth_google_view.dart';
import 'package:plantopia/views/auth/auth_view.dart';
import 'package:plantopia/views/chatbot/chatbot_view.dart';
import 'package:plantopia/views/forgot_password/forgot_password_view.dart';
import 'package:plantopia/views/forgot_password/set_new_password_view.dart';
import 'package:plantopia/views/global_widgets/bottom_navigation_bar_global_widget.dart';
import 'package:plantopia/views/history_plant/history_plant_view.dart';
import 'package:plantopia/views/my_plant/my_plant_view.dart';
import 'package:plantopia/views/my_plant_details/my_plant_details_view.dart';
import 'package:plantopia/views/notification/notification_view.dart';
import 'package:plantopia/views/onboarding/onboarding_view.dart';
import 'package:plantopia/views/plant_details/plant_details_view.dart';
import 'package:plantopia/views/plant_details/success_add_plant_view.dart';
import 'package:plantopia/views/plant_filter/plant_filter_view.dart';
import 'package:plantopia/views/plant_filter_result/plant_filter_result_view.dart';
import 'package:plantopia/views/plant_guide/plant_guide_view.dart';
import 'package:plantopia/views/search_plant/search_plant_view.dart';
import 'package:plantopia/views/splash_screen/splash_screen_view.dart';
import 'package:plantopia/views/upload_progress/upload_progress_view.dart';
import 'package:plantopia/views/verify/verify_view.dart';
import 'package:plantopia/views/watering_history/watering_history_view.dart';
import 'package:plantopia/views/weather/weather_view.dart';

import 'firebase_options.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessagingService.initialize();

  runApp(
    GetMaterialApp(
      getPages: [
        GetPage(
          name: AppRoutes.home,
          page: () => const BottomNavigationBarGlobalWidget(),
        ),
        GetPage(
          name: AppRoutes.weather,
          page: () => WeatherView(),
        ),
        GetPage(
          name: AppRoutes.splashApp,
          page: () => const SplashScreenView(),
        ),
        GetPage(
          name: AppRoutes.auth,
          page: () => const AuthView(),
        ),
        GetPage(
          name: AppRoutes.allowNotif,
          page: () => const AllowNotificationView(),
        ),
        GetPage(
          name: AppRoutes.onboarding,
          page: () => const OnboardingView(),
        ),
        GetPage(
          name: AppRoutes.myPlant,
          page: () => MyPlantView(),
        ),
        GetPage(
          name: AppRoutes.historyPlant,
          page: () => HistoryPlantView(),
        ),
        GetPage(
          name: AppRoutes.addPlant,
          page: () => AddPlantView(),
        ),
        GetPage(
          name: AppRoutes.searchPlant,
          page: () => SearchPlantView(),
        ),
        GetPage(
          name: AppRoutes.plantDetails,
          page: () => PlantDetailsView(),
        ),
        GetPage(
          name: AppRoutes.myPlantDetails,
          page: () => MyPlantDetailsView(),
        ),
        GetPage(
          name: AppRoutes.successAddPlant,
          page: () => const SuccessAddPlantView(),
        ),
        GetPage(
          name: AppRoutes.plantFilter,
          page: () => PlantFilterView(),
        ),
        GetPage(
          name: AppRoutes.chatbot,
          page: () => ChatbotView(),
        ),
        GetPage(
          name: AppRoutes.notification,
          page: () => NotificationView(),
        ),
        GetPage(
          name: AppRoutes.wateringHistory,
          page: () => WateringHistoryView(),
        ),
        GetPage(
          name: AppRoutes.plantFilterResult,
          page: () => PlantFilterResultView(),
        ),
        GetPage(
          name: AppRoutes.uploadProgress,
          page: () => UploadProgressView(),
        ),
        GetPage(
          name: AppRoutes.forgotPassword,
          page: () => const ForgotPasswordView(),
        ),
        GetPage(
          name: AppRoutes.verify,
          page: () => VerifyView(),
        ),
        GetPage(
          name: AppRoutes.setNewPassword,
          page: () => const SetNewPasswordView(),
        ),
        GetPage(
          name: AppRoutes.plantGuide,
          page: () => PlantGuideView(),
        ),
        GetPage(
          name: AppRoutes.authGoogle,
          page: () => const AuthGoogleView(),
        ),
      ],
      initialRoute: AppRoutes.splashApp,
    ),
  );
}
