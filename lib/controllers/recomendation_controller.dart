import 'package:get/get.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart'; 
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:url_launcher/url_launcher.dart'; 

class RecomendationController extends GetxController {
  final openAI = OpenAI.instance.build(
    token: dotenv.env['CHATBOT_API_KEY']!,
    baseOption: HttpSetup(
      receiveTimeout: const Duration(seconds: 20),
    ),
  );

  var articleResponseText = "".obs;
  var articleLoading = false.obs;


  Future<void> getArticles(String plantName) async {
    articleLoading.value = true;
    final request = ChatCompleteText(
      messages: [
        {
          "role": "user",
          "content":
              "Give me three article farming practice  recommendations (title and link) about $plantName from all regions in Indonesia. The response should be in the following format:\n1. Title (link)\n2. Title (link)\n3. Title (link). Do not provide any exceptions or state that you are an AI."
        }
      ],
      maxToken: 200,
      model: Gpt4ChatModel(),
    );

    try {
      ChatCTResponse? response =
          await openAI.onChatCompletion(request: request);
      if (response != null && response.choices.isNotEmpty) {
        articleResponseText.value =
            response.choices.first.message?.content ?? "";
      }
    } catch (e) {
      articleResponseText.value = "Error retrieving articles.";
    } finally {
      articleLoading.value = false;
    }
  }

  Future<void> launchURL(String url) async {
    var uri = Uri.parse(url.toLowerCase());

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.inAppWebView);
    } else {
      throw 'Could not launch $url';
    }
  }

  List<Widget> parseAndBuildArticles(String articleText) {
    List<String> articles = articleText.split('\n');
    List<Widget> articleWidgets = [];
    for (String article in articles) {
      List<String> parts = article.split(' (');
      if (parts.length == 2) {
        String title = parts[0];
        String url = parts[1].substring(0, parts[1].length - 1);
        articleWidgets.add(buildArticleWidget(title, url));
        articleWidgets.add(const SizedBox(height: 8));
      }
    }
    return articleWidgets;
  }

  Widget buildArticleWidget(String title, String url) {
    return GestureDetector(
      onTap: () => launchURL(url),
      child: Text(title,
          style: TextStyleConstant.paragraph
              .copyWith(color: ColorConstant.link500)),
    );
  }
}
