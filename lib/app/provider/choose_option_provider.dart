import 'package:flutter/material.dart';

class ChooseOptionsProvider extends ChangeNotifier {
  int? _categoryIndex;

  int get categoryIndex => _categoryIndex!;
  changeCategoryIndex(int index) {
    _categoryIndex = index;
  }
}
