import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plantopia/helpers/user_token_preference.dart';
import 'package:plantopia/models/get_plant_progress_response_model.dart';
import 'package:plantopia/service/auth_service.dart';

class UploadProgressService {
  static Dio dio = Dio();

  static Future<GetPlantProgressResponseModel?> getPlantProgress(
      plantId) async {
    try {
      final String? bearerToken = await UserTokenPref.getToken();
      final String url =
          "https://be-agriculture-awh2j5ffyq-uc.a.run.app/api/v1/plants/progress/$plantId";
      Map<String, dynamic> headers = {
        'Authorization': 'Bearer $bearerToken',
        'Content-Type': 'application/json',
      };
      final response = await dio.get(
        url,
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        return GetPlantProgressResponseModel.fromJson(response.data);
      } else {
        throw Exception(
            'Failed to load Plant Progress : ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to load Plant Progress: $e');
    }
  }

  static Future<CustomException> uploadProgress(
      {required plantId, required XFile image}) async {
    try {
      final String? bearerToken = await UserTokenPref.getToken();

      const String url =
          "https://be-agriculture-awh2j5ffyq-uc.a.run.app/api/v1/plants/progress";

      FormData formData = FormData.fromMap({
        'plant_id': plantId,
        'image_url': await MultipartFile.fromFile(
          image.path,
          filename: image.name,
        ),
      });

      final response = await dio.post(
        url,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $bearerToken',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 201) {
        if (kDebugMode) {
          print("success");
        }
        return CustomException('Success', 200);
      } else {
        throw CustomException('there is an error ', 400);
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.response?.data);
      }
      throw CustomException(e.response?.data, e.response?.statusCode ?? 400);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }

      throw CustomException('there is an error : $e', 400);
    }
  }
}
