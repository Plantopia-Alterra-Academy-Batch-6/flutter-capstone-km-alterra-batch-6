import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/models/get_notification_response.dart';
import 'package:plantopia/service/notification_service.dart';
import 'package:plantopia/utils/status_enum_util.dart';

class NotificationController extends GetxController {
  RxList<Notif> listNotif = <Notif>[].obs;
  Rx<Status> notifStatus = Status.loading.obs;
  RxBool isSuccess = false.obs;
  var dateTime = DateTime.now().obs;
  var selectedOption = 1.obs;
  var notifDummy = ["A", "B", "C"].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    getAllNotification();
  }

  void setSelectedOption(int index) {
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
  Future<void> customizeWateringReminder(int id, String time, bool isRecurring, String type) async {
    try {
      await NotificationService.createCustomizeReminder(myPlantId: id, customizeTime: time, isRecurring: isRecurring, type: type);
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
}
