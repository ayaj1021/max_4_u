import 'package:flutter/material.dart';

class VendorCheckProvider extends ChangeNotifier {
  bool _isVendor = false;
  bool get isVendor => _isVendor;

  void changeVendor() {
    _isVendor = !_isVendor;
    notifyListeners();
  }
}
