import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plantopia/models/get_plant_progress_response_model.dart';
import 'package:plantopia/service/auth_service.dart';

class UploadProgressService {
  static Dio dio = Dio();

  static Future<GetPlantProgressResponseModel?> getPlantProgress(
      plantId) async {
    try {
      String token =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im9jdGF2aWFub3J5YW4wMzBAZ21haWwuY29tIiwiaWQiOjMsInJvbGUiOiJ1c2VyIn0.7SvvgU6pwwe6cLg-M97O9PT5vHcKlizflp5M4XlPwHE";
      final String url =
          "https://be-agriculture-awh2j5ffyq-uc.a.run.app/api/v1/plants/progress/$plantId";
      Map<String, dynamic> headers = {
        'Authorization': 'Bearer $token',
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
      {required String plantId, required XFile image}) async {
    try {
      // final String? bearerToken = await UserTokenPref.getToken();

      String bearerToken =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im9jdGF2aWFub3J5YW4wMzBAZ21haWwuY29tIiwiaWQiOjMsInJvbGUiOiJ1c2VyIn0.7SvvgU6pwwe6cLg-M97O9PT5vHcKlizflp5M4XlPwHE";
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
        return CustomException('Success', 200);
      } else {
        throw CustomException('there is an error ', 400);
      }
    } on DioException catch (e) {
      throw CustomException(e.response?.data, e.response?.statusCode ?? 400);
    } catch (e) {
      throw CustomException('there is an error : $e', 400);
    }
  }
}
