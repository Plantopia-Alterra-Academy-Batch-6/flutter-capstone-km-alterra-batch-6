import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/notification_controller.dart';
import 'package:plantopia/utils/status_enum_util.dart';
import 'package:plantopia/views/global_widgets/shimmer_container_global_widget.dart';
import 'package:plantopia/views/notification/widget/delete_notification_widget.dart';
import 'package:plantopia/views/notification/widget/empty_notification_widget.dart';
import 'package:plantopia/views/notification/widget/list_view_notification_widget.dart';

class NotificationView extends StatelessWidget {
  NotificationView({super.key});

  final NotificationController notifController =
      Get.put(NotificationController());
  final int selectedOption = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: ColorConstant.white,
        title: Text(
          "Notification",
          style: TextStyleConstant.heading4.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actions: [
          Obx(() => notifController.listNotif.isNotEmpty
              ? DeleteNotificationWidget()
              : const SizedBox()),
          const SizedBox(
            width: 16,
          )
        ],
      ),
      body: Obx(() {
        switch (notifController.notifStatus.value) {
          case Status.loading:
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        return const Padding(
                            padding: EdgeInsets.only(bottom: 8.0),
                            child: ShimmerContainerGlobalWidget(
                              height: 102,
                              width: double.infinity,
                              radius: 16,
                            ));
                      },
                    ),
                  )
                ],
              ),
            );
          case Status.loaded:
            return notifController.listNotif.isEmpty
                ? const EmptyNotificationWidget()
                : ListViewNotificationWidget();
          case Status.error:
            return Expanded(
              child: Center(
                child: Text(
                  "Failed to load notification data",
                  style: TextStyleConstant.heading4.copyWith(
                    fontWeight: FontWeight.w700,
                    color: ColorConstant.warning500,
                  ),
                ),
              ),
            );
          default:
            return const SizedBox();
        }
      }),
    );
  }
}
