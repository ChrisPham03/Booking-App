import 'package:flutter/material.dart';
import 'CheckInScreen/checkin_screen.dart';
import 'SignUpScreen/signUp_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'Providers/user_provider.dart';
import 'Providers/service_provider.dart';
import 'ServiceScreen/servicescreen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SpaAddressProvider()),
        ChangeNotifierProvider(create: (context) => PhoneNumberProvider()),
        ChangeNotifierProvider(create: (context) => SpaNameProvider()),
        ChangeNotifierProvider(create: (context) => UserDetailsProvider()),
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
        initialRoute: '/', // Set the in aitial route
        routes: {
          '/': (context) => ServicePage(), // Main route for CheckInPage
          '/signup': (context) => SignUpPage(), // Route for SignUpPage
        },
        // Optionally, you can specify a theme or other properties here
      ),
    );
  }
}
