import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/icon_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/watering_history_controller.dart';
import 'package:plantopia/utils/status_enum_util.dart';
import 'package:plantopia/views/global_widgets/shimmer_container_global_widget.dart';
import 'package:plantopia/views/wateting_history/widget/sort_watering_history_widget.dart';

class WateringHistoryView extends StatelessWidget {
  WateringHistoryView({super.key});

  final WateringHistoryController wateringHistoryController =
      Get.put(WateringHistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: ColorConstant.white,
        centerTitle: true,
        title: Text(
          "Watering History",
          style: TextStyleConstant.heading4.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.filter_list))
        ],
      ),
      body: Obx(() {
        switch (wateringHistoryController.wateringDataStatus.value) {
          case Status.loading:
            return ListView.builder(
                padding: const EdgeInsets.all(12),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, int index) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 12.0),
                    child: ShimmerContainerGlobalWidget(
                        width: double.infinity, height: 184, radius: 12),
                  );
                });
          case Status.loaded:
            return wateringHistoryController.listWateringHistory.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          IconConstant.emptyHistoryPlant,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Text(
                          "No Results",
                          style: TextStyleConstant.heading4.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Sorry, there are no results for this search.\nPlease try another phrase",
                          style: TextStyleConstant.paragraph,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    child: bodyBuild(context),
                  );
          case Status.error:
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Failed to load planting history",
                  style: TextStyleConstant.heading4.copyWith(
                    fontWeight: FontWeight.w700,
                    color: ColorConstant.warning500,
                  ),
                )
              ],
            );
          default:
            return const SizedBox();
        }
      }),
    );
  }

  Widget bodyBuild(context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SortWateringHistoryWidget(
            sortListHistory: wateringHistoryController.todayHistory,
            sortingName: 'Today',
          ),
          SortWateringHistoryWidget(
            sortListHistory: wateringHistoryController.yesterdayHistory,
            sortingName: 'Yesterday',
          ),
          SortWateringHistoryWidget(
            sortListHistory: wateringHistoryController.thisWeekHistory,
            sortingName: 'This Week',
          ),
          SortWateringHistoryWidget(
            sortListHistory: wateringHistoryController.thisMonthHistory,
            sortingName: 'This Month',
          ),
          SortWateringHistoryWidget(
            sortListHistory: wateringHistoryController.thisYearHistory,
            sortingName: 'This Year',
          ),
          SortWateringHistoryWidget(
            sortListHistory: wateringHistoryController.lastYearHistory,
            sortingName: 'Last Year',
          ),
        ],
      ),
    );
  }
}
