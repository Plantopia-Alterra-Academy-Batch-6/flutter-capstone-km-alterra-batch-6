import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/image_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/my_plant_controller.dart';
import 'package:plantopia/models/get_notification_response.dart';
import 'package:plantopia/models/get_plant_by_id_response.dart';
import 'package:plantopia/service/notification_service.dart';
import 'package:plantopia/service/watering_history_service.dart';
import 'package:plantopia/utils/status_enum_util.dart';
import 'package:plantopia/views/my_plant_details/widget/button_widget.dart';

class NotificationController extends GetxController {
  RxList<Notif> listNotif = <Notif>[].obs;
  Rx<Status> notifStatus = Status.loading.obs;
  Rx<Status> plantStatus = Status.loading.obs;
  RxBool isSuccess = false.obs;
  PlantByIdResponse? plantByIdResponse;
  Rx<DateTime> dateTime = DateTime.now().obs;
  var selectedOption = false.obs;

  final MyPlantController myPlantController = Get.find();

  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 5), () {
      lateWatering();
    });
    super.onInit();
  }

  Future<void> markAllAsRead() async {
    for (var value in listNotif) {
      await getNotificationById(value.id ?? -1);
    }
    await getAllNotification();
  }

  String formatTime(DateTime dateTime) {
    return DateFormat.Hm().format(dateTime);
  }

  String extractPlantName(String input) {
    int index = input.indexOf('-');
    if (index != -1) {
      return input.substring(0, index).trim();
    } else {
      return input.trim();
    }
  }

  String extractFamilyName(String input) {
    int index = input.indexOf('-');
    if (index != -1) {
      return input.substring(index + 1).trim();
    } else {
      return '';
    }
  }

  String snackBarReminder(DateTime time) {
    DateTime now = DateTime.now();
    Duration difference = now.difference(time);

    int hours = difference.inHours;
    int minutes = difference.inMinutes;
    if (hours.isNegative) {
      hours = hours < 0 ? -hours : hours;
      return '$hours hour';
    } else if (hours != 0) {
      hours = hours < 0 ? -hours : hours;
      hours = 24 - hours;
      return "$hours hour";
    }
    minutes = minutes < 0 ? -minutes : minutes;
    return "$minutes minutes";
  }

  String notifDate(DateTime notifDate) {
    String notifAge = "";
    DateTime now = DateTime.now();
    Duration difference = now.difference(notifDate);

    int years = difference.inDays ~/ 365;
    int months = (difference.inDays % 365) ~/ 30;
    int weeks = ((difference.inDays % 365) % 30) ~/ 7;
    int days = ((difference.inDays % 365) % 30) % 7;
    int hours = difference.inHours;
    int minutes = difference.inMinutes.remainder(60);
    int seconds = difference.inSeconds.remainder(60);

    if (years > 0) {
      notifAge = '${years}d';
    } else if (months > 0) {
      notifAge = '${months}m';
    } else if (weeks > 0) {
      notifAge = '${weeks}w ';
    } else if (days > 0) {
      notifAge = '${days}d';
    } else if (hours > 0) {
      notifAge = '${hours}h';
    } else if (minutes > 0) {
      notifAge = '${minutes}m';
    } else if (seconds > 0) {
      notifAge = '${seconds}s';
    }
    return notifAge;
  }

  String parseHour(String wateringSchedule) {
    DateTime time = DateFormat.Hm().parse(wateringSchedule);

    DateFormat formatter = DateFormat('hh:mm a');

    String formattedTime = formatter.format(time);

    return formattedTime;
  }

  void setSelectedOption(bool index) {
    selectedOption.value = index;
  }

  Future<List<Notif>> reverseList(List<Notif> list) async {
    int length = list.length;
    for (int i = 0; i < length ~/ 2; i++) {
      Notif temp = list[i];
      list[i] = list[length - 1 - i];
      list[length - 1 - i] = temp;
    }
    return list;
  }

  Future<void> getAllNotification() async {
    try {
      notifStatus.value = Status.loading;
      final response = await NotificationService.getAllNotification();
      final List<Notif> resultData = await reverseList(response.data ?? []);
      listNotif.value = resultData;
      notifStatus.value = Status.loaded;
    } catch (_) {
      notifStatus.value = Status.error;
    }
  }

  Future<void> getNotificationById(int id) async {
    try {
      await NotificationService.getNotificationById(id);
      final response = await NotificationService.getAllNotification();
      final List<Notif> resultData = await reverseList(response.data ?? []);
      listNotif.value = resultData;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> deleteAllNotification() async {
    try {
      await NotificationService.deleteAllNotification();
    } catch (e) {
      Get.defaultDialog(
        title: "Error",
        middleText: "Failed to add plant, please try again!",
        textConfirm: "OK",
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back();
        },
      );
    }
  }

  Future<void> customizeWateringReminder(
      int id, String time, bool isRecurring, String type) async {
    try {
      await NotificationService.createCustomizeReminder(
          myPlantId: id,
          customizeTime: time,
          isRecurring: isRecurring,
          type: type);
    } catch (e) {
      Get.defaultDialog(
        title: "Error",
        middleText: "Failed to add customize reminder, please try again!",
        textConfirm: "OK",
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back();
        },
      );
    }
  }

  Future<void> getPlantDetails(int plantId) async {
    try {
      plantStatus.value = Status.loading;
      plantByIdResponse = await NotificationService.getPlantById(plantId);
      plantStatus.value = Status.loaded;
    } catch (e) {
      plantStatus.value = Status.error;
      throw Exception(e);
    }
  }

  Future<void> postWatering(int plantId) async {
    try {
      await WateringHistoryService.postWatering(plantId);
    } catch (e) {
      Get.defaultDialog(
        title: "Error",
        middleText: "Failed to watering plant, please try again!",
        textConfirm: "OK",
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back();
        },
      );
    }
  }

  Future<void> lateWatering() async {
    final response = await NotificationService.getLateWatering();
    await getAllNotification();

    for (var value in listNotif) {
      if (value.id == response.data?.id && value.isRead == false) {
        Get.dialog(
            barrierDismissible: false,
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 472,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: ColorConstant.white),
                  child: Column(
                    children: [
                      CachedNetworkImage(
                        width: double.infinity,
                        height: 200,
                        imageUrl:
                            response.data?.plant?.plantImage?[0].fileName ??
                                "-",
                        errorWidget: (context, url, error) {
                          return Icon(
                            Icons.error,
                            color: ColorConstant.danger500,
                          );
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        response.data?.title ?? "-",
                        style: TextStyleConstant.heading4.copyWith(
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.none),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        response.data?.body ?? "-",
                        style: TextStyleConstant.paragraph
                            .copyWith(decoration: TextDecoration.none),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ButtonWidget(
                        onTap: () async {
                          Get.back();
                          await getNotificationById(value.id ?? -1);
                          await postWatering(value.plantId ?? -1);
                          Get.dialog(Center(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              height: 323,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      ImageConstant.successWatering,
                                      height: 200,
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Text("Hurray! 💦",
                                        style:
                                            TextStyleConstant.heading4.copyWith(
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.w700,
                                        )),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      "Your plant has been watered!\nKeep up the good care! 🙌",
                                      style: TextStyleConstant.paragraph
                                          .copyWith(
                                              decoration: TextDecoration.none),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ));
                        },
                        buttonName: "Watered",
                        boxDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: ColorConstant.primary500),
                        textStyle: TextStyleConstant.subtitle.copyWith(
                            color: ColorConstant.white,
                            decoration: TextDecoration.none),
                      ),
                      ButtonWidget(
                        onTap: () {
                          Get.back();
                        },
                        buttonName: "Remind me later",
                        boxDecoration: BoxDecoration(
                          color: ColorConstant.white,
                        ),
                        textStyle: TextStyleConstant.subtitle.copyWith(
                            color: ColorConstant.primary500,
                            decoration: TextDecoration.none),
                      ),
                    ],
                  ),
                ),
              ),
            ));
        break;
      }
    }
  }
}
