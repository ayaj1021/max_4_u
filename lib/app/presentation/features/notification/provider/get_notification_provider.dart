import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:max_4_u/app/config/base_response/updated_base_response.dart';
import 'package:max_4_u/app/config/exception/app_exception.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/model/notification_model.dart';
import 'package:max_4_u/app/service/service.dart';

class GetNotificationProvider extends ChangeNotifier {
  ViewState state = ViewState.Idle;
  bool _status = false;
  bool get status => _status;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String _message = '';
  String get message => _message;

  NotificationResponseData allNotifications = NotificationResponseData();

  Future<UpdatedBaseResponse<dynamic>> getAllNotification() async {
    final body = {
      "request_type": "user",
      "action": "load_notification",
    };
    _isLoading = true;

    try {
      final response = await ApiService().servicePostRequest(
        data: body,
        // message: _message,
      );

      final data = response.data;
      _status = data['data']['status'];
      if (response.statusCode == 200 || response.statusCode == 201) {
        // if (_status == true) {
        allNotifications = NotificationResponseData.fromJson(data);
        state = ViewState.Success;
        _isLoading = false;
        notifyListeners();
        return UpdatedBaseResponse.fromSuccess(data);
      } else {
        _isLoading = false;
        state = ViewState.Error;
        _status = data['data']['status'];
        _message = data['data']['message'];
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
