import 'package:get/get.dart';

class PlantFilterController extends GetxController {
  RxBool isPlantCategorySelected = true.obs;
  RxBool isDifficultyLevelSelected = false.obs;
  RxBool isSunlightRequirementSelected = false.obs;
  RxBool isHarvestDurationSelected = false.obs;
  RxBool isPlantToxicitySelected = false.obs;

  RxInt selectedCategory = 0.obs;
  RxInt selectedDifficultyLevel = 0.obs;
  RxInt selectedSunlightRequirement = 0.obs;
  RxInt selectedHarvestDuration = 0.obs;
  RxInt selectedToxicity = 0.obs;

  List<String> difficultyLevel = ['Easy', 'Medium', 'Hard'];
  List<String> sunlightRequirement = [
    'Full Sun',
    'Partial Shade',
    'Shady Spots',
    'Flexible'
  ];
  List<String> harvestDuration = [
    'Less Than 1 month',
    '1-3 months',
    '3-6 months',
    'More than 6 months'
  ];
  List<String> toxicity = ['Non-toxic', 'toxic'];

  RxString queryParams = ''.obs;

  Future<void> createQueryParams() async {
    queryParams.value = '';
    String? plantCategory = '';
    String? sunlightRequirement = '';
    String? harvestDuration = '';
    String? toxicity = '';

    if (isPlantCategorySelected.isTrue) {
      plantCategory = selectedCategory.value.toString();
      queryParams.value += 'plant_category=$plantCategory';
    }
    if (isSunlightRequirementSelected.isTrue) {
      sunlightRequirement =
          sunlightRequirementMap[selectedSunlightRequirement.value];
      queryParams.value += '&sunlight=$sunlightRequirement';
    }
    if (isHarvestDurationSelected.isTrue) {
      harvestDuration = harvestDurationMap[selectedHarvestDuration.value];
      queryParams.value += '&harvest_duration=$harvestDuration';
    }
    if (isPlantToxicitySelected.isTrue) {
      toxicity = toxicityMap[selectedToxicity.value];
      queryParams.value += '&is_toxic=$toxicity';
    }
  }

  var sunlightRequirementMap = {
    0: 'fullsun',
    1: 'partial shade',
    2: 'shady spots',
    3: 'flexible',
  };

  var harvestDurationMap = {
    0: 'less than 1 month',
    1: '1-3 months',
    2: '3-6 months',
    3: 'more than 6 months'
  };

  var toxicityMap = {
    0: 'false', // non toxic
    1: 'true', // toxic
  };
}
