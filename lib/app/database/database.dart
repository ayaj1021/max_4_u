import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _storage = FlutterSecureStorage(
    iOptions: IOSOptions.defaultOptions,
    aOptions: AndroidOptions.defaultOptions,
  );
  saveUserPhone(String phoneNumber) async {
    await _storage.write(key: 'phone_number', value: phoneNumber);
  }

  getUserPhone() async {
    String? value = await _storage.read(key: 'phone_number');
    return value;
  }

  saveUserBalance(String balance) async {
    await _storage.write(key: 'user_balance', value: balance);
  }

  getUserBalance() async {
    String? value = await _storage.read(key: 'user_balance');
    return value;
  }

  saveUserType(String level) async {
    await _storage.write(key: 'user_level', value: level);
  }

  getUserType() async {
    String? value = await _storage.read(key: 'user_level');
    return value;
  }

  saveEncryptedID(String encryptedId) async {
    await _storage.write(key: 'encrypted_id', value: encryptedId);
  }

  getEncryptedID() async {
    String? value = await _storage.read(key: 'encrypted_id');
    return value;
  }

  saveUserName(String name) async {
    await _storage.write(key: 'user_name', value: name);
  }

  getUserName() async {
    String? value = await _storage.read(key: 'user_name');
    return value;
  }

  saveFirstName(String firstName) async {
    await _storage.write(key: 'first_name', value: firstName);
  }

  getFirstName() async {
    String? value = await _storage.read(key: 'first_name');
    return value;
  }

  saveLastName(String lastName) async {
    await _storage.write(key: 'last_name', value: lastName);
  }

  getLastName() async {
    String? value = await _storage.read(key: 'last_name');
    return value;
  }

  savePhoneNumber(String phoneNumber) async {
    await _storage.write(key: 'number', value: phoneNumber);
  }

  getPhoneNumber() async {
    String? value = await _storage.read(key: 'number');
    return value;
  }

  saveCustomerPhoneNumber(String phoneNumber) async {
    await _storage.write(key: 'customer_number', value: phoneNumber);
  }

  getCustomerPhoneNumber() async {
    String? value = await _storage.read(key: 'customer_number');
    return value;
  }

  saveCustomerOtp(String otp) async {
    await _storage.write(key: 'customer_otp', value: otp);
  }

  getCustomerOtp() async {
    String? value = await _storage.read(key: 'customer_otp');
    return value;
  }

  saveUniqueId(String id) async {
    await _storage.write(key: 'unique_id', value: id);
  }

  getUniqueId() async {
    String? value = await _storage.read(key: 'unique_id');
    return value;
  }

  saveEmail(String email) async {
    await _storage.write(key: 'email', value: email);
  }

  getEmail() async {
    String? value = await _storage.read(key: 'email');
    return value;
  }

  saveUserEncryptedId(String encryptedId) async {
    await _storage.write(key: 'encryptedId', value: encryptedId);
  }

  getUserEncryptedId() async {
    String? value = await _storage.read(key: 'encryptedId');
    return value;
  }

  saveUserEmail(String email) async {
    await _storage.write(key: 'user_email', value: email);
  }

  getUserEmail() async {
    String? value = await _storage.read(key: 'user_email');
    return value;
  }

  saveUserPassword(String password) async {
    await _storage.write(key: 'user_password', value: password);
  }

  getUserPassword() async {
    String? value = await _storage.read(key: 'user_password');
    return value;
  }

  saveUserOtp(String otp) async {
    await _storage.write(key: 'user_otp', value: otp);
  }

  getUserOtp() async {
    String? value = await _storage.read(key: 'user_otp');
    return value;
  }

  saveUserLevel(String level) async {
    await _storage.write(key: 'user_level', value: level);
  }

  getUserLevel() async {
    String? value = await _storage.read(key: 'user_level');
    return value;
  }

  saveUserServices(List services) async {
    String jsonString = jsonEncode(services);
    await _storage.write(key: 'services_list', value: jsonString);
  }

  getUserServices() async {
    String? jsonString = await _storage.read(key: 'services_list');

    if (jsonString != null) {
      List<dynamic> jsonList = jsonDecode(jsonString);
      List services = jsonList.map((item) => item).toList();
      return services;
    }
    return null;
  }

  saveUserAutoRenewal(List autoRenewal) async {
    String jsonString = jsonEncode(autoRenewal);
    await _storage.write(key: 'auto_renewal_list', value: jsonString);
  }

  getUserAutoRenewal() async {
    String? jsonString = await _storage.read(key: 'auto_renewal_list');

    if (jsonString != null) {
      List<dynamic> jsonList = jsonDecode(jsonString);
      List services = jsonList.map((item) => item).toList();
      return services;
    }
    return null;
  }

  saveUserTransactions(List transactions) async {
    String jsonString = jsonEncode(transactions);
    await _storage.write(key: 'transaction_list', value: jsonString);
  }

  getUserTransactions() async {
    String? jsonString = await _storage.read(key: 'transaction_list');

    if (jsonString != null) {
      List<dynamic> jsonList = jsonDecode(jsonString);
      List transactions = jsonList.map((item) => item).toList();
      return transactions;
    }
    return null;
  }

  saveUserProducts(List products) async {
    String jsonString = jsonEncode(products);
    await _storage.write(key: 'products_list', value: jsonString);
  }

  getUserProducts() async {
    String? jsonString = await _storage.read(key: 'products_list');

    if (jsonString != null) {
      List<dynamic> jsonList = jsonDecode(jsonString);
      List products = jsonList.map((item) => item).toList();
      return products;
    }
    return null;
  }

  saveUserBeneficiary(List beneficiary) async {
    String jsonString = jsonEncode(beneficiary);
    await _storage.write(key: 'beneficiary_list', value: jsonString);
  }

  getUserBeneficiary() async {
    String? jsonString = await _storage.read(key: 'beneficiary_list');

    if (jsonString != null) {
      List<dynamic> jsonList = jsonDecode(jsonString);
      List beneficiary = jsonList.map((item) => item).toList();
      return beneficiary;
    }
    return null;
  }

  saveUserTransactionHistory(List transactionHistory) async {
    String jsonString = jsonEncode(transactionHistory);
    await _storage.write(key: 'transaction_history', value: jsonString);
  }

  getUserTransactionHistory() async {
    String? jsonString = await _storage.read(key: 'transaction_history');

    if (jsonString != null) {
      List<dynamic> jsonList = jsonDecode(jsonString);
      List beneficiary = jsonList.map((item) => item).toList();
      return beneficiary;
    }
    return null;
  }

  logoutUser() async {
    await _storage.deleteAll();
    //await _storage.deleteAll();
  }
}
