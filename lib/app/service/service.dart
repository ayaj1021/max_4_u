import 'dart:io';

import 'package:dio/dio.dart';

import 'package:max_4_u/app/config/constants.dart';

import 'package:max_4_u/app/database/database.dart';

import 'dart:developer';

class ApiService {
  final Dio _dio;
  String? message;

  ApiService({Dio? dio}) : _dio = dio ?? Dio() {
    _dio.options..baseUrl = AppConstants.baseUrl;
    //..connectTimeout = const Duration(seconds: 60)
    // ..receiveTimeout = const Duration(seconds: 60);
  }

  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters, String? token}) async {
    final _token = '';

    final response = await _dio.get(
      path,
      queryParameters: queryParameters,
      options: Options(headers: _buildHeaders(_token)),
    );
    return response;
  }

  Future<Response> authPostRequest(
      {String? message,
      required Map<String, dynamic>? data,
      String? token}) async {
    final response = await _dio.post(
      AppConstants.baseUrl,
      data: data,
      options: Options(
          validateStatus: (_) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'Content-Type': 'application/json',
            'Site-From': 'postman',
          }),
    );

    return response;
  }

  Future<Response> servicePostRequest(
      {String? message,
      required Map<String, dynamic>? data,
      String? token}) async {
    final encryptedId = await SecureStorage().getUserEncryptedId();
    final response = await _dio.post(
      AppConstants.baseUrl,
      data: data,
      options: Options(
          validateStatus: (_) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
          headers: {
            'Content-Type': 'application/json',
            'Site-From': 'postman',
            'User-Key': encryptedId
          }),
    );

    return response;
  }

  Future<Response> uploadFileServicePostRequest(
      {
      //required String path,
      String? message,
      required FormData data,
      required Function(int, int) onSendProgress,
      //required Map<String, dynamic>? data,
      String? token}) async {
    log('$data');
    final encryptedId = await SecureStorage().getUserEncryptedId();
    final response = await _dio.post(
      AppConstants.baseUrl,
      data: data,
      onSendProgress: onSendProgress,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Site-From': 'postman',
          'User-Key': encryptedId
        },
        contentType: Headers.jsonContentType,
        //_buildHeaders(_token)
      ),
    );
    log('${response.data}');

    return response;
  }

  Future<Response> delete(
      {required String path,
      String? message,
      required Map<String, dynamic>? data,
      String? token}) async {
    log('$data');
    // final storage = await SecureStorage();
    final _token = '';
    // await storage.getUserToken();
    //  final _token = await SecureStorage().getUserToken();
    final response = await _dio.delete(
      path,
      data: data,
      options: Options(headers: _buildHeaders(_token)),
    );
    log('${response.data}');

    return response;
  }
}

Map<String, dynamic> _buildHeaders(String? token) {
  final headers = <String, dynamic>{};
  if (token != null && token.isNotEmpty) {
    headers['Authorization'] = 'Bearer $token';
  }
  return headers;
}

class ApiError {
  late String? errorDescription;
  ApiError({required this.errorDescription});
  late DioException dioError;
  ApiError.fromDio(Object dioError) {
    _handleError(dioError);
  }

  void _handleError(Object error) async {
    if (error is DioException) {
      dioError = error; // as DioError;

      switch (dioError.type) {
        case DioExceptionType.cancel:
          errorDescription = 'Request canceled';
          break;
        case DioExceptionType.connectionTimeout:
          errorDescription = 'Connection timeout';
          break;
        case DioExceptionType.unknown:
          errorDescription =
              'Something went wrong, please check your internet connection...';
          break;
        case DioExceptionType.receiveTimeout:
          errorDescription = 'Receiving timeout';
          break;
        case DioExceptionType.badResponse:
          if (dioError.response!.statusCode == 401) {
            errorDescription = error.response?.data?['message'].toString() ??
                extractDescriptionFromResponse(error.response);
          } else if (dioError.response!.statusCode == 403) {
            errorDescription = error.response?.data?['message'].toString() ??
                extractDescriptionFromResponse(dioError.response);
          } else if (dioError.response!.statusCode == 404) {
            errorDescription = error.response?.data?['message'].toString() ??
                extractDescriptionFromResponse(dioError.response);
          } else if (dioError.response!.statusCode == 409) {
            errorDescription = error.response?.data?['message'].toString() ??
                extractDescriptionFromResponse(dioError.response);
          } else if (dioError.response!.statusCode == 400) {
            errorDescription = error.response?.data?['message'].toString() ??
                extractDescriptionFromResponse(dioError.response);
          } else if (dioError.response!.statusCode == 422) {
            errorDescription = error.response?.data?['message'] ??
                extractDescriptionFromResponse(dioError.response);
          } else if (dioError.response!.statusCode == 500) {
            errorDescription = 'Internal Server Error';
          } else {
            errorDescription = extractDescriptionFromResponse(error.response);
          }

          break;
        case DioExceptionType.sendTimeout:
          errorDescription =
              'Something went wrong, please check your internet connection...';
          break;
        case DioExceptionType.badCertificate:
          errorDescription =
              'Something went wrong, please check your internet connection...';
          break;
        case DioExceptionType.connectionError:
          errorDescription =
              'Connection Error, please check your internet connection...';
          break;
      }
    } else {
      errorDescription = 'Something went wrong, please try again...';
    }
  }

  String extractDescriptionFromResponse(Response? response) {
    String? message;
    try {
      if (response?.data != null && response?.data['data']['error'] != null) {
        message = '${response!.data["data"]["error"]}';
      } else if (response?.data != null &&
          response?.data['data']['message'] != null) {
        message = '${response!.data["data"]["message"]}';
      } else if (response?.data != null && response!.data['message'] != null) {
        message = response.data['message'];
      } else if (response?.data != null && response?.data['error'] != null) {
        message = '${response?.data['error']}';
      } else {
        message = response!.statusMessage;
      }
    } catch (error) {
      message = response?.statusMessage ?? error.toString();
    }

    return message ?? 'Something went wrong';
  }

  @override
  String toString() => errorDescription == null ||
          errorDescription == 'null' ||
          errorDescription!.isEmpty
      ? extractDescriptionFromResponse(dioError.response)
      : errorDescription!;
}
