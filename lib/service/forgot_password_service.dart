import 'package:plantopia/models/login_params_model.dart';
import 'package:plantopia/service/auth_service.dart';
import 'package:dio/dio.dart';
class ForgotPasswordService {
static Dio dio = Dio();
    static Future<CustomException> verification(
      {required String email, required String otp}) async {
    try {
      String url =
          "https://be-agriculture-awh2j5ffyq-uc.a.run.app/api/v1/verify";

      final response = await dio.post(
        url,
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        data: {
          "email": email,
          "otp": otp,
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

  static Future<CustomException> postForgotPassword({required String email, required String password}) async {
    try {
      String url = "https://be-agriculture-awh2j5ffyq-uc.a.run.app/api/v1/forgot-password";
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

    static Future<CustomException?> resendOTP({required String email}) async {
    try {
      String url =
          "https://be-agriculture-awh2j5ffyq-uc.a.run.app/api/v1/resendotp";

      final response = await dio.post(
        url,
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        data: {
          "email": email,
        },
      );

      if (response.statusCode == 200) {
        return CustomException("OTP resend, please check your email", 200);
      } else {
        return null;
      }
    } on DioException catch (e) {
      throw CustomException(
          'Email already exists', e.response?.statusCode ?? 400);
    } catch (e) {
      throw CustomException('there is an error : $e', 400);
    }
  }
}
