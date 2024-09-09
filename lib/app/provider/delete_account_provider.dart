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
        data: body,
      );

      final data = response.data;

      _status = data['status'];
      _message = data['message'];
      if (response.statusCode == 200 || response.statusCode == 201) {
        // if (_status == true) {
        _status = data['status'];
        state = ViewState.Success;

        _message = data['message'];
        notifyListeners();
        return data;
      } else {
        _message = data['message'];
        _status = data['status'];
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
