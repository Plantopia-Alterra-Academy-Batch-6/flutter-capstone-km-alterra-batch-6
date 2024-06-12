import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/icon_constant.dart';
import 'package:plantopia/constants/image_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/auth_controller.dart';
import 'package:plantopia/controllers/my_plant_controller.dart';
import 'package:plantopia/utils/app_routes.dart';
import 'package:plantopia/utils/status_enum_util.dart';
import 'package:plantopia/views/global_widgets/card_global_widget.dart';
import 'package:plantopia/views/global_widgets/recommended_widget.dart';
import 'package:plantopia/views/global_widgets/shimmer_container_global_widget.dart';
import 'package:plantopia/views/my_plant/widget/empty_my_plant_widget.dart';
part 'widget/custom_app_bar_widget.dart';
part 'widget/my_plant_widget.dart';
part 'widget/plant_caring_widget.dart';
part 'widget/plant_guide_first_item_widget.dart';
part 'widget/plant_guide_second_item_widget.dart';
part 'widget/plant_guide_third_item_widget.dart';
part 'widget/plant_guide_widget.dart';

class HomeView extends StatelessWidget {
   HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:  const EdgeInsets.all(
              16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 const CustomAppBarWidget(),
                MyPlantWidget(),
                 const PlantCaringWidget(),
                 const PlantGuideWidget(),
                 const RecommendedWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
