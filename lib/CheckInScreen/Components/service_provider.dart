import 'package:flutter/material.dart';

class SpaNameProvider with ChangeNotifier {
  String _spaName = 'Holidays Nails';

  String get spaName => _spaName;

  void updateSpaName(String newName) {
    _spaName = newName;
    notifyListeners(); // Notify listeners of the change
  }
}
