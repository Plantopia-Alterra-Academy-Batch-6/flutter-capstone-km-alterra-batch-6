import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../views/chatbot/widgets/topic_choice_bottom_sheet_widget.dart';

class ChatbotController extends GetxController {
  final openAI = OpenAI.instance.build(
    token: dotenv.env['CHATBOT_API_KEY'],
    baseOption: HttpSetup(
      receiveTimeout: const Duration(seconds: 20),
    ),
  );

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
      isDismissible: false,
      enableDrag: false,
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

  void sendMessage(ChatMessage chatMessage) async {
    isSendButtonEnabled.value = false;
    messages.insert(0, chatMessage);
    typingUsers.add(plantBotUser);
    fullResponse.value = "";

    try {
      if (chatMessage.medias != null && chatMessage.medias!.isNotEmpty) {
        await sendMediaPrompt(chatMessage);
      } else {
        await sendTextPrompt(chatMessage);
      }
      typingUsers.remove(plantBotUser);
      isSendButtonEnabled.value = true;
    } catch (e) {
      isSendButtonEnabled.value = true;
    }
  }

  Future<void> sendTextPrompt(ChatMessage chatMessage) async {
    List<Map<String, dynamic>> messagesHistory =
        messages.reversed.toList().map((m) {
      return {
        "role": m.user == currentUser ? 'user' : 'assistant',
        "content": m.user == currentUser
            ? "Your role here is as an assistant that only answers questions related to '$topic' or plants. Please do not provide any information if the question is not about '$topic' or plants. Here is the question: ${m.text}"
            : m.text
      };
    }).toList();

    final request = ChatCompleteText(
      messages: messagesHistory,
      maxToken: 200,
      model: Gpt4ChatModel(),
    );

    ChatCTResponse? response = await openAI.onChatCompletion(request: request);
    for (var element in response!.choices) {
      if (element.message != null) {
        ChatMessage responseMessage = ChatMessage(
          user: plantBotUser,
          createdAt: DateTime.now(),
          text: element.message!.content,
        );
        messages.insert(0, responseMessage);
      }
    }
  }

  Future<void> sendMediaPrompt(ChatMessage chatMessage) async {
    try {
      String base64Image = '';
      List<Uint8List> images =
          await Future.wait(chatMessage.medias!.map((media) async {
        return await File(media.url).readAsBytes();
      }).toList());

      for (var image in images) {
        base64Image = base64Encode(image);
      }

      final request = ChatCompleteText(
        messages: [
          {
            "role": "user",
            "content": [
              {
                "type": "text",
                "text":
                    "Your role here is as an assistant that only answers questions related to '$topic' or plants. Please do not provide any information if the picture below is not related to '$topic'."
              },
              {
                "type": "image_url",
                "image_url": {"url": "data:image/jpeg;base64,$base64Image"}
              },
            ]
          }
        ],
        maxToken: 200,
        model: Gpt4VisionPreviewChatModel(),
      );

      ChatCTResponse? response =
          await openAI.onChatCompletion(request: request);
      for (var element in response!.choices) {
        if (element.message != null) {
          ChatMessage responseMessage = ChatMessage(
            user: plantBotUser,
            createdAt: DateTime.now(),
            text: element.message!.content,
          );
          messages.insert(0, responseMessage);
        }
      }
    } catch (e) {
      throw Exception(e);
    }
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
    }
  }
}
