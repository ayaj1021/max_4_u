import 'package:flutter/material.dart';
import 'package:max_4_u/app/database/database.dart';

class VendorCheckProvider extends ChangeNotifier {
    String level = '';

  getUserLevel() async {
    final userLevel = await SecureStorage().getUserType();
    level = userLevel;
    notifyListeners();
    return userLevel;
  }
  var _isVendor = '4';
  //getUserLevel();
  String get isVendor => _isVendor;

  void changeVendor(String userType) async {
    _isVendor = userType;
    changeUserLevel(userType);
    notifyListeners();
  }


  changeUserLevel(String level) async {
    await SecureStorage().saveUserType(level);
  }
}
