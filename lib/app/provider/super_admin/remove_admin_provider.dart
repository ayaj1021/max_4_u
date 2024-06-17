import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/service/service.dart';

class RemoveAdminProvider extends ChangeNotifier {
  ViewState state = ViewState.Idle;
  bool _status = false;
  bool get status => _status;

  String _message = '';
  String get message => _message;

  Future<void> removeAdmin({required String userId}) async {
    state = ViewState.Busy;
    _message = 'Removing admin...';
    notifyListeners();

    final body = {
      "request_type": "grand_admin",
      "action": "remove_admin",
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
