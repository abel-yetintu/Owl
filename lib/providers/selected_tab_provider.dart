import 'package:flutter/material.dart';

class SelectedTabProvider extends ChangeNotifier {
  int _selectedTab = 0;
  int get selectedTab => _selectedTab;

  void selectTab({required int tab}) {
    _selectedTab = tab;
    notifyListeners();
  }
}
