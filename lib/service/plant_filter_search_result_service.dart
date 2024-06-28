import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:plantopia/models/get_plant_filter_search_result_response.dart';
import 'package:plantopia/utils/base_url_util.dart';

class PlantFilterSearchResultService {
  Dio dio = Dio();

  Future<PlantFilterSearchResultResponse> searchPlantByFilter(
      String query) async {
    try {
      final api =
          '${BaseUrlUtil.baseUrl}/search?$query';
      final response = await dio.get(api);

      if (response.statusCode == 200) {
        return PlantFilterSearchResultResponse.fromJson(response.data);
      } else {
        throw Exception(
            "Failed to search plant by filter: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print("DioError: $e");
      }
      throw Exception("Failed to search plant by filter");
    } on SocketException catch (e) {
      if (kDebugMode) {
        print("SocketException: $e");
      }
      throw Exception("Failed to search plant by filter");
    } on FormatException catch (e) {
      if (kDebugMode) {
        print("FormatException: $e");
      }
      throw Exception("Failed to search plant by filter");
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
      throw Exception("Failed to search plant by filter");
    }
  }
}
