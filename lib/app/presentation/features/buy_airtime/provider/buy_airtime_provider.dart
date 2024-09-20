import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:max_4_u/app/config/base_response/updated_base_response.dart';
import 'package:max_4_u/app/config/exception/app_exception.dart';
import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';

import 'package:max_4_u/app/service/service.dart';

class BuyAirtimeProvider extends ChangeNotifier {
  ViewState state = ViewState.Idle;
  String _message = '';
  String get message => _message;
  bool _status = false;
  bool get status => _status;

  Future<UpdatedBaseResponse<dynamic>> buyAirtime(
      {required String amount,
      required String productCode,
      required String phoneNumber}) async {
    state = ViewState.Busy;
    _message = 'Processing your request...';
    notifyListeners();

    final id = await SecureStorage().getEncryptedID();

    final body = {
      "request_type": "user",
      "action": "buy_airtime",
      "product_code": productCode,
      "user_id": id,
      "number": phoneNumber,
      "amount": amount,
    };

    final response = await ApiService().servicePostRequest(
      data: body,
    );
    final data = response.data;
    log(response.toString());
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        _status = data['data']['status'];
        state = ViewState.Success;
        _message = data['data']['message'];

        notifyListeners();
        return UpdatedBaseResponse.fromSuccess(data);
      } else {
        _status = data['data']['status'];
        state = ViewState.Error;

        var errorData = data['data']['error_data'];
        if (errorData != null || errorData.isNotEmpty) {
          _message = data['data']['error_data']['number'];
        } else {
          _message = data['data']['message'];
        }

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
      // Handle any other exceptions
      _message = 'An unexpected error occurred: $e';
      _status = false;
      state = ViewState.Error;
      notifyListeners();
      return UpdatedBaseResponse.fromError(_message);
    }
  }
}
