import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/upload_progress_controller.dart';
import 'package:plantopia/models/get_plant_progress_response_model.dart';
import 'package:plantopia/utils/status_enum_util.dart';
import 'package:plantopia/views/upload_progress/widget/empty_all_photos_widget.dart';

class AllPhotosWidget extends StatelessWidget {
  const AllPhotosWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final UploadProgressController uploadProgressController =
        Get.put(UploadProgressController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20.0,
        ),
        Text(
          "All Photos",
          style: TextStyleConstant.title.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Obx(() {
          List<PlantProgress> plantProgress =
              uploadProgressController.listPlant;
          switch (uploadProgressController.plantProgressData.value) {
            case Status.loading:
              return const SizedBox(
                  height: 60, width: 60, child: CircularProgressIndicator());
            case Status.loaded:
              return plantProgress.isEmpty
                  ? const EmptyAllPhotosWidget()
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 15.0,
                        mainAxisSpacing: 15.0,
                      ),
                      itemCount: plantProgress.length,
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          clipBehavior: Clip.antiAlias,
                          child: CachedNetworkImage(
                            imageUrl: plantProgress[index].imageUrl ?? "",
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        );
                      },
                    );
            case Status.error:
              return Center(
                child: Text(
                  "Failed to load my plant data",
                  style: TextStyleConstant.heading4.copyWith(
                    color: ColorConstant.danger500,
                  ),
                ),
              );
            default:
              return const EmptyAllPhotosWidget();
          }
        }),
      ],
    );
  }
}
