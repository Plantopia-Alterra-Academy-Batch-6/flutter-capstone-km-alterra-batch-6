import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../constants/icon_constant.dart';
import '../../constants/text_style_constant.dart';
import '../../controllers/chatbot_controller.dart';
import 'widgets/chat_ui_widget.dart';

class ChatbotView extends StatelessWidget {
  final ChatbotController controller = Get.put(ChatbotController());

  ChatbotView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        extendBody: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: Text(
            "PlantBot",
            style: TextStyleConstant.boldText.copyWith(
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: SvgPicture.asset(
              IconConstant.back,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        backgroundColor: const Color(0xFFFFFFFF),
        body: ChatUIWidget(),
      ),
      Positioned.fill(child: Obx(() {
        if (!controller.isBottomSheetClosed.value) {
          return Blur(
            blur: controller.isBottomSheetClosed.value ? 0 : 5,
            child: Container(
              color: const Color(0x1A1C1DE5),
            ),
          );
        } else {
          return const SizedBox();
        }
      })),
    ]);
  }
}
