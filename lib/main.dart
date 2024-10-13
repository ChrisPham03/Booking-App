import 'package:flutter/material.dart';
import 'CheckInScreen/checkin_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size (390, 844), //Iphone 14 plus reference
      child: MaterialApp(
      home: CheckInPage(), // Set the initial screen to CheckInPage
      ), // Material App
    );
  }
}
