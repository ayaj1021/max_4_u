import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:max_4_u/app/config/base_response/updated_base_response.dart';
import 'package:max_4_u/app/config/exception/app_exception.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/service/service.dart';

class DeactivateUserProvider extends ChangeNotifier {
  ViewState state = ViewState.Idle;
  bool _status = false;
  bool get status => _status;

  String _message = '';
  String get message => _message;

  Future<UpdatedBaseResponse<dynamic>> deactivateUser(
      {required String userId}) async {
    state = ViewState.Busy;
    _message = 'Deactivating user...';
    notifyListeners();

    final body = {
      "request_type": "normal_admin",
      "action": "deactivate_user",
      "user_id": userId //unique id
    };

    try {
      final response = await ApiService().servicePostRequest(
        data: body,
      );
      final data = response.data;

      if (response.statusCode == 200 || response.statusCode == 201) {
        _status = data['data']['status'];

        _message = data['data']['message'];
        state = ViewState.Success;

        notifyListeners();
        return UpdatedBaseResponse.fromSuccess(data);
      } else {
        _message = data['data']['message'];
        _status = data['data']['status'];
        state = ViewState.Error;
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

  Future<UpdatedBaseResponse<dynamic>> activateUser(
      {required String userId}) async {
    state = ViewState.Busy;
    _message = 'Activating user...';
    notifyListeners();

    final body = {
      "request_type": "normal_admin",
      "action": "activate_user",
      "user_id": userId //unique id
    };

    try {
      final response = await ApiService().servicePostRequest(
        data: body,
      );
      final data = response.data;

      if (response.statusCode == 200 || response.statusCode == 201) {
        _status = data['data']['status'];

        _message = data['data']['message'];
        state = ViewState.Success;

        notifyListeners();
        return UpdatedBaseResponse.fromSuccess(data);
      } else {
        _message = data['data']['message'];
        _status = data['data']['status'];
        state = ViewState.Error;
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
