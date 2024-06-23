import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:plantopia/models/get_plant_filter_search_result_response.dart';

class PlantFilterSearchResultService {
  Dio dio = Dio();

  Future<PlantFilterSearchResultResponse> searchPlantByFilter(
      String query) async {
    try {
      final api =
          'https://be-agriculture-awh2j5ffyq-uc.a.run.app/api/v1/search?$query';
      final response = await dio.get(api);

      if (response.statusCode == 200) {
        return PlantFilterSearchResultResponse.fromJson(response.data);
      } else {
        throw Exception(
            "Failed to search plant by filter: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      // Handle DioError specifically
      if (kDebugMode) {
        print("DioError: $e");
      }
      throw Exception("Failed to search plant by filter");
    } on SocketException catch (e) {
      // Handle SocketException specifically
      if (kDebugMode) {
        print("SocketException: $e");
      }
      throw Exception("Failed to search plant by filter");
    } on FormatException catch (e) {
      // Handle FormatException specifically
      if (kDebugMode) {
        print("FormatException: $e");
      }
      throw Exception("Failed to search plant by filter");
    } catch (e) {
      // Handle other errors
      if (kDebugMode) {
        print("Error: $e");
      }
      throw Exception("Failed to search plant by filter");
    }
  }
}
