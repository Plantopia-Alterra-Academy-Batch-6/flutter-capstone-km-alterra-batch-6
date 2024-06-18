import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/icon_constant.dart';
import 'package:plantopia/constants/image_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/notification_controller.dart';
import 'package:plantopia/utils/status_enum_util.dart';
import 'package:plantopia/views/global_widgets/shimmer_container_global_widget.dart';
import 'package:plantopia/views/my_plant_details/widget/button_widget.dart';
import 'package:plantopia/views/notification/widget/bottom_sheet1_widget.dart';

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
              ? GestureDetector(
                  onTap: () async {
                    await Get.dialog(Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                            height: 380,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                16,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 20,
                              ),
                              child: Column(
                                children: [
                                  SvgPicture.asset(
                                    IconConstant.confirmation,
                                    width: 150,
                                    height: 150,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 32),
                                      width: double.infinity,
                                      child: Center(
                                        child: Text(
                                          "Are you sure you want to\ndelete all notifications?",
                                          style: TextStyleConstant.heading4
                                              .copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  decoration:
                                                      TextDecoration.none),
                                          textAlign: TextAlign.center,
                                        ),
                                      )),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 32),
                                      width: double.infinity,
                                      child: Center(
                                        child: Text(
                                          "All of the information will be erased and cannot be restored",
                                          style: TextStyleConstant.paragraph
                                              .copyWith(
                                            decoration: TextDecoration.none,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      )),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Expanded(
                                      child: Row(
                                    children: [
                                      Expanded(
                                        child: ButtonWidget(
                                          onTap: () {
                                            Get.back();
                                          },
                                          buttonName: "Cancel",
                                          boxDecoration: const BoxDecoration(
                                              color: Colors.white),
                                          textStyle: TextStyleConstant.subtitle
                                              .copyWith(
                                            decoration: TextDecoration.none,
                                            color: ColorConstant.primary500,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: ButtonWidget(
                                          onTap: () {
                                            notifController
                                                .deleteAllNotification();
                                            Get.back();
                                          },
                                          buttonName: "Delete",
                                          boxDecoration: BoxDecoration(
                                            color: ColorConstant.danger500,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          textStyle: TextStyleConstant.subtitle
                                              .copyWith(
                                            decoration: TextDecoration.none,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ))
                                ],
                              ),
                            )),
                      ),
                    ));
                  },
                  child: SvgPicture.asset(IconConstant.trash),
                )
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
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(flex: 1, child: SizedBox()),
                      Image.asset(ImageConstant.emptyNotification),
                      Text(
                        "No Notifications Yet",
                        style: TextStyleConstant.title,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        width: double.infinity,
                        child: Text(
                          "As you start using the app, we’ll keep you updated here. Enjoy exploring!",
                          style: TextStyleConstant.subtitle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Expanded(flex: 2, child: SizedBox())
                    ],
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
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
                                        notifId: notifController
                                                .listNotif[index].id ??
                                            -1,
                                      ),
                                    );
                                    await notifController.getPlantDetails(
                                      notifController
                                              .listNotif[index].plantId ??
                                          -1,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            notifController.listNotif[index]
                                                        .isRead ==
                                                    false
                                                ? ImageConstant
                                                    .waterDropletUnread
                                                : ImageConstant
                                                    .waterDropletReaded,
                                            width: 40,
                                            height: 40,
                                          ),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    "Time To Water Your Plants!",
                                                    style: TextStyleConstant
                                                        .paragraph
                                                        .copyWith(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    )),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  "They maybe thirsty like us? So how if we give them some water to drink? 🥤",
                                                  style: TextStyleConstant
                                                      .paragraph,
                                                  maxLines: 2,
                                                )
                                              ],
                                            ),
                                          ),
                                          Text(
                                            "1d",
                                            style: TextStyleConstant.caption
                                                .copyWith(
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
