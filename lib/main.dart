import 'package:flutter/material.dart';
import 'CheckInScreen/checkin_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'CheckInScreen/Components/user_provider.dart';
import 'CheckInScreen/Components/service_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PhoneNumberProvider()),
        ChangeNotifierProvider(create: (context) => SpaNameProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(390, 844), // iPhone 14 Plus reference
      child: MaterialApp(
        home: CheckInPage(), // Set the initial screen to CheckInPage
      ),
    );
  }
}
