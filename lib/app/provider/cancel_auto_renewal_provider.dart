import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/error_handler/error_handler.dart';
import 'package:max_4_u/app/service/service.dart';

class CancelAutoRenewalProvider extends ChangeNotifier {
  ViewState state = ViewState.Idle;
  String _message = '';
  String get message => _message;

  bool _status = false;
  bool get status => _status;

  Future<void> cancelAutoRenewal({
    required String id,
  }) async {
    state = ViewState.Busy;
    _message = 'Processing your request...';
    notifyListeners();

    final body = {
      "request_type": "user",
      "action": "cancel_renewal",
      "renewal_id": id
    };

    debugPrint(body.toString());

    final response = await ApiService().servicePostRequest(
      data: body,
      // message: _message,
    );

    final data = response.data;

    _status = data['status'];
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        // if (_status == true) {
        _status = data['status'];
        state = ViewState.Success;
        _message = data['message'];

        notifyListeners();
        return data;
      } else {
        state = ViewState.Error;
        _status = data['status'];
        _message = data['message'];

        notifyListeners();
      }
    } on DioException catch (e) {
      return ExceptionHandler.handleError(e);
    }
  }
}
