import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';


import 'package:max_4_u/app/config/constants.dart';

import 'package:max_4_u/app/database/database.dart';

class ApiService {
  Dio dio = Dio();

  // ApiService.init();
  // static final ApiService instance = ApiService.init();
  //  ViewState state = ViewState.Idle;

  Future<dynamic> authPostRequest(
      {Map<String, String>? headers,
      //String? message,
      required Map<String, dynamic> body}) async {
    String url = AppConstants.baseUrl;
    try {
      final response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Site-From': 'postman',
          },
        ),
      );

      return response.data;
      // } else {
      //   throw Exception('Failed to authenticate: ${response.statusCode}');
      // }
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode ?? 'No Status Code';
      final data = e.response?.data ?? 'No Data';
      print('Server Error: $statusCode $data');
      print('Server Error: ${e.response?.statusCode} ${e.response?.data}');
      return e.response?.data;
      // return Future.error('Server error: $statusCode $data');
    } catch (e) {
      //  message = e.toString();
      print('General Error: $e');
      return Future.error(e.toString());
      // return Future.error(e.toString());
    }
  }

  Future<dynamic> servicePostRequest(
      {Map<String, String>? headers,
      required Map<String, dynamic> body}) async {
    String url = AppConstants.baseUrl;

    final encryptedId = await SecureStorage().getUserEncryptedId();

    try {
      final response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Site-From': 'postman',
            'User-Key': encryptedId
          },
        ),
      );

      return response.data;
    } on DioException catch (e) {
      // Server-side error
      print('Server Error: ${e.response?.statusCode} ${e.response?.data}');
      return e.response?.data;
    } on SocketException catch (_) {
      // state = ViewState.Error;
      // _message = 'Network error. Please try again later';
      // notifyListeners();
    }
  }

  Future<dynamic> uploadFileServicePostRequest(
      {Map<String, String>? headers, required FormData data}) async {
    String url = AppConstants.baseUrl;

    final encryptedId = await SecureStorage().getUserEncryptedId();

    try {
      final response = await dio.post(
        url,
        data: data,
        onSendProgress: (count, total) {
          log('count: $count, total $total');
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Site-From': 'postman',
            'User-Key': encryptedId
          },
          contentType: Headers.jsonContentType,
        ),
      );

      print('This is this source response ${response.data}');
      return response.data;
    } on DioException catch (e) {
      // Server-side error
      print('Server Error: ${e.response?.statusCode} ${e.response?.data}');
      return e.response?.data;
    } on SocketException catch (_) {
      // state = ViewState.Error;
      // _message = 'Network error. Please try again later';
      // notifyListeners();
    }
  }
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
