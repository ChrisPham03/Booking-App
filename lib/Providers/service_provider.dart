import 'package:flutter/material.dart';

// Spa Name Provider
class SpaNameProvider with ChangeNotifier {
  String _spaName = 'Holidays Nails & Spa';

  String get spaName => _spaName;

  void updateSpaName(String newName) {
    _spaName = newName;
    notifyListeners();
  }
}

// Spa Address Provider
class SpaAddressProvider with ChangeNotifier {
  final String _spaAddress = "5949 Jeanne D'Arc Blvd South, Orleans, ON K1C 2N1";

  String get spaAddress => _spaAddress;
}


// Service Class
class Service {
  final String name;
  final double price;
  final int duration; // Duration in minutes
  final String description; // Service description

  Service({
    required this.name,
    required this.price,
    required this.duration,
    required this.description,
  });
}

// Service Category Class
class ServiceCategory {
  final String categoryName;
  final List<Service> services;

  ServiceCategory({required this.categoryName, required this.services});
}

// Service Provider with Hardcoded Services
class ServiceProvider with ChangeNotifier {
  List<ServiceCategory> _categories = [
    ServiceCategory(
      categoryName: "Pedicure",
      services: [
        Service(
          name: "Basic Pedicure",
          price: 25.0,
          duration: 30,
          description: "A simple nail trim, filing, and polish.",
        ),
        Service(
          name: "Luxury Pedicure",
          price: 50.0,
          duration: 60,
          description: "Indulge in our Luxury Pedicure, featuring a relaxing soak and expert nail care. Enjoy a rejuvenating foot and calf massage with premium products that nourish your skin. This treatment concludes with a flawless gel polish application, leaving your feet beautifully pampered and polished.",
        ),
        Service(
          name: "Gel Pedicure",
          price: 45.0,
          duration: 45,
          description: "Long-lasting gel polish application with nail care.",
        ),
      ],
    ),
    ServiceCategory(
      categoryName: "Manicure",
      services: [
        Service(
          name: "Basic Manicure",
          price: 20.0,
          duration: 30,
          description: "Nail trimming, filing, and regular polish.",
        ),
        Service(
          name: "Gel Manicure",
          price: 40.0,
          duration: 60,
          description: "Gel polish application for a long-lasting finish.",
        ),
        Service(
          name: "French Manicure",
          price: 35.0,
          duration: 50,
          description: "Classic look with white tips on polished nails.",
        ),
      ],
    ),
    ServiceCategory(
      categoryName: "Waxing",
      services: [
        Service(
          name: "Eyebrow Waxing",
          price: 15.0,
          duration: 15,
          description: "Shaping of eyebrows using wax for a clean look.",
        ),
        Service(
          name: "Leg Waxing",
          price: 40.0,
          duration: 30,
          description: "Removal of hair from the legs for smooth skin.",
        ),
      ],
    ),
  ];

  List<ServiceCategory> get categories => _categories;
}

class ServiceSelectionProvider with ChangeNotifier {
  final Map<Service, bool> _serviceSelection = {};

  Map<Service, bool> get serviceSelection => _serviceSelection;

  List<Service> get selectedServices =>
      _serviceSelection.entries
          .where((entry) => entry.value)
          .map((entry) => entry.key)
          .toList();

  void toggleServiceSelection(Service service) {
    final currentSelection = _serviceSelection[service] ?? false;
    _serviceSelection[service] = !currentSelection;
    notifyListeners();
  }

  void clearSelections() {
    _serviceSelection.forEach((key, value) {
      _serviceSelection[key] = false;
    });
    notifyListeners();
  }
}

class Technician {
  final String id;
  final String name;
  final String imageUrl;

  Technician({required this.id, required this.name, required this.imageUrl});
}


class TechnicianProvider with ChangeNotifier {
  // Hardcoded list of technicians with image URLs
  final List<Technician> _technicians = [
    Technician(
      id: "T1",
      name: "Alex Pham Skibidi dabidu",
      imageUrl: "assets/images/alex.jpg",
    ),
    Technician(
      id: "T2",
      name: "Natalie",
      imageUrl: "assets/images/natalie.jpg",
    ),
    Technician(
      id: "T3",
      name: "Kevin Pham",
      imageUrl: "assets/images/kevin.jpg",
    ),
    Technician(
      id: "T4",
      name: "Tim Pham ",
      imageUrl: "assets/images/tim.jpg",
    ),
    Technician(
      id: "T5",
      name: "Chris Pham",
      imageUrl: "assets/images/chris.jpg",
    ),
  ];

  // Map to track technician selection status
  final Map<Technician, bool> _technicianSelection = {};

  TechnicianProvider() {
    // Initialize _technicianSelection with the hardcoded technicians set to false
    for (var technician in _technicians) {
      _technicianSelection[technician] = false;
    }
  }

  // Getter for technician selection map
  Map<Technician, bool> get technicianSelection => _technicianSelection;

  // Getter to retrieve only selected technicians
  List<Technician> get selectedTechnicians =>
      _technicianSelection.entries
          .where((entry) => entry.value)
          .map((entry) => entry.key)
          .toList();

  // Toggle selection status for a technician
  void toggleTechnicianSelection(Technician technician) {
    final currentSelection = _technicianSelection[technician] ?? false;
    _technicianSelection[technician] = !currentSelection;
    notifyListeners();
  }

  // Clear all selections
  void clearSelections() {
    _technicianSelection.updateAll((key, value) => false);
    notifyListeners();
  }

  // Getter for the hardcoded technician list
  List<Technician> get technicians => _technicians;
}