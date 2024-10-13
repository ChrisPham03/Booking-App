import 'package:flutter/material.dart';

class PhoneNumberProvider with ChangeNotifier {
  String _phoneNumber = '';

  String get phoneNumber => _phoneNumber;

  void updatePhoneNumber(String value) {
    _phoneNumber += value;
    notifyListeners();
  }

  void deleteLastDigit() {
    if (_phoneNumber.isNotEmpty) {
      _phoneNumber = _phoneNumber.substring(0, _phoneNumber.length - 1);
      notifyListeners();
    }
  }
}