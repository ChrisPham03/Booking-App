import 'package:flutter/material.dart';

class SpaNameProvider with ChangeNotifier {
  String _spaName = 'Holidays Nails & Spa';

  String get spaName => _spaName;

  void updateSpaName(String newName) {
    _spaName = newName;
    notifyListeners(); // Notify listeners of the change
  }
}

class SpaAddressProvider with ChangeNotifier {
  final String _spaAddress = "5949 Jeanne D'Arc Blvd South, Orleans, ON K1C 2N1";

  String get spaAddress => _spaAddress;
}
