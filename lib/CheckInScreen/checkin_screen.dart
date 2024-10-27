import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Required for SystemChrome
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../Providers/user_provider.dart';
import 'Components/userInput.dart';
import 'Components/serviceContent.dart';
import 'Components/ipadscreen.dart';
import '../../Providers/service_provider.dart';
import 'package:intl/intl.dart'; 
import 'Components/sliding.dart';



class CheckInPage extends StatefulWidget {
  @override
  _CheckInPageState createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  @override
  void initState() {
    super.initState();
    _setOrientationBasedOnSize(); // Set orientation based on device size
  }

  // Function to control the orientation based on screen width
  void _setOrientationBasedOnSize() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      double width = MediaQuery.of(context).size.width;

      // If the width is less than or equal to 430 logical pixels (iPhone 14 Pro Max size),
      // lock the orientation to portrait mode
      if (width <= 430) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
      } else {
        // Allow both portrait and landscape orientations for larger devices
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
      }
    });
  }

  @override
  void dispose() {
    // Reset orientation preferences to allow all orientations when this widget is disposed
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    // If the width is less than or equal to 430, only show portrait mode
    if (width <= 430) {
      return _buildPortrait(width); // Directly show the portrait UI for smaller devices
    }

    // For larger devices, handle both orientations using OrientationBuilder
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return _buildPortrait(width); // Build the portrait mode UI
        } else {
          return _buildLandScape(); // Build the landscape mode UI
        }
      },
    );
  }

  Widget _buildPortrait(double width) {
    print("Portrait mode");
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
           padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Column(
              children: <Widget>[
                Expanded(
                  flex:width < 430 ? 2 : 3,
                  child: WelcomeContainer(), // Use the new WelcomeContainer
                ),
                Expanded(
                  flex: 1,
                  child: _buildPhoneNumberField(),
                ),
                Expanded(
                  flex: width < 430 ? 4 : 7,
                  child: NumericKeypad(
                    onKeyPress: _onKeyPress,
                    onDelete: _onDelete,
                    onCheckMark: _onCheckMark,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLandScape() {
  print("Landscape mode");
  return Scaffold(
    body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Row(
            children: <Widget>[
              // Welcome board at the top
         Expanded(
  flex: 6,  // Adjust flex as needed for the welcome board height
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Expanded( // Makes the WelcomeContainer take up 2/6 of the available height
        flex: 2, // Adjust this value as needed
        child: Padding(
          padding: EdgeInsets.only(right: 20.w), // Right-side padding
          child: WelcomeContainer(),
        ),
      ),
      Expanded( // Makes the ScreenFrameWidget take up 4/6 of the available height
        flex: 4, // Adjust this value as needed
        child: Padding( // Adding padding to the left of the ScreenFrameWidget
          padding: EdgeInsets.only(left: 10.w), // Left-side padding
          child: SlideWidget(),
        ),
      ),
    ],
  ),
),

              // Row for PhoneNumberField and NumericKeypad
              Expanded(
              flex: 4,  // Adjust flex as needed for the phone number and keypad height
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Align elements equally
                children: <Widget>[
                  // Center the "FastBiz" text using a flexible container
                  Flexible(
                    flex: 3, // Adjust the flex value as needed
                    child: Container(
                      child: Center(
                        child: Text(
                          'FastBiz',
                          style: TextStyle(
                                fontSize: 15.sp, // Adjust font size for "BooKingApp"
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 79, 226, 246), // Set text color to cyan blue
                                fontStyle: FontStyle.italic, // Set text style to italic
                          ),
                        ),
                      ),
                                  ),
                                ),

                    // Phone number field takes 3/10 space
                    Flexible(
                      flex: 2,
                      child: _buildPhoneNumberField(),
                    ),
                    
                    // Space between phone number field and numeric keypad
                    SizedBox(height: 10), // Use height for vertical spacing

                    // Numeric keypad takes 7/10 space
                    Flexible(
                      flex: 8,
                      child: NumericKeypad(
                        onKeyPress: _onKeyPress,
                        onDelete: _onDelete,
                        onCheckMark: _onCheckMark,
                      ),
                    ),
                  ],
                ),
              ),


            ],
          ),
        ),
      ),
    ),
  );
}


 Widget _buildPhoneNumberField() {
    final phoneNumber = Provider.of<PhoneNumberProvider>(context).phoneNumber;
    final orientation = MediaQuery.of(context).orientation;
    final isLandscape = orientation == Orientation.landscape;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: isLandscape ? 0 : 10.h,
        horizontal: isLandscape ? 1.w : 0,
      ),
      child: Container(
        width: isLandscape ? 0.6.sw : 0.8.sw,
        alignment: Alignment.center,
        child: TextField(
          controller: TextEditingController(text: phoneNumber),
          readOnly: true,
          style: TextStyle(fontSize: isLandscape ? 18.sp : 32.sp, color: Colors.white),
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: 'Please enter your phone number',
            hintStyle: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: isLandscape ? 8.sp : 19.sp,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  void _onKeyPress(String value) {
    Provider.of<PhoneNumberProvider>(context, listen: false).updatePhoneNumber(value);
  }

  void _onDelete() {
    Provider.of<PhoneNumberProvider>(context, listen: false).deleteLastDigit();
  }
void _onCheckMark(BuildContext context) {
  final phoneNumber = Provider.of<PhoneNumberProvider>(context, listen: false).phoneNumber;

  // Check if the phone number exists in the hardcoded list
  bool phoneNumberExists = _checkIfPhoneNumberExists(phoneNumber);

  if (phoneNumberExists) {
    print("Phone number exists. Navigating to CustomerBookPage with booking details.");
    
    final bookingDetailsProvider = Provider.of<BookingDetailsProvider>(context, listen: false);
    bookingDetailsProvider.updateCustomerFullName('Chris');
    bookingDetailsProvider.updateCustomerPhoneNumber(phoneNumber);
    bookingDetailsProvider.updateBookingNote('Please ensure a relaxing atmosphere.');
    bookingDetailsProvider.setAppointmentTime('2024-10-30 10:00 AM');

    final technicianProvider = Provider.of<TechnicianProvider>(context, listen: false);
    technicianProvider.clearSelections();
    final selectedTechnician = technicianProvider.technicians.firstWhere(
      (technician) => technician.name == "Natalie",
      orElse: () => technicianProvider.technicians.first,
    );
    technicianProvider.toggleTechnicianSelection(selectedTechnician);
    bookingDetailsProvider.setSelectedTechnician(selectedTechnician);

    final serviceProvider = Provider.of<ServiceProvider>(context, listen: false);
    final serviceSelectionProvider = Provider.of<ServiceSelectionProvider>(context, listen: false);
    serviceSelectionProvider.clearSelections();
    final selectedService = serviceProvider.categories
        .firstWhere((category) => category.categoryName == "Pedicure")
        .services
        .firstWhere((service) => service.name == "Luxury Pedicure");
    serviceSelectionProvider.toggleServiceSelection(selectedService);
    bookingDetailsProvider.setSelectedService(selectedService);

    final currentTime = DateFormat('HH:mm').format(DateTime.now());
    bookingDetailsProvider.setCheckInTime(currentTime);

    Navigator.pushReplacementNamed(
      context,
      '/checkin',
      arguments: true,
    );
  } else {
    print("Phone number does not exist. Navigating to sign-up page.");
    Navigator.pushNamed(context, '/signup');
  }
}

// Function to check if phone number exists in the hardcoded list
bool _checkIfPhoneNumberExists(String phoneNumber) {
  List<String> existingPhoneNumbers = [
    '9023149231',
    '5559876543',
    '5555555555',
    '5550001111',
    // Add more existing numbers as needed
  ];
  return existingPhoneNumbers.contains(phoneNumber);
}




}
