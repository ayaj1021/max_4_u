import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/error_handler/error_handler.dart';
import 'package:max_4_u/app/service/service.dart';

class ActivateAutoRenewalProvider extends ChangeNotifier {
  ViewState state = ViewState.Idle;
  String _message = '';
  String get message => _message;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  bool _status = false;
  bool get status => _status;

  Future<void> activateAutoRenewal({
    required String phoneNumber,
    required String productCode,
    required String amount,
    required String startDate,
    required String endDate,
    required String intervalDaily,
  }) async {
    state = ViewState.Busy;
    _message = 'Processing your request...';
    notifyListeners();
    final userId = await SecureStorage().getEncryptedID();
    final body = {
      "request_type": "user",
      "action": "set_renewal",
      "product_code": productCode,
      "number": phoneNumber,
      "amount": amount,
      "interval": intervalDaily,
      "start_date": startDate,
      "end_date": endDate,
      "user_id": userId,
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
        //if (_status == true) {
        _status = data['status'];
        state = ViewState.Success;
        _message = data['message'];

        notifyListeners();
      } else {
        state = ViewState.Error;
        _status = data['status'];
        _message = data['message'];

        _errorMessage =
            data['error_data']['start_date'] ?? data['error_data']['end_date'];
        // _message = response['data']['error_data']['start_date'];
        // _message = response['data']['error_data']['end_date'];

        notifyListeners();
      }
    } on DioException catch (e) {
      return ExceptionHandler.handleError(e);
    }
  }
}
