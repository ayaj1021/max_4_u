import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/service/service.dart';

class ChangePasswordProvider extends ChangeNotifier {
  ViewState state = ViewState.Idle;
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();

  String _message = '';
  String get message => _message;

  bool _status = false;
  bool get status => _status;

  Future<void> changePassword() async {
    state = ViewState.Busy;
    _message = 'Changing your password...';
    notifyListeners();

    final body = {
      "request_type": "user",
      "action": "change_password",
      "old_password": oldPasswordController.text.trim(),
      "password": newPasswordController.text.trim(),
      "confirm_password": confirmNewPasswordController.text.trim()
    };

    try {
      final response = await ApiService.instance.servicePostRequest(
        body: body,
        // message: _message,
      );
      //print(response);

      final res = jsonDecode(response.body);
      print(res);
      if (response.statusCode == 200) {
        _status = res['data']['status'];
        if (_status == true) {
          state = ViewState.Success;

          _message = res['data']['message'];
          notifyListeners();
        } else {
          state = ViewState.Error;
          _message = res['data']['message'];

          //  _message = res['data']['response_data']['error_data']['email'];
          notifyListeners();
        }
      } else {
        print(_message = res['data']['message']);

        state = ViewState.Error;
        notifyListeners();
      }
    } on SocketException catch (_) {
      state = ViewState.Error;
      _message = 'Network error. Please try again later';
      notifyListeners();
    } catch (e) {
      state = ViewState.Error;
      _message = e.toString();
      notifyListeners();
    }
  }
}
