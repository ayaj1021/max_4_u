import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/encryt_data/encrypt_data.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/model/data_plans_model.dart';
import 'package:max_4_u/app/model/load_data_model.dart';
import 'package:max_4_u/app/service/service.dart';

class ReloadUserDataProvider extends ChangeNotifier {
  ViewState state = ViewState.Idle;

  bool isLoading = false;

  String _userLevel = '';
  String get userLevel => _userLevel;

  void updateNumber(String newUserLevel) {
    _userLevel = newUserLevel;
    notifyListeners();
  }

  LoadDataData loadData = LoadDataData();

  TransactionHistory searchTransaction = TransactionHistory();
  Future reloadUserData() async {
    isLoading = true;
    notifyListeners();
    final body = {
      "request_type": "user",
      "action": "load_user_data",
    };
    log('$body');

    final response = await ApiService().servicePostRequest(
      body: body,
      // message: _message,
    );

    // _status = response['data']['status'];

    // final userData = response['data'];

    log('$response');
    try {
      isLoading = false;
      loadData = LoadDataData.fromJson(response['data']);

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
      //final services = userData['services'][0];
      //  final products = userData['products'][0];
      final products = loadData.products;

      // final transactions = userData['transaction_history']['data'];
      //await SecureStorage().saveUserTransactions(transactions);

      await SecureStorage().saveUserBeneficiary(beneficiary!);
      await SecureStorage().saveUserTransactions(transaction!);
      await SecureStorage().saveUserProducts(products!);
      await SecureStorage().saveUserServices(services!);
      await SecureStorage().saveUserType(_userLevel.toString());
      await SecureStorage().saveEncryptedID(uniqueId);
      await SecureStorage().saveUserBalance(balance.toString());
      await SecureStorage().saveFirstName(firstName);
      await SecureStorage().saveLastName(lastName);
      // await SecureStorage().saveUniqueId(uniqueId);
      await SecureStorage().saveEmail(email);
      await SecureStorage().savePhoneNumber(number);
      notifyListeners();
      return loadData;
    } catch (e) {
      isLoading = false;

      notifyListeners();
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
    log(response.toString());
    if (request.statusCode == 200) {
      return DataPlans.fromJson(response);
    } else {
      return DataPlans.fromJson(response);
    }
  }

  // void filterSearchResults(String query) {
  //   _query = query;
  //   if (_query.isEmpty) {
  //     _filteredItems = _items;
  //   } else {
  //     _filteredItems = _items
  //         .where((item) => item.toLowerCase().contains(_query.toLowerCase()))
  //         .toList();
  //   }
  //   notifyListeners();
  // }
}
