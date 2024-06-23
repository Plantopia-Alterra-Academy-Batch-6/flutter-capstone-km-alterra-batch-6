import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/upload_progress_controller.dart';
import 'package:plantopia/models/get_plant_progress_response_model.dart';
import 'package:plantopia/utils/status_enum_util.dart';
import 'package:plantopia/views/global_widgets/shimmer_container_global_widget.dart';
import 'package:plantopia/views/upload_progress/widget/empty_all_photos_widget.dart';

class AllPhotosWidget extends StatelessWidget {
  const AllPhotosWidget({super.key});

  void _showImagePreview(
      BuildContext context, List<PlantProgress> plantProgress, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Dialog(
                backgroundColor: const Color.fromARGB(187, 0, 0, 0),
                elevation: 0,
                insetPadding: const EdgeInsets.all(0),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0.0)),
                ),
                child: PhotoViewGallery.builder(
                  itemCount: plantProgress.length,
                  builder: (context, index) {
                    return PhotoViewGalleryPageOptions(
                      imageProvider: CachedNetworkImageProvider(
                          plantProgress[index].imageUrl ?? ""),
                      maxScale: PhotoViewComputedScale.contained * 1.8,
                      initialScale: PhotoViewComputedScale.contained,
                    );
                  },
                  scrollPhysics: const BouncingScrollPhysics(),
                  gaplessPlayback: false,
                  customSize: Size(
                    MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height,
                  ),
                  backgroundDecoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  pageController: PageController(initialPage: index),
                  onPageChanged: (index) {},
                ),
              ),
            ),
            Positioned(
                top: 15,
                left: 5,
                child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back_outlined,
                      color: ColorConstant.neutral200,
                      size: 33,
                    ))),
          ],
        );
      },
    );
  }

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
                  height: 60,
                  width: 60,
                  child: ShimmerContainerGlobalWidget(
                      width: 60, height: 60, radius: 12));
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
                        return GestureDetector(
                          onTap: () =>
                              _showImagePreview(context, plantProgress, index),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            clipBehavior: Clip.antiAlias,
                            child: CachedNetworkImage(
                              imageUrl: plantProgress[index].imageUrl ?? "",
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  const ShimmerContainerGlobalWidget(
                                      width: 60, height: 60, radius: 12),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
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
