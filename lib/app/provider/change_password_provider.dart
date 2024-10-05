import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:max_4_u/app/config/base_response/updated_base_response.dart';
import 'package:max_4_u/app/config/exception/app_exception.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/service/service.dart';

class ChangePasswordProvider extends ChangeNotifier {
  ViewState state = ViewState.Idle;

  String _message = '';
  String get message => _message;

  bool _status = false;
  bool get status => _status;

  Future<UpdatedBaseResponse<dynamic>> changePassword(
      {required String oldPassword,
      required String newPassword,
      required String confirmNewPassword}) async {
    state = ViewState.Busy;
    _message = 'Changing your password...';
    notifyListeners();

    final body = {
      "request_type": "user",
      "action": "change_password",
      "old_password": oldPassword,
      "password": newPassword,
      "confirm_password": confirmNewPassword
    };
    debugPrint('$body');

    try {
      final response = await ApiService().servicePostRequest(
        data: body,
      );
      print(response);
      final data = response.data;

      _status = data['data']['status'];
      // _message = response['data']['message'];

      if (response.statusCode == 200 || response.statusCode == 201) {
        //if (_status == true) {
        state = ViewState.Success;
        _status = data['data']['status'];

        _message = data['data']['message'];
        notifyListeners();
        return UpdatedBaseResponse.fromError(_message);
      } else {
        state = ViewState.Error;
        _status = false;
        // _status = response['data']['status'];
        // _message = data['data']['message'];
        // _message = data['data']['error_data']['password'];
        // _message = data['data']['error_data']['old_password'];
        var errorData = data['data']['error_data'];

        if (errorData != null && errorData.isNotEmpty) {
          _message = data['data']['error_data']['password'] ??
              data['data']['error_data']['old_password'];
        } else {
          _message = data['data']['message'];
        }

        //  _message = res['data']['response_data']['error_data']['email'];
        notifyListeners();
        return UpdatedBaseResponse.fromError(_message);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        _message = 'Unauthorized request. Please check your credentials.';
      } else if (e.error is SocketException) {
        _message = 'No Internet connection or server is unreachable.';
      } else {
        _message = AppException.handleError(e).toString();
      }

      _status = false;
      state = ViewState.Error;
      notifyListeners();

      return UpdatedBaseResponse.fromError(_message);
    } catch (e) {
      _message = 'An unexpected error occurred: $e';
      _status = false;
      state = ViewState.Error;
      notifyListeners();
      return UpdatedBaseResponse.fromError(_message);
    }
  }
}
