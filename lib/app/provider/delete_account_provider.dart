
import 'package:flutter/material.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/service/service.dart';

class DeleteAccountProvider extends ChangeNotifier {
  ViewState state = ViewState.Idle;

  String _message = '';
  String get message => _message;

  bool _status = false;
  bool get status => _status;

  Future<void> deleteAccount() async {
    state = ViewState.Busy;
    _message = 'Deleting your account...';
    notifyListeners();

    final body = {
      "request_type": "user",
      "action": "delete_account",
    };
    debugPrint(body.toString());
    try {
      final response = await ApiService().servicePostRequest(
        body: body,
      );

      _status = response['data']['status'];
      _message = response['data']['message'];

      if (_status == true) {
        _status = response['data']['status'];
        state = ViewState.Success;

        _message = response['data']['message'];
        notifyListeners();
      } else {
        _message = response['data']['message'];
        _status = response['data']['status'];
        state = ViewState.Error;
        notifyListeners();
      }
    } catch (e) {
      state = ViewState.Error;
      _status = false;
      notifyListeners();
    }
  }
}
