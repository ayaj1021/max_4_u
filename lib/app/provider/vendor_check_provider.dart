import 'package:flutter/material.dart';
import 'package:max_4_u/app/database/database.dart';

class VendorCheckProvider extends ChangeNotifier {
  String level = '';

  getUserLevel(BuildContext context) async {
   final userLevel = await SecureStorage().getUserType();
   // final userLevel = Provider.of<AuthProviderImpl>(context).resDataData;
    level = userLevel;
    notifyListeners();
    return userLevel;
  }

  var _isVendor = '5';
 
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
