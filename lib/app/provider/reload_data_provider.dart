import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:max_4_u/app/config/base_response/updated_base_response.dart';
import 'package:max_4_u/app/config/exception/app_exception.dart';
import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/encryt_data/encrypt_data.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/model/data_plans_model.dart';
import 'package:max_4_u/app/model/load_data_model.dart';
import 'package:max_4_u/app/service/service.dart';

class ReloadUserDataProvider extends ChangeNotifier {
  ViewState state = ViewState.Idle;

  bool _status = false;
  bool get status => _status;

  String _message = '';
  String get message => _message;

  bool isLoading = false;

  String _userLevel = '';
  String get userLevel => _userLevel;

  void updateNumber(String newUserLevel) {
    _userLevel = newUserLevel;
    notifyListeners();
  }

  LoadDataData loadData = LoadDataData();

  TransactionHistory searchTransaction = TransactionHistory();
  Future<UpdatedBaseResponse<dynamic>> reloadUserData() async {
    isLoading = true;
    notifyListeners();
    final body = {
      "request_type": "user",
      "action": "load_user_data",
    };

    try {
      final response = await ApiService().servicePostRequest(
        data: body,
      );
      isLoading = false;

      final data = response.data;

      if (response.statusCode == 200 || response.statusCode == 201) {
        state = ViewState.Success;
        loadData = LoadDataData.fromJson(data['data']);

        notifyListeners();

        final firstName =
            EncryptData.decryptAES('${loadData.userData![0].firstName}');
        await SecureStorage().saveFirstName(firstName);

        final lastName =
            EncryptData.decryptAES('${loadData.userData![0].lastName}');

        final uniqueId =
            EncryptData.decryptAES('${loadData.userData![0].uniqueId}');

        final email = EncryptData.decryptAES('${loadData.userData![0].email}');

        final number =
            EncryptData.decryptAES('${loadData.userData![0].mobileNumber}');

        final balance = loadData.userAccount!.balance;

        _userLevel = loadData.userData![0].level!;

        updateNumber(_userLevel);

        final beneficiary = loadData.beneficiaryData;
        final transaction = loadData.transactionHistory;

        final services = loadData.services;

        final products = loadData.products;

        await SecureStorage().saveUserBeneficiary(beneficiary!);
        await SecureStorage().saveUserTransactions(transaction!);
        await SecureStorage().saveUserProducts(products!);
        await SecureStorage().saveUserServices(services!);
        await SecureStorage().saveUserType(_userLevel.toString());
        await SecureStorage().saveEncryptedID(uniqueId);
        await SecureStorage().saveUserBalance(balance.toString());
        await SecureStorage().saveFirstName(firstName);
        await SecureStorage().saveLastName(lastName);

        await SecureStorage().saveEmail(email);
        await SecureStorage().savePhoneNumber(number);
        notifyListeners();

        return UpdatedBaseResponse.fromSuccess(loadData);
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
      isLoading = false;

      _message = 'An unexpected error occurred: $e';
      _status = false;
      state = ViewState.Error;
      notifyListeners();
      return UpdatedBaseResponse.fromError(_message);
    }
  }

  Future<DataPlans> fetchData() async {
    isLoading = true;
    notifyListeners();
    final encryptedId = await SecureStorage().getUserEncryptedId();

    var request = await http.post(
      Uri.parse("https://api.max4u.com.ng"),
      headers: {
        'Site-From': 'postman',
        'User-Key': encryptedId,
      },
      body: {
        "request_type": "user",
        "action": "load_user_data",
      },
    );
    isLoading = false;
    notifyListeners();
    var response = jsonDecode(request.body);

    if (request.statusCode == 200) {
      return DataPlans.fromJson(response);
    } else {
      return DataPlans.fromJson(response);
    }
  }
}
