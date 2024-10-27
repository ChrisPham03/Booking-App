import 'package:flutter/material.dart';
import 'service_provider.dart';


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
  int _point = 20 ;
  String _fullName = '';
  String _birthday = '';
  String _email = '';
  String _referredBy = '';  // Optional
  String _phoneNumber = '';

  int    get point => _point;
  String get phoneNumber => _phoneNumber;
  String get fullName => _fullName;
  String get birthday => _birthday;
  String get email => _email;
  String get referredBy => _referredBy;

  void updatePoint(int value) {
    _point = point;
    notifyListeners();
  }

  void updatePhoneNumber(String value) {
    _phoneNumber += value;
    notifyListeners();
  }

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
// BookingDetailsProvider to manage booking information


// class BookingDetailsProvider with ChangeNotifier {
//   // Hardcoded booking details
//   int _point = 20;
//   String _customerFullName = 'John Doe';
//   String _customerPhoneNumber = '1234567890';
//   String _bookingNote = 'Please ensure a relaxing atmosphere.';

//   Service? _selectedService;
//   Technician? _selectedTechnician;
//   String? _appointmentTime;
//   String? _checkInTime;

//   // Getters for customer information and booking note
//   int get point => _point;
//   String get customerFullName => _customerFullName;
//   String get customerPhoneNumber => _customerPhoneNumber;
//   String get bookingNote => _bookingNote;
//   Service? get selectedService => _selectedService;
//   Technician? get selectedTechnician => _selectedTechnician;
//   String? get appointmentTime => _appointmentTime;
//   String? get checkInTime => _checkInTime;

//   // Method to update points
//   void updatePoint(int value) {
//     _point = value;
//     notifyListeners();
//   }

//   // Methods to update customer information
//   void updateCustomerFullName(String value) {
//     _customerFullName = value;
//     notifyListeners();
//   }

//   void updateCustomerPhoneNumber(String value) {
//     _customerPhoneNumber = value;
//     notifyListeners();
//   }

//   void updateBookingNote(String value) {
//     _bookingNote = value;
//     notifyListeners();
//   }

//   // Method to set the selected service
//   void setSelectedService(Service service) {
//     _selectedService = service;
//     notifyListeners();
//   }

//   // Method to set the selected technician
//   void setSelectedTechnician(Technician technician) {
//     _selectedTechnician = technician;
//     notifyListeners();
//   }

//   // Method to set the appointment time
//   void setAppointmentTime(String time) {
//     _appointmentTime = time;
//     notifyListeners();
//   }

//   // Method to set the check-in time
//   void setCheckInTime(String time) {
//     _checkInTime = time;
//     notifyListeners();
//   }

//   // Method to clear booking details
//   void clearBookingDetails() {
//     _point = 0;
//     _customerFullName = '';
//     _customerPhoneNumber = '';
//     _bookingNote = '';
//     _selectedService = null;
//     _selectedTechnician = null;
//     _appointmentTime = null;
//     _checkInTime = null;
//     notifyListeners();
//   }
// }



class BookingDetailsProvider with ChangeNotifier {
  // Hardcoded booking details
  int _point = 20;
  String _customerFullName = 'Chris Phame';
  String _customerPhoneNumber = '1234567890';
  String _bookingNote = 'Please ensure a relaxing atmosphere.';

  Service? _selectedService;
  Technician? _selectedTechnician;
  String? _appointmentTime;
  String? _checkInTime;

  // Getters for customer information and booking note
  int get point => _point;
  String get customerFullName => _customerFullName;
  String get customerPhoneNumber => _customerPhoneNumber;
  String get bookingNote => _bookingNote;
  Service? get selectedService => _selectedService;
  Technician? get selectedTechnician => _selectedTechnician;
  String? get appointmentTime => _appointmentTime;
  String? get checkInTime => _checkInTime;

  // Method to update points
  void updatePoint(int value) {
    _point = value;
    notifyListeners();
  }

  // Methods to update customer information
  void updateCustomerFullName(String value) {
    _customerFullName = value;
    notifyListeners();
  }

  void updateCustomerPhoneNumber(String value) {
    _customerPhoneNumber = value;
    notifyListeners();
  }

  void updateBookingNote(String value) {
    _bookingNote = value;
    notifyListeners();
  }

  // Method to set the selected service
  void setSelectedService(Service service) {
    _selectedService = service;
    notifyListeners();
  }

  // Method to set the selected technician
  void setSelectedTechnician(Technician technician) {
    _selectedTechnician = technician;
    notifyListeners();
  }

  // Method to set the appointment time
  void setAppointmentTime(String time) {
    _appointmentTime = time;
    notifyListeners();
  }

  // Method to set the check-in time
  void setCheckInTime(String time) {
    _checkInTime = time;
    notifyListeners();
  }

  // Method to clear booking details
  void clearBookingDetails() {
    _point = 0;
    _customerFullName = '';
    _customerPhoneNumber = '';
    _bookingNote = '';
    _selectedService = null;
    _selectedTechnician = null;
    _appointmentTime = null;
    _checkInTime = null;
    notifyListeners();
  }
}

