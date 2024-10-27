import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:booking_app/ServiceScreen/Components/header.dart';
import 'Components/bookingboard.dart';
import 'Components/noteAndpoint.dart'; // Ensure this imports your PointAndNoteBoard
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomerBookPage extends StatefulWidget {
  @override
  _CustomerBookPageState createState() => _CustomerBookPageState();
}

class _CustomerBookPageState extends State<CustomerBookPage> {
  final ValueNotifier<int> stepNotifier = ValueNotifier(0); // Step notifier
  bool _hasShownDialog = false; // State variable to track dialog visibility

  @override
  void initState() {
    super.initState();
    _setOrientationBasedOnSize();
  }

  void _setOrientationBasedOnSize() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      double width = MediaQuery.of(context).size.width;

      if (width <= 430) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
      } else {
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    stepNotifier.dispose(); // Dispose notifier
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    // Check if there are arguments passed during navigation
    final args = ModalRoute.of(context)?.settings.arguments;
    bool showDialogOnLoad = args is bool ? args : false; // Default to false

    // Show dialog if the argument is true and dialog hasn't been shown yet
    if (showDialogOnLoad && !_hasShownDialog) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showCheckInSuccessDialog();
        _hasShownDialog = true; // Set the flag to true after showing the dialog
      });
    }

    if (width <= 430) {
      return _buildPortrait();
    }

    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return _buildPortrait();
        } else {
          return _buildLandScape();
        }
      },
    );
  }

  Widget _buildPortrait() {
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
              Header(),
              Expanded(
                child: Column(
                  children: [
                    PointAndNoteBoard(), // Add PointAndNoteBoard below BookingBoard
                    BookingBoard(), // Display BookingBoard in portrait mode
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLandScape() {
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
              Header(),
              Expanded(
                child: Column(
                  children: [
                    PointAndNoteBoard(), // Add PointAndNoteBoard below BookingBoard
                    BookingBoard(), // Display BookingBoard in landscape mode
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

void _showCheckInSuccessDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog( // Use Dialog instead of AlertDialog for more customization
        backgroundColor: Colors.white,
        child: Container(
          width: MediaQuery.of(context).size.width / 2, // Set width to 1/3 of the screen
          padding: EdgeInsets.all(20), // Add some padding
          child: Column(
            mainAxisSize: MainAxisSize.min, // Makes the dialog size to fit the content
            children: [
              Text(
                'You have successfully checked in!',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.sp)
              ),
              SizedBox(height: 20), // Space between text and check mark
              Icon(
                Icons.check_circle, // You can use any checkmark icon
                color: Colors.green,
                size: 40.sp, // Adjust the size as needed
              ),
              SizedBox(height: 20), // Space between check mark and button
              Center( // Center the button
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    setState(() {
                      _hasShownDialog = false; // Reset the dialog state if you want to show it again later
                    });
                  },
                  child: Text(
                    'Done',
                    style: TextStyle(color: Colors.deepOrange, fontSize: 7.sp), // Change button text color
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  ).then((_) {
    // Reset the dialog shown flag after the dialog is closed
    _hasShownDialog = true;
  });
}
}
