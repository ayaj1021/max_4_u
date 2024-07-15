import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:max_4_u/app/model/load_data_model.dart';

class SecureStorage {
  SecureStorage._();

  // Singleton instance
  static final SecureStorage _instance = SecureStorage._();

  // Factory constructor to return the same instance every time
  factory SecureStorage() => _instance;

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

  Future<void>  saveUserBalance(String balance) async {
    await _storage.write(key: 'user_balance', value: balance);
  }

  Future<String?>  getUserBalance() async {
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

  Future<void> saveUserEncryptedId(String encryptedId) async {
    await _storage.write(key: 'encryptedId', value: encryptedId);
  }

  Future getUserEncryptedId() async {
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

  Future<void> saveUserServices(List<Service> services) async {
    final jsonString = jsonEncode(services.map((s) => s.toJson()).toList());
    await _storage.write(key: 'service_list', value: jsonString);
  }

  Future<List<Service>?> getUserServices() async {
    final jsonString = await _storage.read(key: 'service_list');
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((item) => Service.fromJson(item)).toList();
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

  Future<void> saveUserTransactions(
      TransactionHistory transactionHistory) async {
    String jsonString = jsonEncode(transactionHistory.toJson());
    await _storage.write(key: 'transaction_list', value: jsonString);
  }

  Future<TransactionHistory?> getUserTransactions() async {
    String? jsonString = await _storage.read(key: 'transaction_list');
    if (jsonString != null) {
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return TransactionHistory.fromJson(jsonMap);
    }
    return null;
  }

  Future<void> saveUserProducts(List<Product> products) async {
    final jsonString = jsonEncode(products.map((p) => p.toJson()).toList());
    await _storage.write(key: 'products_list', value: jsonString);
  }

  Future<List<Product>?> getUserProducts() async {
    final jsonString = await _storage.read(key: 'products_list');
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((item) => Product.fromJson(item)).toList();
    }
    return null;
  }

  Future<void> saveUserBeneficiary(List<BeneficiaryData> beneficiary) async {
    String jsonString = jsonEncode(beneficiary.map((b) => b.toJson()).toList());
    await _storage.write(key: 'beneficiary_list', value: jsonString);
  }

  Future<List<BeneficiaryData>?> getUserBeneficiary() async {
    String? jsonString = await _storage.read(key: 'beneficiary_list');

    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      // List beneficiary = jsonList.map((item) => item).toList();
      return jsonList.map((item) => BeneficiaryData.fromJson(item)).toList();
    }
    return null;
  }

  Future<void> saveUserTransactionHistory(List transactionHistory) async {
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
