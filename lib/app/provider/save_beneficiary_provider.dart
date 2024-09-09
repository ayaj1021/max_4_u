import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/error_handler/error_handler.dart';
import 'package:max_4_u/app/service/service.dart';

class SaveBeneficiaryProvider extends ChangeNotifier {
  ViewState state = ViewState.Idle;
  String _message = '';
  String get message => _message;
  bool _status = false;
  bool get status => _status;

  Future<void> saveToBeneficiary({
    required String phoneNumber,
    required String beneficiaryName,
  }) async {
    state = ViewState.Busy;
    _message = 'Saving your beneficiary...';
    notifyListeners();

    final body = {
      "request_type": "user",
      "action": "save_beneficiary",
      "mobile_number": phoneNumber,
      "name": beneficiaryName,
    };
    log('$body');

    final response = await ApiService().servicePostRequest(
      data: body,
      // message: _message,
    );

    final data = response.data;

    _message = data['message'];

    log('$_status');
    log('$response');
    try {
      _status = data['status'];
      if (response.statusCode == 200 || response.statusCode == 201) {
        //  if (_status == true) {
        _status = data['status'];
        state = ViewState.Success;
        _message = data['message'];

        notifyListeners();
        return data;
      } else {
        _status = data['status'];
        state = ViewState.Error;
        _message = data['message'];
        notifyListeners();
      }
    } on DioException catch (e) {
      return ExceptionHandler.handleError(e);
      // log(e.toString());
      // _status = false;
      // notifyListeners();
    }
  }
}
