import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/service/service.dart';

class DenyVendorRequestProvider extends ChangeNotifier {
  ViewState state = ViewState.Idle;
  bool _status = false;
  bool get status => _status;

  String _message = '';
  String get message => _message;

  Future<void> denyVendorRequest({required String userId}) async {
    state = ViewState.Busy;
    _message = 'Deleting request...';
    notifyListeners();

    final body = {
      "request_type": "normal_admin",
      "action": "reject_request",
      "user_id": userId //unique id
    };

    log('$body');

    final response = await ApiService().servicePostRequest(
      body: body,
      // message: _message,
    );
    _status = response['data']['status'];
    log('this is all user response $response');
    try {
      if (_status == true) {
        _status = response['data']['status'];

        _message = response['data']['message'];
        state = ViewState.Success;

        notifyListeners();
      } else {
        _message = response['data']['message'];
        _status = response['data']['status'];
        state = ViewState.Error;
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      _status = false;
      state = ViewState.Error;
      notifyListeners();
    }
  }
}
