import 'dart:io';

import 'package:clc_app/apis_services/apis_endpoints.dart';
import 'package:clc_app/loading_indicator.dart';
import 'package:dio/dio.dart';

class ApiService {
  static String token = "0818a9acf0488b7ae004eb7b3cf82360";
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://acacioustech.co.in/api/api/', // Change as needed
      connectTimeout: Duration(seconds: 20), // Connection timeout
      receiveTimeout: Duration(seconds: 20), // Response timeout
      sendTimeout: Duration(seconds: 20), // Send timeout
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  // 🔹 Static method for API requests
  static Future<dynamic> postRequest({
    Map<String, dynamic>? params,
    Map<String, dynamic>? queryParams,
    File? filePath,
  }) async {
    LoadingIndicator.show();
    try {
      if (params != null) {
        params["token"] = token;
      }

      FormData formData = FormData.fromMap(params ?? {});
      if (filePath != null) {
        var file = await MultipartFile.fromFile(filePath.path);
        formData.files.add(MapEntry("profile_picture", file)); // ✅ Correct way
      }

      Response response = await _dio.request(
        Endpoints.endpoint,
        queryParameters: queryParams,
        data: formData,
        options: Options(method: "POST"),
      );

      return _handleResponse(response);
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  // 🔹 Handle API responses
  static dynamic _handleResponse(Response response) {
    LoadingIndicator.hide();
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data;
    } else {
      return response.data;
    }
  }

  // 🔹 Handle API errors
  static dynamic _handleError(DioException e) {
    LoadingIndicator.hide();
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return {'error': true, 'message': 'Request timed out. Please try again.'};
    } else if (e.response != null) {
      return e.response?.data;
    } else {
      return {
        'error': true,
        'message': 'Something went wrong. Check your internet connection.'
      };
    }
  }
}
