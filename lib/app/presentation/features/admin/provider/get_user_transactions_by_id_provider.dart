import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:max_4_u/app/error_handler/error_handler.dart';
import 'package:max_4_u/app/model/super_admin/get_user_transaction_id_model.dart';
import 'package:max_4_u/app/service/service.dart';

class GetUserTransactionProvider extends ChangeNotifier {
  bool isLoading = false;
  bool _status = false;
  bool get status => _status;

  GetUserTransactionByIdResponse userTransactions =
      GetUserTransactionByIdResponse();

  Future userTransactionsById({required String userId}) async {
    isLoading = true;
    notifyListeners();

    final body = {
      "request_type": "general",
      "action": "get_transaction",
      "userid": userId,
    };

    try {
      final response = await ApiService().servicePostRequest(
        data: body,
        // message: _message,
      );
      final data = response.data;

      log('this is all user response $response');
      if (response.statusCode == 200 || response.statusCode == 201) {
        // if (_status == true) {
        _status = data['data']['status'];
        userTransactions = GetUserTransactionByIdResponse.fromJson({
          'data': {'response_data': data['data']['response_data']}
        });

        // userTransactions = GetUserTransactionByIdResponse.fromJson(
        //     data['data']['response_data']);
        isLoading = false;

        notifyListeners();
        return userTransactions;
      } else {
        _status = data['data']['status'];
        isLoading = false;

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
