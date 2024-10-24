import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Required for SystemChrome
import '../../Providers/service_provider.dart';
import '../../Providers/user_provider.dart'; // Import UserDetailsProvider
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'signup_input.dart'; // Import your UserDetailsInputForm

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  void initState() {
    super.initState();
    _setOrientationBasedOnSize(); // Set orientation based on device size
  }

  // Function to control the orientation based on screen width
  void _setOrientationBasedOnSize() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      double width = MediaQuery.of(context).size.width;

      // If the width is less than or equal to 430 logical pixels,
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
          return _buildLandScape(context); // Build the landscape mode UI
        }
      },
    );
  }

  Widget _buildPortrait(double width) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: UserDetailsInputForm(
            onSignUp: () => _onSignUp(), // Call the sign-up function
          ),
        ),
      ),
    );
  }

  Widget _buildLandScape(BuildContext context) {
    final spaName = Provider.of<SpaNameProvider>(context).spaName;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Title centered at the top
              Padding(
                padding: EdgeInsets.only(top: 20.h), // Optional padding from the top
                child: Center(
                  child: Text(
                    'Welcome to $spaName',
                    style: TextStyle(
                      fontSize: 28.sp, // Responsive text size
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              // User Details Input Form
              Expanded(
                child: UserDetailsInputForm(
                  onSignUp: _onSignUp, // Call the sign-up function
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSignUp() {
    final userDetailsProvider = Provider.of<UserDetailsProvider>(context, listen: false);
    
    // Retrieve user details
    String fullName = userDetailsProvider.fullName;
    String birthday = userDetailsProvider.birthday;
    String email = userDetailsProvider.email;
    String preferredName = userDetailsProvider.referredBy; // Using referredBy field for Preferred Name

    // Check if all fields are filled
    if (fullName.isEmpty || birthday.isEmpty || email.isEmpty) {
      // Show a message if any field is empty
      print("Please fill all fields before signing up.");
      // Optionally, show a snackbar or dialog for user feedback
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields before signing up.')),
      );
    } else {
      // Temporary sign-up logic
      print("Sign Up Successful!");
      print("Full Name: $fullName");
      print("Birthday: $birthday");
      print("Email: $email");
      print("Preferred Name: $preferredName");
      
      // Navigate to another page, e.g., Home or Dashboard
      Navigator.pushNamed(context, '/home'); // Adjust the route as needed
    }
  }
}
