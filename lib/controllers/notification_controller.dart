import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:plantopia/models/get_notification_response.dart';
import 'package:plantopia/models/get_plant_by_id_response.dart';
import 'package:plantopia/service/notification_service.dart';
import 'package:plantopia/utils/status_enum_util.dart';

class NotificationController extends GetxController {
  RxList<Notif> listNotif = <Notif>[].obs;
  Rx<Status> notifStatus = Status.loading.obs;
  Rx<Status> plantStatus = Status.loading.obs;
  RxBool isSuccess = false.obs;
  PlantByIdResponse? plantByIdResponse;

  var dateTime = DateTime.now().obs;
  var selectedOption = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    getAllNotification();
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

  Future<void> getAllNotification() async {
    try {
      notifStatus.value = Status.loading;
      final response = await NotificationService.getAllNotification();
      listNotif.value = response.data ?? [];
      notifStatus.value = Status.loaded;
    } catch (_) {
      notifStatus.value = Status.error;
    }
  }

  Future<void> getNotificationById(int id) async {
    try {
      notifStatus.value = Status.loading;
      await NotificationService.getNotificationById(id);
      notifStatus.value = Status.loaded;
    } catch (e) {
      notifStatus.value = Status.error;
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
}
