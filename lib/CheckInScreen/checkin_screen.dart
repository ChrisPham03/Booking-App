
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckInPage extends StatefulWidget {
  @override
  _CheckInPageState createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  String _phoneNumber = '';

  void _onKeyPress(String value) {
    setState(() {
      _phoneNumber += value;
    });
  }

  void _onDelete() {
    if (_phoneNumber.isNotEmpty) {
      setState(() {
        _phoneNumber = _phoneNumber.substring(0, _phoneNumber.length - 1);
      });
    }
  }

  void _onCheckMark() {
    print("Phone number: $_phoneNumber");
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
                  child: _buildWelcomeContainer(),
                ),
                Expanded(
                  flex: 1,
                  child: _buildPhoneNumberField(),
                ),
                Expanded(
                  flex: 7,
                  child: _buildNumericKeypad(),
                ),
              ],
            ),
          ),
          ),
        ),
    );
  }
  Widget _buildPhoneNumberField() {
    return Padding(
    padding: EdgeInsets.only(top: 10.h , bottom: 10.h), // Add bottom padding here
    child: Container(
      width: 0.8.sw,
      alignment: Alignment.center,
      child: TextField(
        controller: TextEditingController(text: _phoneNumber),
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

  Widget _buildNumericKeypad() {
    return Container(
    child:GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 1.5,
      mainAxisSpacing: 10.h,
      crossAxisSpacing:10.w,
      physics: NeverScrollableScrollPhysics(),
      children: List.generate(12, (index) {
        if (index < 9) {
          return _buildButton((index + 1).toString());
        } else if (index == 9) {
          return _buildButton('', icon: Icons.backspace, onPressed: _onDelete);
        } else if (index == 10) {
          return _buildButton('0');
        } else if (index == 11) {
          return Visibility(
            visible: _phoneNumber.length >= 10,
            child: _buildButton('', icon: Icons.check, onPressed: _onCheckMark),
          );
        }
        return Container();
      }),
    ),
    );
  }

  Widget _buildButton(String text, {IconData? icon, VoidCallback? onPressed}) {
  return Container(
    child: OutlinedButton(
      onPressed: onPressed ?? () => _onKeyPress(text),
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.3),
        side: BorderSide(color: Colors.white, width: 1.w),
      // shape: CircleBorder(), // Ensures the button has a circular shape
      ),
      child: icon != null
          ? Icon(icon, size: 26.sp, color: Colors.white)
          : Text(
              text,
              style: TextStyle(fontSize: 26.sp, color: Colors.white),
            ),
    ),
  );
}

Widget _buildWelcomeContainer() {
    return Container(
      width: 0.8.sw,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white,
          width: 1.5.w,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.2),
            offset: Offset(0, 0.005.sh),
            blurRadius: 0.005.sh,
            spreadRadius: 0.005.sh,
          ),
          BoxShadow(
            color: Colors.pink.withOpacity(0.15),
            offset: Offset(0.005.sw, 0.003.sh),
            blurRadius: 0.01.sh,
            spreadRadius: 0.01.sh,
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0.001.sh,
            left: 0,
            right: 0,
            child: Center(
              child: AnimatedTextKit(
                repeatForever: false,
                totalRepeatCount: 1,
                animatedTexts: [
                  TyperAnimatedText(
                    'Welcome To',
                    speed: const Duration(milliseconds: 90),
                    textStyle: GoogleFonts.allison(
                      fontSize: 0.1.sh,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0.05.sh,
            left: 0,
            right: 0,
            child: Center(
              child: AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  FadeAnimatedText(
                    'Holidays Nails',
                    duration: const Duration(milliseconds: 3500),
                    textStyle: GoogleFonts.inriaSerif(
                      fontSize: 0.05.sh,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

