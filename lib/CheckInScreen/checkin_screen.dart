import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
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

  @override
  Widget build(BuildContext context) {
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

  Widget _buildPhoneNumberField() {
    final phoneNumber = Provider.of<PhoneNumberProvider>(context).phoneNumber;

    return Padding(
      padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
      child: Container(
        width: 0.8.sw,
        alignment: Alignment.center,
        child: TextField(
          controller: TextEditingController(text: phoneNumber),
          readOnly: true,
          style: TextStyle(fontSize: 30.sp, color: Colors.white),
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: 'Please enter your phone number',
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 19.sp),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
