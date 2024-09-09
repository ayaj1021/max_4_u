import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/error_handler/error_handler.dart';
import 'package:max_4_u/app/service/service.dart';

class ApproveVendorRequestProvider extends ChangeNotifier {
  ViewState state = ViewState.Idle;
  bool _status = false;
  bool get status => _status;

  String _message = '';
  String get message => _message;

  Future<void> approveVendorRequest({required String userId}) async {
    state = ViewState.Busy;
    _message = 'Deleting request...';
    notifyListeners();

    final body = {
      "request_type": "normal_admin",
      "action": "accept_request",
      "user_id": userId //unique id
    };
    log('$body');

    final response = await ApiService().servicePostRequest(
      data: body,
      // message: _message,
    );
    final data = response.data;
    _status = data['status'];
    log('this is all user response $response');
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        //if (_status == true) {
        _status = data['status'];

        _message = data['message'];
        state = ViewState.Success;

        notifyListeners();
        return data;
      } else {
        _message = data['message'];
        _status = data['status'];
        state = ViewState.Error;
        notifyListeners();
      }
    } on DioException catch (e) {
      return ExceptionHandler.handleError(e);
      // log(e.toString());
      // _status = false;
      //   state = ViewState.Error;
      // notifyListeners();
    }
  }
}
