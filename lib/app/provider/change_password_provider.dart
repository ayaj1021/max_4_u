import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/service/service.dart';

class ChangePasswordProvider extends ChangeNotifier {
  ViewState state = ViewState.Idle;

  String _message = '';
  String get message => _message;

  bool _status = false;
  bool get status => _status;

  Future<void> changePassword(
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
    log('$body');

    try {
      final response = await ApiService().servicePostRequest(
        body: body,
        // message: _message,
      );
      log(response);

      _status = response['data']['status'];
      if (_status == true) {
        state = ViewState.Success;
        _status = response['data']['status'];

        _message = response['data']['message'];
        notifyListeners();
      } else {
        state = ViewState.Error;
        _status = response['data']['status'];
        _message = response['data']['message'];

        //  _message = res['data']['response_data']['error_data']['email'];
        notifyListeners();
      }
    } catch (e) {
      state = ViewState.Error;
      _message = e.toString();
      notifyListeners();
    }
  }
}
