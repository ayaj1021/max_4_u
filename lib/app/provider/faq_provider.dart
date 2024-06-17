import 'package:flutter/material.dart';

class FaqProvider extends ChangeNotifier{

    int _activeFaqIndex = -1;

  int get activeFaqIndex => _activeFaqIndex;

  void setActiveFaqIndex(int index) {
    if (_activeFaqIndex == index) {
      _activeFaqIndex = -1;  // Collapse if the same FAQ is tapped again
    } else {
      _activeFaqIndex = index;
    }
    notifyListeners();
  }
}