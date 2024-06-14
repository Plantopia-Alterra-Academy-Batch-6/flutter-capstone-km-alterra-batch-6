import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
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
            style: TextStyleConstant.semiBold.copyWith(
                fontSize: 20,
                color: ColorConstant.neutral950,
                fontWeight: FontWeight.w900),
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
            blur: controller.isBottomSheetClosed.value ? 0 : 3,
            child: Container(
              color: Colors.black.withOpacity(0.6),
            ),
          );
        } else {
          return const SizedBox();
        }
      })),
    ]);
  }
}
