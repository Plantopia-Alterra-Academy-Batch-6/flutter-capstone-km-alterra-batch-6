import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:plantopia/models/login_params_model.dart';
import 'package:plantopia/models/signup_params_model.dart';
import 'package:plantopia/models/user_model.dart';

class AuthService {
  static Dio dio = Dio();

  static Future<String> login({required LoginParamsModel loginParams}) async {
    try {
      String url =
          "https://be-agriculture-awh2j5ffyq-uc.a.run.app/api/v1/login";
      final response = await dio.post(url,
          options: Options(
            headers: {'Content-Type': 'application/json'},
          ),
          data: loginParams.toJson());
      if (response.statusCode == 200) {
        var data = response.data;
        String token = data['data']['token'];
        return token;
      } else {
        throw '';
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.response?.data['message']);
      }
      if (e.response?.data['message'] == "record not found") {
        throw CustomException('record not found', 400);
      } else if (e.response?.data['message'] == "Invalid email or password") {
        throw CustomException('record not found', 400);
      } else if (e.response?.data['message'] == "Email not validated yet") {
        throw CustomException('Email not validated yet', 401);
      } else {
        throw CustomException(e.response?.data['message'], 402);
      }
    } catch (e) {
      throw 'there is an error : $e';
    }
  }

  static Future<UserModel?> signUp(SignUpParamsModel signUpParamsModel) async {
    try {
      String url =
          "https://be-agriculture-awh2j5ffyq-uc.a.run.app/api/v1/register";

      final response = await dio.post(url,
          options: Options(
            headers: {'Content-Type': 'application/json'},
          ),
          data: signUpParamsModelToJson(signUpParamsModel));
      final convertJsonToObject = jsonEncode(response.data['data']);
      if (kDebugMode) {
        print(convertJsonToObject);
      }
      UserModel result = userModelFromJson(convertJsonToObject);

      return result;
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        throw CustomException('Email already exists', 409);
      } else {
        throw CustomException(
            'There is an error : ${e.response?.statusMessage}', 400);
      }
    } catch (e) {
      CustomException('There is an error : $e', 400);
    }
    return null;
  }

  static Future<UserModel?> getUser(String token) async {
    try {
      String url =
          "https://be-agriculture-awh2j5ffyq-uc.a.run.app/api/v1/profile";

      final response = await dio.get(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final convertJsonToObject = jsonEncode(response.data['data']);
        UserModel result = userModelFromJson(convertJsonToObject);

        return result;
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
        return CustomException('Sign Up successful', 200);
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

class CustomException implements Exception {
  final String message;
  final int code;

  CustomException(this.message, this.code);

  @override
  String toString() => 'CustomException: $message (Code: $code)';
}
