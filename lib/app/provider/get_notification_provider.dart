import 'package:flutter/material.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/service/service.dart';

class GetNotificationProvider extends ChangeNotifier {
  ViewState state = ViewState.Idle;
  bool _status = false;
  bool get status => _status;
  List _data = [];
  List get data => _data;
  String _message = '';
  String get message => _message;

  Future<void> getAllNotification() async {
    final body = {
      "request_type": "user",
      "action": "load_notification",
    };

    final response = await ApiService().servicePostRequest(
      body: body,
      // message: _message,
    );
    _status = response['data']['status'];

    if (_status == true) {
      final userData = response['data']['response_data']['data'];
      state = ViewState.Success;

      _data = userData;
      notifyListeners();
    } else {
      state = ViewState.Error;
      _status = response['data']['status'];
      _message = response['data']['message'];
      notifyListeners();
    }
  }
}
