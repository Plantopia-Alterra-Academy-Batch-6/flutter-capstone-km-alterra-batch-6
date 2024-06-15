import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plantopia/models/get_plant_progress_response_model.dart';
import 'package:plantopia/service/auth_service.dart';
import 'package:plantopia/service/upload_progress_service.dart';
import 'package:plantopia/utils/status_enum_util.dart';

class UploadProgressController extends GetxController {
  Rx<Status> plantProgressData = Status.loading.obs;
  RxList<PlantProgress> listPlant = <PlantProgress>[].obs;
  RxBool isImageLarge = false.obs;
  RxBool isActiveButton = false.obs;
  RxBool isButtonLoading = false.obs;
  Rx<XFile?> pickedFile = Rx<XFile?>(null);
  Rx<File?> image = Rx<File?>(null);

  @override
  void onInit() {
    super.onInit();
    final plantId = Get.arguments["id"];
    getPlantProgress(plantId);
  }

  Future<void> pickImage() async {
    var maxFileSizeInBytes = 2 * 1048576;
    final ImagePicker picker = ImagePicker();
    pickedFile.value = await picker.pickImage(source: ImageSource.gallery);
    var imagePath = await pickedFile.value!.readAsBytes();

    var fileSize = imagePath.length;
    if (fileSize <= maxFileSizeInBytes) {
      isImageLarge.value = false;
      image.value = File(pickedFile.value!.path);
      isActiveButton.value = true;
    } else {
      image.value = null;
      isImageLarge.value = true;
      isActiveButton.value = false;
    }
  }

  Future<void> getPlantProgress(plantId) async {
    try {
      plantProgressData.value = Status.loading;
      final GetPlantProgressResponseModel? result =
          await UploadProgressService.getPlantProgress(plantId);
      List<PlantProgress>? listPlantResult = result?.data?.plantProgress;
      listPlant.value = listPlantResult ?? [];
      plantProgressData.value = Status.loaded;
    } catch (e) {
      plantProgressData.value = Status.error;
    }
  }

  Future<bool> uploadProgress(plantId) async {
    isButtonLoading.value = true;
    try {
      final CustomException result = await UploadProgressService.uploadProgress(
          plantId: plantId, image: pickedFile.value!);

      if (result.code == 200) {
        getPlantProgress(plantId);
      }
      return true;
    } catch (e) {
      if (e is CustomException) {
        Get.snackbar('failed to upload [${e.code}]', e.message);
      }

      return false;
    } finally {
      isButtonLoading.value = false;
    }
  }
}
