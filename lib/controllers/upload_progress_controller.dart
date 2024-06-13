import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plantopia/models/get_plant_progress_response_model.dart';
import 'package:plantopia/service/auth_service.dart';
import 'package:plantopia/service/upload_progress_service.dart';
import 'package:plantopia/utils/status_enum_util.dart';

class UploadProgressController extends GetxController {
  Rx<Status> plantProgressData = Status.loading.obs;
  RxList<PlantProgress> listPlant = <PlantProgress>[].obs;

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

  Future<bool> uploadProgress(String plantId, XFile image) async {
    try {
      final result = await UploadProgressService.uploadProgress(
          plantId: plantId, image: image);
      return true;
    } catch (e) {
      if (e is CustomException) {
        Get.snackbar('failed to Verification [${e.code}]', e.message);
      }

      return false;
    }
  }
}
