import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:plantopia/helpers/shared_pref_helper.dart';

class HomeController extends GetxController {
  var locationPermissionGranted = false.obs;
  var userLocation = Rx<Position?>(null);

  @override
  void onInit() {
    super.onInit();
    requestLocationPermission();
  }

  Future<void> requestLocationPermission() async {
    PermissionStatus status = await Permission.location.request();
    if (status.isGranted) {
      locationPermissionGranted.value = true;
      getUserLocation();
    } else {
      locationPermissionGranted.value = false;
    }
  }

  Future<void> getUserLocation() async {
    if (await Geolocator.isLocationServiceEnabled()) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      userLocation.value = position;

      SharedPrefHelper.saveUserLocation(position.latitude, position.longitude);
    }
  }
}
