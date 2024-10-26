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



class UserDetailsProvider with ChangeNotifier {
  String _fullName = '';
  String _birthday = '';
  String _email = '';
  String _referredBy = '';  // Optional

  String get fullName => _fullName;
  String get birthday => _birthday;
  String get email => _email;
  String get referredBy => _referredBy;

  void updateFullName(String value) {
    _fullName = value;
    notifyListeners();
  }

  void updateBirthday(String value) {
    _birthday = value;
    notifyListeners();
  }

  void updateEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void updateReferredBy(String value) {
    _referredBy = value;
    notifyListeners();
  }
}


// Provider Class to manage service selection state


