import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:plantopia/utils/app_routes.dart';
import 'package:plantopia/views/chatbot/chatbot_view.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: ChatbotView(),
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: AppRoutes.chatbot,
          page: () => ChatbotView(),
        )
      ],
    );
  }
}
