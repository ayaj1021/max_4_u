import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/encryt_data/encrypt_data.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/service/service.dart';

class ReloadUserDataProvider extends ChangeNotifier {
  ViewState state = ViewState.Idle;
  bool _status = false;
  bool get status => _status;

  Future<void> reloadUserData() async {
    final body = {
      "request_type": "user",
      "action": "load_user_data",
    };
    log('$body');

    final response = await ApiService.instance.servicePostRequest(
      body: body,
      // message: _message,
    );

    // _status = response['data']['status'];

    final userData = response['data']['response_data']['data'];

    log('$_status');
    log('$response');
    try {
      final firstName =
          EncryptData.decryptAES('${userData['user_data'][0]['first_name']}');
      await SecureStorage().saveFirstName(firstName);

      final lastName =
          EncryptData.decryptAES('${userData['user_data'][0]['last_name']}');
      log('last name is $lastName');
      final uniqueId =
          EncryptData.decryptAES('${userData['user_data'][0]['unique_id']}');
      log('uniqueId is $uniqueId');
      final email =
          EncryptData.decryptAES('${userData['user_data'][0]['email']}');
      log('uniqueId is $email');
      final number = EncryptData.decryptAES(
          '${userData['user_data'][0]['mobile_number']}');
      log('number is $number');
      final balance = userData['user_data'][0]['balance'];
      final userType = userData['user_data'][0]['level'];

      final beneficiary = userData['beneficiary_data'][0];
      log('user type is $userType');
      log('user balance is $balance');
      final services = userData['services'][0];
      final products = userData['products'][0];

      final transactions = userData['transaction_history']['data'];
      await SecureStorage().saveUserTransactions(transactions);

      await SecureStorage()
          .saveUserEncryptedId('${userData['user_data'][0]['unique_id']}');
      await SecureStorage().saveUserBeneficiary(beneficiary!);
      await SecureStorage().saveUserProducts(products);
      await SecureStorage().saveUserServices(services);
      await SecureStorage().saveUserType(userType.toString());
      await SecureStorage().saveEncryptedID(uniqueId);
      await SecureStorage().saveUserBalance(balance.toString());
      await SecureStorage().saveFirstName(firstName);
      await SecureStorage().saveLastName(lastName);
      await SecureStorage().saveUniqueId(uniqueId);
      await SecureStorage().saveEmail(email);
      await SecureStorage().savePhoneNumber(number);
    } catch (e) {
      _status = false;
      notifyListeners();
    }
  }
}
