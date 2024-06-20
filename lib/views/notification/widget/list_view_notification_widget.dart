import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/image_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/notification_controller.dart';
import 'package:plantopia/views/notification/widget/bottom_sheet1_widget.dart';

class ListViewNotificationWidget extends StatelessWidget {
  ListViewNotificationWidget({super.key});

  final NotificationController notifController =
      Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () async {
                await notifController.markAllAsRead();
              },
              child: Text(
                "Mark all as read",
                style: TextStyleConstant.paragraph.copyWith(
                  color: ColorConstant.primary500,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: notifController.listNotif.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: GestureDetector(
                    onTap: () async {
                      print(
                          "hello ${notifController.listNotif[index].plantId ?? -1}");
                      Get.bottomSheet(
                        BottomSheet1Widget(
                          notifId: notifController.listNotif[index].id ?? -1,
                          messages:
                              notifController.listNotif[index].body ?? "-",
                        ),
                      );
                      await notifController.getPlantDetails(
                        notifController.listNotif[index].plantId ?? -1,
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: ColorConstant.link50,
                          borderRadius: BorderRadius.circular(
                            16,
                          )),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              notifController.listNotif[index].isRead == false
                                  ? ImageConstant.waterDropletUnread
                                  : ImageConstant.waterDropletReaded,
                              width: 40,
                              height: 40,
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      notifController.listNotif[index].title ??
                                          "-",
                                      style:
                                          TextStyleConstant.paragraph.copyWith(
                                        fontWeight: FontWeight.w700,
                                      )),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    notifController.listNotif[index].body ??
                                        "-",
                                    style: TextStyleConstant.paragraph,
                                    maxLines: 2,
                                  )
                                ],
                              ),
                            ),
                            Text(
                              notifController.notifDate(
                                  notifController.listNotif[index].createdAt ??
                                      DateTime(-1)),
                              style: TextStyleConstant.caption.copyWith(
                                color: ColorConstant.neutral500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
