import 'package:get/get.dart';
import 'package:plantopia/models/get_my_plant_response_model_new.dart';
import 'package:plantopia/service/plant_guide_service.dart';

class GetMyPlantGuideController extends GetxController {
  var plantInstructions = <PlantInstruction>[].obs;
  var isLoading = false.obs;
  RxBool customIcon = false.obs;
  var enabledIndexes = <int>[0].obs;

  final GetMyPlantService _getMyPlantServiceNew = GetMyPlantService();

  @override
  void onInit() {
    super.onInit();
    fetchPlantInstructions();
  }

  void fetchPlantInstructions() async {
    try {
      isLoading(true);
      var result = await _getMyPlantServiceNew.getPlantInstructions();
      plantInstructions(result);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load plant instructions: $e');
    } finally {
      isLoading(false);
    }
  }

  bool isEnabled(int index) {
    return enabledIndexes.contains(index);
  }

  void enableNextIndex(int index) {
    if (index < 3 && !enabledIndexes.contains(index + 1)) {
      enabledIndexes.add(index + 1);
    }
  }

  int getLatestEnabledIndex() {
    return enabledIndexes.last;
  }
}