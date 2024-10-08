import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:max_4_u/app/config/base_response/updated_base_response.dart';
import 'package:max_4_u/app/config/exception/app_exception.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/service/service.dart';

class RemoveCustomerProvider extends ChangeNotifier {
  ViewState state = ViewState.Idle;
  String _message = '';
  String get message => _message;
  bool _status = false;
  bool get status => _status;

  Future<UpdatedBaseResponse<dynamic>> removeCustomer({
    required String userId,
  }) async {
    state = ViewState.Busy;
    _message = 'Removing your customer...';
    notifyListeners();

    final body = {
      "request_type": "reseller",
      "action": "remove_client",
      "beneficiary_id": userId,
    };
    log('$body');

    try {
      final response = await ApiService().servicePostRequest(
        data: body,
        // message: _message,
      );

      final data = response.data;

      _status = data['data']['status'];
      _message = data['data']['message'];

      log('$_status');
      log('$response');
      if (response.statusCode == 200 || response.statusCode == 201) {
        // if (_status == true) {
        _status = data['data']['status'];
        state = ViewState.Success;
        _message = data['data']['message'];

        notifyListeners();

        return UpdatedBaseResponse.fromSuccess(data);
      } else {
        _status = data['data']['status'];
        state = ViewState.Error;
        _message = data['data']['message'];
        //  _message = response['data']['error_data']['mobile_number'];

        notifyListeners();
        return UpdatedBaseResponse.fromError(_message);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        _message = 'Unauthorized request. Please check your credentials.';
      } else if (e.error is SocketException) {
        _message = 'No Internet connection or server is unreachable.';
      } else {
        _message = AppException.handleError(e).toString();
      }

      _status = false;
      state = ViewState.Error;
      notifyListeners();

      return UpdatedBaseResponse.fromError(_message);
    } catch (e) {
      _message = 'An unexpected error occurred: $e';
      _status = false;
      state = ViewState.Error;
      notifyListeners();
      return UpdatedBaseResponse.fromError(_message);
    }
  }
}
