import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/error_handler/error_handler.dart';
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

  Future getAllNotification() async {
    final body = {
      "request_type": "user",
      "action": "load_notification",
    };
    _isLoading = true;
    final response = await ApiService().servicePostRequest(
      data: body,
      // message: _message,
    );

    final data = response.data;
    _status = data['data']['status'];
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        // if (_status == true) {
        allNotifications = NotificationResponseData.fromJson(data);
        state = ViewState.Success;
        _isLoading = false;
        notifyListeners();
        return allNotifications;
      } else {
        _isLoading = false;
        state = ViewState.Error;
        _status = data['data']['status'];
        _message = data['data']['message'];
        notifyListeners();
      }
    } on DioException catch (e) {
      return ExceptionHandler.handleError(e);
    }
  }
}
