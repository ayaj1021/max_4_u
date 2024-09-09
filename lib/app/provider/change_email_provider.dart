import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/error_handler/error_handler.dart';
import 'package:max_4_u/app/service/service.dart';

class ChangeEmailProvider extends ChangeNotifier {
  ViewState state = ViewState.Idle;
  final otpController = TextEditingController();
  final emailController = TextEditingController();
  String _message = '';
  String get message => _message;

  bool _status = false;
  bool get status => _status;

  Future<void> changeEmail() async {
    state = ViewState.Busy;
    _message = 'Updating your email address...';
    notifyListeners();

    final body = {
      "request_type": "user",
      "action": "update_email",
      "email": "ajayiayodele23@gmail.com"
    };

    try {
      final response = await ApiService().servicePostRequest(
        data: body,
        // message: _message,
      );
      //print(response);
      final data = response.data;
      final res = jsonDecode(response.data);
      print(res);
      if (response.statusCode == 200) {
        _status = data['status'];
        if (_status == true) {
          state = ViewState.Success;

          _message = data['message'];
          notifyListeners();
        } else {
          state = ViewState.Error;

          _message = data['response_data']['error_data']['email'];
          notifyListeners();
        }
      } else {
        print(_message = data['message']);

        state = ViewState.Error;
        notifyListeners();
      }
    } on DioException catch (e) {
      return ExceptionHandler.handleError(e);
      // state = ViewState.Error;
      // _message = e.toString();
      // notifyListeners();
    }
  }
}
