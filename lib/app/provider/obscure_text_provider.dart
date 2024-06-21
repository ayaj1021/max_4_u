import 'package:flutter/material.dart';

class ObscureTextProvider extends ChangeNotifier {
  bool _isObscure = true;
  bool get isObscure => _isObscure;

  changeObscure() {
    _isObscure = !_isObscure;
    notifyListeners();
  }
}


class AutoRenewalCheck extends ChangeNotifier{
 bool _isAutoRenew = false;
  bool get isAutoRenew => _isAutoRenew;

   changeRenewal() {
    _isAutoRenew = !_isAutoRenew;
    notifyListeners();
  }

}