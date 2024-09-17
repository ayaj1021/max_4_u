import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:max_4_u/app/config/base_response/updated_base_response.dart';
import 'package:max_4_u/app/config/exception/app_exception.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/model/vendor/generate_account_model.dart';
import 'package:max_4_u/app/service/service.dart';

class GenerateAccountProvider extends ChangeNotifier {
  ViewState state = ViewState.Idle;
  bool _status = false;
  bool get status => _status;

  String _message = '';
  String get message => _message;

  BankData bankData = BankData();

  Future<UpdatedBaseResponse<dynamic>> generateAccount() async {
    state = ViewState.Busy;
    _message = 'Generating account details...';
    notifyListeners();

    final body = {
      "request_type": "reseller",
      "action": "generate_bank_account"
    };
    log('$body');

    final response = await ApiService().servicePostRequest(
      data: body,
      // message: _message,
    );
    final data = response.data;
    _status = data['data']['status'];
    log('this is all user response $response');
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        //if (_status == true) {
        _status = data['data']['status'];

        bankData = BankData.fromJson(data['data']['response_data']);
        _message = data['data']['message'];
        state = ViewState.Success;

        notifyListeners();
        return UpdatedBaseResponse.fromSuccess(bankData);
      } else {
        _message = data['data']['message'];
        _status = data['data']['status'];
        state = ViewState.Error;
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
