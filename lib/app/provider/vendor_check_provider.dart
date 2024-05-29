import 'package:flutter/material.dart';
import 'package:max_4_u/app/database/database.dart';

class VendorCheckProvider extends ChangeNotifier {
  String _isVendor = level;
  //getUserLevel();
  String get isVendor => _isVendor;

  void changeVendor(String userType) async {
    _isVendor = userType;
    changeUserLevel(userType);
    notifyListeners();
  }
}

String level = '';
getUserLevel() async {
  return level =   await SecureStorage().getUserType();
}

changeUserLevel(String level) async {
  await SecureStorage().saveUserType(level);
}
