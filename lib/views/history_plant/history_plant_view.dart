import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/icon_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantopia/controllers/plant_history_controller.dart';
import 'package:plantopia/utils/status_enum_util.dart';
import 'package:plantopia/views/global_widgets/shimmer_container_global_widget.dart';
import 'package:plantopia/views/history_plant/widget/sort_history_widget.dart';

class HistoryPlantView extends StatelessWidget {
  HistoryPlantView({super.key});

  final PlantHistoryController plantHistoryController =
      Get.put(PlantHistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstant.white,
        appBar: AppBar(
          forceMaterialTransparency: true,
          backgroundColor: ColorConstant.white,
          centerTitle: true,
          title: Text(
            "Planting History",
            style: TextStyleConstant.heading4.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.filter_list))
          ],
        ),
        body: Obx(() {
          switch (plantHistoryController.plantingHistoryData.value) {
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
              return plantHistoryController.listPlantingHistory.isEmpty
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
        }));
  }

  Widget bodyBuild(context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SortHistoryWidget(
            sortListHistory: plantHistoryController.todayHistory,
            sortingName: 'Today',
          ),
          SortHistoryWidget(
            sortListHistory: plantHistoryController.yesterdayHistory,
            sortingName: 'Yesterday',
          ),
          SortHistoryWidget(
            sortListHistory: plantHistoryController.thisWeekHistory,
            sortingName: 'This Week',
          ),
          SortHistoryWidget(
            sortListHistory: plantHistoryController.thisMonthHistory,
            sortingName: 'This Month',
          ),
          SortHistoryWidget(
            sortListHistory: plantHistoryController.thisYearHistory,
            sortingName: 'This Year',
          ),
          SortHistoryWidget(
            sortListHistory: plantHistoryController.lastYearHistory,
            sortingName: 'Last Year',
          ),
        ],
      ),
    );
  }
}
