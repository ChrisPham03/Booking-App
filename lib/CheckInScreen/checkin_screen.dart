import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Required for SystemChrome
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'Components/user_provider.dart';
import 'Components/userInput.dart';
import 'Components/serviceContent.dart';

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
      return _buildPortrait(); // Directly show the portrait UI for smaller devices
    }

    // For larger devices, handle both orientations using OrientationBuilder
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return _buildPortrait(); // Build the portrait mode UI
        } else {
          return _buildLandScape(); // Build the landscape mode UI
        }
      },
    );
  }

  Widget _buildPortrait() {
    print("Portrait mode");
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/loginbackground.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: WelcomeContainer(), // Use the new WelcomeContainer
                ),
                Expanded(
                  flex: 1,
                  child: _buildPhoneNumberField(),
                ),
                Expanded(
                  flex: 7,
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
          image: AssetImage('assets/images/loginbackground.jpg'),
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
                  children: <Widget>[ 
                    Container (
                      height: MediaQuery.of(context).size.height * 0.25, // 1/4 of screen height
                      child: Padding(
                        padding: EdgeInsets.only(right: 20.w), // Right-side padding
                        child: WelcomeContainer(),
                      ),
                    ),
                  ],
                ),
              ),
      

              // Row for PhoneNumberField and NumericKeypad
              Expanded(
                flex: 4,  // Adjust flex as needed for the phone number and keypad height
                child: Column(
                  children: <Widget>[
                    
                    SizedBox(height: 150.h),
                    // Phone number field takes 3/10 space
                    Expanded(
                      flex: 3,
                      child: _buildPhoneNumberField(),
                    ),
                    SizedBox(width: 10.w),  // Space between phone number field and numeric keypad
                    
                    // Numeric keypad takes 7/10 space
                    Expanded(
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
          style: TextStyle(fontSize: isLandscape ? 20.sp : 30.sp, color: Colors.white),
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: 'Please enter your phone number',
            hintStyle: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: isLandscape ? 9.sp : 19.sp,
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

  void _onCheckMark() {
    final phoneNumber = Provider.of<PhoneNumberProvider>(context, listen: false).phoneNumber;
    print("Phone number: $phoneNumber");
    // Implement your check-in logic here
  }
}
