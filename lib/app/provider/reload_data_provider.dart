import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/encryt_data/encrypt_data.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
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

  List<String> _items = [];
  List<String> _filteredItems = [];
  List<TransactionHistory>? query = [];

  List<String> get items => _filteredItems;

  LoadDataData loadData = LoadDataData();
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

    final userData = response['data'];

    log('$response');
    try {
      isLoading = false;
      loadData = LoadDataData.fromJson(response['data']);

      _items = loadData.transactionHistory!.data!
          .map((item) => item.toString())
          .toList();
      _filteredItems = _items;
      final firstName =
          //  EncryptData.decryptAES('${userData['user_data'][0]['first_name']}');
          EncryptData.decryptAES('${loadData.userData![0].firstName}');
      await SecureStorage().saveFirstName(firstName);

      final lastName =
          EncryptData.decryptAES('${loadData.userData![0].lastName}');
      //  EncryptData.decryptAES('${userData['user_data'][0]['last_name']}');
      log('last name is $lastName');
      final uniqueId =
          EncryptData.decryptAES('${loadData.userData![0].uniqueId}');
      // EncryptData.decryptAES('${userData['user_data'][0]['unique_id']}');
      log('uniqueId is $uniqueId');
      final email = EncryptData.decryptAES('${loadData.userData![0].email}');
      //   EncryptData.decryptAES('${userData['user_data'][0]['email']}');
      log('uniqueId is $email');
      final number =
          // EncryptData.decryptAES( '${userData['user_data'][0]['mobile_number']}');
          EncryptData.decryptAES('${loadData.userData![0].mobileNumber}');
      log('number is $number');
      // final balance = userData['user_data'][0]['balance'];
      final balance = loadData.userAccount!.balance;
      //  final userType = userData['user_data'][0]['level'];
      _userLevel = loadData.userData![0].level!;
      log('this is user level: ${_userLevel}');
      // _userLevel = resDataData.userData![0].level!;
      updateNumber(_userLevel);

      // final beneficiary = userData['beneficiary_data'][0];
      final beneficiary = loadData.beneficiaryData;
      log('user type is $_userLevel');
      log('user balance is $balance');
      final services = loadData.services;
      //final services = userData['services'][0];
      //  final products = userData['products'][0];
      final products = loadData.products;

     // final transactions = userData['transaction_history']['data'];
      //await SecureStorage().saveUserTransactions(transactions);

      await SecureStorage()
          .saveUserEncryptedId('${userData['user_data'][0]['unique_id']}');
      await SecureStorage().saveUserBeneficiary(beneficiary!);
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

   searchTransactions({required String search}) async {
    final result = loadData.transactionHistory!.data!.where((element) =>
        element.purchaseType!.toLowerCase().contains(search.toLowerCase()));

    query = result.cast<TransactionHistory>().toList();
    notifyListeners();
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
