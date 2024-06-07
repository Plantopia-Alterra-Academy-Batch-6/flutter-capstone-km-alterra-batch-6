import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/icon_constant.dart';
import 'package:plantopia/constants/image_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/auth_controller.dart';
import 'package:plantopia/helpers/user_token_preference.dart';
import 'package:plantopia/utils/app_routes.dart';

part 'widget/custom_app_bar_widget.dart';
part 'widget/my_plant_widget.dart';
part 'widget/plant_caring_widget.dart';
part 'widget/plant_guide_first_item_widget.dart';
part 'widget/plant_guide_second_item_widget.dart';
part 'widget/plant_guide_third_item_widget.dart';
part 'widget/plant_guide_widget.dart';
part 'widget/recommended_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await UserTokenPref.clearToken();
          Get.offAllNamed(AppRoutes.splashApp);
        },
        child: const Icon(Icons.logout_rounded),
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(
              16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBarWidget(),
                MyPlantWidget(),
                PlantCaringWidget(),
                PlantGuideWidget(),
                RecommendedWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
