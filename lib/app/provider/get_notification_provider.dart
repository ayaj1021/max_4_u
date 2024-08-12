import 'package:flutter/material.dart';
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

  Future getAllNotification() async {
    final body = {
      "request_type": "user",
      "action": "load_notification",
    };
    _isLoading = true;
    final response = await ApiService().servicePostRequest(
      body: body,
      // message: _message,
    );
    _status = response['data']['status'];

    if (_status == true) {
      allNotifications = NotificationResponseData.fromJson(response['data']);
      state = ViewState.Success;
      _isLoading = false;
      notifyListeners();
      return allNotifications;
    } else {
      _isLoading = false;
      state = ViewState.Error;
      _status = response['data']['status'];
      _message = response['data']['message'];
      notifyListeners();
    }
  }
}
