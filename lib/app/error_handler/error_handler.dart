import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:max_4_u/app/model/error_response_model.dart';


abstract class Status {
  static String error = 'error';
  static String success = 'success';
}

class ExceptionHandler implements Exception {
  static  handleError<T>(DioException error) {
    log('$error');

   // AppResponseModel<T>

    final response = switch (error.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout =>
        AppResponseModel<T>(
          message: 'Connection timed out',
          status: Status.error,
        ),
      DioException.badResponse when (error.response?.statusCode ?? 0) >= 500 =>
        AppResponseModel<T>(
          message: 'Server error occurred',
          status: Status.error,
        ),
      DioExceptionType.badResponse
          when error.response?.data is Map<String, dynamic> =>
        AppResponseModel<T>.fromJson(error.response?.data),
      DioExceptionType.badResponse =>
        AppResponseModel<T>(message: "An error occurred", status: Status.error,),
   
      DioExceptionType.cancel => AppResponseModel<T>(
          message: 'The API request was cancelled',
          status: Status.error,
        ),
      DioExceptionType.unknown => AppResponseModel<T>(
          message: 'Network error occurred',
          status: Status.error,
        ),
      _ => AppResponseModel<T>(message: "An error occurred", status: Status.error,),
    };

   // return AppResponseModel(message: "An error occurred");
     return response;
  }
}
