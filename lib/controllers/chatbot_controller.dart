import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../views/chatbot/widgets/topic_choice_bottom_sheet_widget.dart';

class ChatbotController extends GetxController {
  final Gemini gemini = Gemini.instance;

  var isLoading = false.obs;
  var messages = <ChatMessage>[].obs;
  var typingUsers = <ChatUser>[].obs;
  var currentUser = ChatUser(id: "0");
  var plantBotUser = ChatUser(id: "1", firstName: 'PlantBot');
  var fullResponse = "".obs;
  var topic = "Plant".obs;
  var isSendButtonEnabled = true.obs;
  var isBottomSheetClosed = false.obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showTopicChoice();
    });
  }

  void _showTopicChoice() {
    Get.bottomSheet(
      TopicChoiceBottomSheet(
        onSelectTopic: (selectedTopic) {
          topic.value = selectedTopic;
        },
        isSecondBottomSheet: (isSecondBottomSheet) {
          isBottomSheetClosed.value = isSecondBottomSheet;
          ChatMessage chatMessage = ChatMessage(
            user: currentUser,
            text: isSecondBottomSheet
                ? 'Hi, PlantBot!, I need some help with my ${topic.value} plant'
                : 'Hi, PlantBot!, I want to ${topic.value}',
            createdAt: DateTime.now(),
          );
          sendMessage(chatMessage);
        },
        isBottomSheetClosed: (isClose) {
          isBottomSheetClosed.value = isClose;
        },
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void sendMessage(ChatMessage chatMessage) {
    isSendButtonEnabled.value = false;
    messages.insert(0, chatMessage);
    typingUsers.add(plantBotUser);
    fullResponse.value = "";

    Completer<void> completer = Completer<void>();

    try {
      String questionPrefix =
          "Topiknya mengenai '${topic.value}' pertanyaannya: ";
      String question = questionPrefix + chatMessage.text;
      List<Uint8List>? images;
      if (chatMessage.medias?.isNotEmpty ?? false) {
        images = [
          File(chatMessage.medias!.first.url).readAsBytesSync(),
        ];
      }
      gemini.streamGenerateContent(question, images: images).listen((event) {
        fullResponse.value += event.content?.parts?.fold(
                "", (previous, current) => "$previous ${current.text}") ??
            "";
        update();
      }, onDone: () {
        ChatMessage message = ChatMessage(
          user: plantBotUser,
          createdAt: DateTime.now(),
          text: fullResponse.value,
        );
        messages.insert(0, message);
        typingUsers.remove(plantBotUser);
        update();
        isSendButtonEnabled.value = true;
      }, onError: (error) {
        completer.completeError(error);
        update();
        isSendButtonEnabled.value = true;
      });
    } catch (e) {
      isSendButtonEnabled.value = true;
    }
  }

  void handleUserTyping(String text) {
    if (text.isNotEmpty && !typingUsers.contains(currentUser)) {
      typingUsers.add(currentUser);
    } else if (text.isEmpty && typingUsers.contains(currentUser)) {
      typingUsers.remove(currentUser);
    }
    update();
  }

  void sendMediaMessage() async {
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (file != null) {
      ChatMessage chatMessage = ChatMessage(
        user: currentUser,
        createdAt: DateTime.now(),
        medias: [
          ChatMedia(
            url: file.path,
            fileName: "",
            type: MediaType.image,
          )
        ],
      );
      sendMessage(chatMessage);
      update();
    }
  }
}
