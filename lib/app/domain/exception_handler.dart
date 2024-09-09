import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:max_4_u/app/domain/model.dart';

abstract class Status {
  static bool error = false;
  static bool success = true;
}

class ExceptionHandler implements Exception {
  static handleError<T>(DioException error) {
    log('$error');

    // AppResponseModel<T>

    final response = switch (error.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout =>
        AppResponseModelData<T>(
          message: 'Connection timed out',
          status: Status.error,
          errorData: [],
          responseData: [],
        ),
      DioException.badResponse when (error.response?.statusCode ?? 0) >= 500 =>
        AppResponseModelData<T>(
          message: 'Server error occurred',
          status: Status.error,
          errorData: [],
          responseData: [],
        ),
      DioExceptionType.badResponse
          when error.response?.data is Map<String, dynamic> =>
        AppResponseModelData<T>.fromJson(error.response?.data),
      DioExceptionType.badResponse => AppResponseModelData<T>(
          message: "An error occurred",
          status: Status.error,
          errorData: [],
          responseData: [],
        ),
      DioExceptionType.cancel => AppResponseModelData<T>(
          message: 'The API request was cancelled',
          status: Status.error,
          errorData: [],
          responseData: [],
        ),
      DioExceptionType.unknown => AppResponseModelData<T>(
          message: 'Network error occurred',
          status: Status.error,
          errorData: [],
          responseData: [],
        ),
      _ => AppResponseModelData<T>(
          message: "An error occurred",
          status: Status.error,
          errorData: [],
          responseData: [],
        ),
    };

    // return AppResponseModel(message: "An error occurred");
    return response;
  }
}
