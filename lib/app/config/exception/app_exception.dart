

import 'package:dio/dio.dart';
import 'package:max_4_u/app/config/base_response/base_response.dart';
import 'package:max_4_u/app/config/exception/logger.dart';


class AppException implements Exception {
  static BaseResponse<T> handleError<T>(
    DioException e, {
    T? data,
    T Function(Map<String, dynamic>)? fromJsonT,
  }) {
    debugLog(e);
    if (e.response != null && DioExceptionType.badResponse == e.type) {
      if ((e.response?.statusCode ?? 0) >= 500) {
        return BaseResponse(
          status: false,
          message: 'A server error occurred',
          data: data,
        );
      }
      if (e.response?.statusCode == 413) {
        return BaseResponse(
          status: false,
          message: 'File size too large',
          data: data,
        );
      }
      if (e.response?.data is Map<String, dynamic>) {
        debugLog(e.response?.data as Map<String, dynamic>);
        if (fromJsonT != null) {
          (e.response?.data as Map<String, dynamic>? ?? {})['data'] = fromJsonT(
            (e.response?.data as Map<String, dynamic>? ?? {})['data']
                    as Map<String, dynamic>? ??
                {},
          );
        }
        return BaseResponse.fromMap(
          e.response?.data as Map<String, dynamic>,
        );
      } else if (e.response?.data is String) {
        debugLog(e.response?.data);
        return BaseResponse(
          status: false,
          message: e.response?.data as String,
        );
      }
    }
    return BaseResponse(
      status: false,
      data: data,
      message: _mapException(e.type),
    );
  }

  static String _mapException(DioExceptionType? error) {
    if (DioExceptionType.connectionTimeout == error ||
        DioExceptionType.receiveTimeout == error ||
        DioExceptionType.sendTimeout == error) {
      return 'Your connection timed out';
    } else if (DioExceptionType.connectionError == error) {
      return 'Please check your internet connection';
    }
    return 'An error occurred';
  }
}
