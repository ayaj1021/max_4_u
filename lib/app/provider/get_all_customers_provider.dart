import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:max_4_u/app/config/base_response/updated_base_response.dart';
import 'package:max_4_u/app/config/exception/app_exception.dart';
import 'package:max_4_u/app/encryt_data/encrypt_data.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/service/service.dart';

class GetAllCustomersProvider extends ChangeNotifier {
  ViewState state = ViewState.Idle;
  bool _status = false;
  bool get status => _status;
  List _data = [];
  List get data => _data;
  String _message = '';
  String get message => _message;
  String firstName = '';
  String lastName = '';
  String mobileNumber = '';
  String uniqueId = '';

  Future<UpdatedBaseResponse<dynamic>> getAllCustomers() async {
    final body = {
      "request_type": "reseller",
      "action": "load_my_clients",
      "current_page": 1
    };

    final response = await ApiService().servicePostRequest(
      data: body,
      // message: _message,
    );

    final data = response.data;
    _status = data['data']['status'];
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        // if (_status == true) {
        final userData = data['data']['response_data']['data'];
        state = ViewState.Success;

        firstName = EncryptData.decryptAES('${userData[0]['first_name']}');
        lastName = EncryptData.decryptAES('${userData[0]['last_name']}');
        mobileNumber =
            EncryptData.decryptAES('${userData[0]['mobile_number']}');
        uniqueId = EncryptData.decryptAES('${userData[0]['unique_id']}');

        _data = userData;
        notifyListeners();
        return UpdatedBaseResponse.fromSuccess(data);
      } else {
        state = ViewState.Error;
        _status = data['data']['status'];
        _message = data['data']['message'];
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
