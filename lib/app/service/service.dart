import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:max_4_u/app/config/constants.dart';

import 'package:max_4_u/app/database/database.dart';


class ApiService extends ChangeNotifier {
  Dio dio = Dio();

  ApiService.init();
  static final ApiService instance = ApiService.init();
  //  ViewState state = ViewState.Idle;
  Future<dynamic> authPostRequest(
      {Map<String, String>? headers,
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

      
      print('This is this source response ${response.data}');
      return response.data;
    } on DioException catch (e) {
      // Server-side error
      print('Server Error: ${e.response?.statusCode} ${e.response?.data}');
      return e.response?.data;
    }on SocketException catch (_) {
      // state = ViewState.Error;
      // _message = 'Network error. Please try again later';
      // notifyListeners();
    } 
  }

  Future<dynamic> servicePostRequest(
      {Map<String, String>? headers,
      required String message,
      required Map<String, dynamic> body}) async {
    String url = AppConstants.baseUrl;

    final encryptedId = await SecureStorage().getEncryptedID();

    final response = await dio.post(url,
        data: body,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Site-From': 'postman',
            'User-Key': encryptedId
          },
        ));

    try {
      return response;
    } on SocketException catch (_) {
      // state = ViewState.Error;
      message = 'Network error. Please try again later';
      notifyListeners();
    } catch (e) {
      // state = ViewState.Error;
      message = e.toString();
      notifyListeners();
    }
  }
}
