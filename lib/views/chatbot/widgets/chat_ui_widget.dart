import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../constants/icon_constant.dart';
import '../../../constants/text_style_constant.dart';
import '../../../controllers/chatbot_controller.dart';
import 'message_text_widget.dart';
import '../../../constants/color_constant.dart';
import 'icon_button_widget.dart';
import 'typing_indicator_widget.dart';

class ChatUIWidget extends StatelessWidget {
  final ChatbotController controller = Get.put(ChatbotController());

  ChatUIWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: SizedBox());
      }
      return Container(
        margin: const EdgeInsets.only(
          right: 16,
          left: 16,
        ),
        child: DashChat(
          messageOptions: MessageOptions(
            showOtherUsersName: false,
            messagePadding: const EdgeInsets.only(
              left: 12,
              bottom: 8,
              right: 12,
              top: 8,
            ),
            showOtherUsersAvatar: false,
            messageDecorationBuilder: (message, previousMessage, nextMessage) =>
                BoxDecoration(
              color: message.user.id == controller.currentUser.id
                  ? ColorConstant.primary500
                  : const Color(0xFFECFDF5),
              borderRadius: BorderRadius.circular(8),
            ),
            messageTextBuilder: (message, previousMessage, nextMessage) =>
                MessageTextWidget(
              message: message,
              previousMessage: previousMessage,
              nextMessage: nextMessage,
              currentUser: controller.currentUser,
            ),
            textBeforeMedia: false,
          ),
          messageListOptions: MessageListOptions(
            typingBuilder: (user) => TypingIndicatorWidget(
              user: user,
              typingUsers: controller.typingUsers,
            ),
          ),
          scrollToBottomOptions: const ScrollToBottomOptions(
            disabled: true,
          ),
          inputOptions: InputOptions(
            inputMaxLines: 1,
            inputDecoration: InputDecoration(
              hoverColor: ColorConstant.primary500,
              focusColor: ColorConstant.white,
              enabled: true,
              filled: true,
              fillColor: ColorConstant.white,
              border: outlineInputBorder(),
              enabledBorder: outlineInputBorder(),
              disabledBorder: outlineInputBorder(),
              focusedBorder: outlineInputBorder(),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 14,
              ),
              hintText: 'Messages..',
              suffixIcon: IconButton(
                icon: SvgPicture.asset(
                  IconConstant.uploadPhoto,
                ),
                onPressed: controller.sendMediaMessage,
              ),
            ),
            inputTextStyle: TextStyleConstant.paragraph.copyWith(
              color: ColorConstant.neutral950,
            ),
            alwaysShowSend: true,
            cursorStyle: CursorStyle(
              color: ColorConstant.primary500,
            ),
            sendButtonBuilder: (Function() onSend) => IconButtonWidget(
              context: context,
              onPressed: onSend,
              icon: IconConstant.send,
            ),
            inputToolbarMargin: const EdgeInsets.only(
              top: 8,
              bottom: 8,
            ),
          ),
          currentUser: controller.currentUser,
          onSend: controller.sendMessage,
          messages: controller.messages.toList(),
          typingUsers: controller.typingUsers,
        ),
      );
    });
  }
}

InputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderSide: const BorderSide(
      width: 1,
      color: Color(0xFF6B7280),
    ),
    borderRadius: BorderRadius.circular(8),
  );
}
