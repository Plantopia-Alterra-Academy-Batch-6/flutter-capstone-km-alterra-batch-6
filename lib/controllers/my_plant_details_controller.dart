import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:plantopia/models/get_plant_by_id_response.dart';
import 'package:plantopia/service/plant_details_service.dart';

class MyPlantDetailsController extends GetxController {
  PlantDetailsService plantDetailsService = PlantDetailsService();
  PlantByIdResponse? plantByIdResponse;
  RxBool isPageLoading = false.obs;
  RxInt activeIndex = 0.obs;
  RxBool customIcon = false.obs;

  void getPlantDetails(int id) async {
    isPageLoading(true);
    plantByIdResponse = await plantDetailsService.getPlantById(id);
    isPageLoading(false);
  }

  String parseHour(String wateringSchedule) {
    DateTime time = DateFormat.Hm().parse(wateringSchedule);

    DateFormat formatter = DateFormat('h a');

    String formattedTime = formatter.format(time);

    return formattedTime;
  }

  String parseDate(DateTime dateTime) {
    String plantingDate = DateFormat('dd MMMM yyyy').format(dateTime);
    return plantingDate;
  }

  String plantAge(DateTime plantingDate) {
    String plantAge = "";
    DateTime now = DateTime.now();
    Duration difference = now.difference(plantingDate);

    int years = difference.inDays ~/ 365;
    int months = (difference.inDays % 365) ~/ 30;
    int weeks = ((difference.inDays % 365) % 30) ~/ 7;
    int days = ((difference.inDays % 365) % 30) % 7;
    int hours = difference.inHours;
    int minutes = difference.inMinutes.remainder(60);

    if (years > 0) {
      plantAge = '$years years ';
    } else if (months > 0) {
      plantAge = '$months months ';
    } else if (weeks > 0) {
      plantAge = '$weeks weeks ';
    } else if (days > 0) {
      plantAge = '$days days ';
    } else if (hours > 0) {
      plantAge = '$hours hours ';
    } else if (minutes > 0) {
      plantAge = '$minutes minutes ';
    }

    return plantAge;
  }
}
