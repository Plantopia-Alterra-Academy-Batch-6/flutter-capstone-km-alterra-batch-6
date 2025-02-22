import 'package:dio/dio.dart';
import 'package:plantopia/service/auth_service.dart';
import 'package:plantopia/utils/base_url_util.dart';

class ForgotPasswordService {
  static Dio dio = Dio();

  static Future<CustomException> postForgotPassword(
      {required String email, required String password}) async {
    try {
      String url =
          "${BaseUrlUtil.baseUrl}/forgot-password";
      final response = await dio.post(
        url,
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        data: {
          "email": email,
          "new_password": password,
        },
      );
      if (response.statusCode == 200) {
        return CustomException('Verification success', 200);
      } else {
        throw CustomException('Unexpected status code: ${response.statusCode}',
            response.statusCode ?? 40);
      }
    } on DioException catch (e) {
      throw CustomException(
          'there is an error : ${e.response?.statusMessage}', 404);
    } catch (e) {
      throw CustomException('there is an error : $e', 400);
    }
  }
}
