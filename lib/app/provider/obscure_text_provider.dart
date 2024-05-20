import 'package:flutter/material.dart';

class ObscureTextProvider extends ChangeNotifier {
  bool _isObscure = false;
  bool get isObscure => _isObscure;

  changeObscure() {
    _isObscure = !_isObscure;
    notifyListeners();
  }
}
