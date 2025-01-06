# Customer Check In Interface

<div align="center">

A modern, Flutter-based customer check-in system for nail salons and spas.

![FastBiz Interface](images/phone-checkin.png)

</div>

## Overview
A Flutter-based customer check-in and service booking interface for Holidays Nails & Spa, designed to streamline the customer experience and service management.

![FastBiz Interface](images/project-screenshot.png)

## Features

### 📱 Customer Check-in Flow
- Phone number-based check-in system
- New customer registration with optional fields
- Points tracking system for customer loyalty
- Booking notes functionality
- Real-time check-in status updates

### 🎨 Modern UI/UX Elements
- Clean, intuitive interface design
- Interactive service selection cards
- Animated advertisements integration
- Dynamic service previews on hover
- Smooth transitions between screens

### 💅 Service Management
- Categorized service listings (Pedicure, Manicure, Waxing)
- Detailed service descriptions and pricing
- Duration estimates for each service
- Interactive technician selection
- Service preview images

### 👥 Staff Features
- Technician profiles with photos
- Work portfolio display
- Real-time availability status
- Booking management interface

### 💳 Pricing & Duration
- Transparent pricing display
- Service duration indicators
- Points earning system integration
- Easy service comparison

## 🛠 Technical Stack

### Core Technologies
```yaml
frontend:
  framework: Flutter 3.16.0
  language: Dart 3.2.0
  state_management: Riverpod
  
styling:
  ui_kit: Material Design 3
  custom: Custom Theme System
  
backend:
  database: Firebase Firestore
  authentication: Firebase Auth
  storage: Firebase Storage
  
development:
  version_control: Git
  ide: VS Code
  platform: iOS/Android/Web
```

### Key Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^2.24.0
  firebase_auth: ^4.15.0
  cloud_firestore: ^4.13.3
  riverpod: ^2.4.9
  flutter_riverpod: ^2.4.9
  go_router: ^12.1.1
  shared_preferences: ^2.2.2
  cached_network_image: ^3.3.0
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.16.0 or higher)
- Dart SDK (3.2.0 or higher)
- Firebase CLI
- VS Code or Android Studio
- Git

### Installation

1. Clone the repository:
```bash
git clone https://github.com/ChrisPham03/customer-check-in.git
cd customer-check-in
```

2. Install dependencies:
```bash
flutter pub get
```

3. Set up Firebase:
```bash
# Install Firebase CLI if not installed
npm install -g firebase-tools

# Login to Firebase
firebase login

# Initialize Firebase in your project
firebase init
```

4. Run the app:
```bash
# Development
flutter run

# Release mode
flutter run --release
```

### Device Simulation

#### iOS Simulator
```bash
# Open iOS Simulator (Mac only)
open -a Simulator

# Run on iOS Simulator
flutter run -d ios
```

#### Android Emulator
```bash
# List available emulators
flutter emulators

# Launch emulator
flutter emulators --launch <emulator_id>

# Run on Android emulator
flutter run -d android
```

#### Web
```bash
# Enable web support
flutter config --enable-web

# Run on web
flutter run -d chrome
```

### Custom Screen Sizes
For tablet optimization (as shown in screenshots):
```bash
# iOS Simulator
xcrun simctl create "iPad Pro" com.apple.CoreSimulator.SimDeviceType.iPad-Pro

# Android Emulator
flutter emulators --create [--name=tablet] --platform android
```

## 📱 Supported Devices
- Tablets (Primary focus)
  - iPad (9.7", 10.2", 10.5", 11", 12.9")
  - Android Tablets (10" and above)
- Mobile Phones (Responsive support)
  - iOS (iPhone X and above)
  - Android (API level 21 and above)
- Web Browsers
  - Chrome
  - Safari
  - Firefox
  - Edge

## Project Status
- ✅ UI/UX Implementation
- ✅ Core Check-in Functionality
- ✅ Service Selection System
- ✅ Points Integration
- ✅ Technician Selection
- ✅ Basic Animations

## Screenshots

| Check-in Screen | Service Selection | Settings |
|:-------------------------:|:-------------------------:|:-------------------------:|
| ![Check-in](images/phone-checkin.png) | ![Services](images/service-selection.png) | ![Settings](images/profile.png) |

## Development Timeline
- Project Duration: Oct 12, 2024 - Oct 21, 2024
- Initial Release: Oct 21, 2024

## Future Enhancements
- [ ] Online booking integration
- [ ] Payment processing
- [ ] Email notifications
- [ ] Customer feedback system
- [ ] Advanced analytics dashboard

## Contributors
- Designed and implemented by Chris Pham
- Part of the FastBiz service booking app ecosystem

## License
This project is proprietary software developed for Holidays Nails & Spa.
