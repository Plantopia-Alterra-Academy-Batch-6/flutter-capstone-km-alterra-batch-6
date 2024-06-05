import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../constants/color_constant.dart';
import '../../../controllers/chatbot_controller.dart';

class IconButtonWidget extends StatelessWidget {
  final BuildContext context;
  final VoidCallback onPressed;
  final String icon;

  const IconButtonWidget({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.context,
  });

  @override
  Widget build(context) {
    final ChatbotController controller = Get.find<ChatbotController>();

    return Container(
      margin: const EdgeInsets.only(left: 8),
      width: 52,
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: controller.isSendButtonEnabled.value
                ? ColorConstant.primary500
                : const Color(0xFF9CA3AF),
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            icon: SvgPicture.asset(
              icon,
            ),
            onPressed: controller.isSendButtonEnabled.value ? onPressed : null,
          ),
        ),
      ),
    );
  }
}
