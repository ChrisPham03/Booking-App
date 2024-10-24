import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; // Import for date formatting
import '../../Providers/user_provider.dart'; // Adjust the import based on your project structure.
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserDetailsInputForm extends StatefulWidget {
  final Function() onSignUp;

  UserDetailsInputForm({required this.onSignUp});

  @override
  _UserDetailsInputFormState createState() => _UserDetailsInputFormState();
}

class _UserDetailsInputFormState extends State<UserDetailsInputForm> {
  bool _isKeyboardVisible = false;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    // Initialize the keyboard visibility listener for further customize
    KeyboardVisibilityController().onChange.listen((bool isVisible) {
      setState(() {
        _isKeyboardVisible = isVisible;
      });
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Default to today
      firstDate: DateTime(1900), // Earliest date to choose
      lastDate: DateTime.now(), // Latest date to choose
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: const Color.fromARGB(255, 55, 81, 109), // Change primary color to 37516D
              onPrimary: Colors.white, // Text color of the selected date
              onSurface: Colors.black, // Default color of the dates
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      // Format the selected date to include the full date (MM/dd/yyyy)
      String formattedDate = DateFormat('MM/dd/yyyy').format(picked);
      Provider.of<UserDetailsProvider>(context, listen: false).updateBirthday(formattedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Access UserDetailsProvider from the context
    final userDetailsProvider = Provider.of<UserDetailsProvider>(context);

    return SingleChildScrollView(
      child: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          width: 310.w, // Adjust width as needed for responsiveness
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row with Full Name and Birthday
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Full Name'),
                      onChanged: (value) {
                        userDetailsProvider.updateFullName(value);
                      },
                    ),
                  ),
                  SizedBox(width: 16.w), // Adjust space dynamically using screen width
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Birthday',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () => _selectDate(context), // Show date picker on icon tap
                        ),
                      ),
                      readOnly: true, // Prevent keyboard from showing
                      controller: TextEditingController(
                        text: _selectedDate != null
                            ? DateFormat('MM/dd/yyyy').format(_selectedDate!)
                            : '',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h), // Adjust height dynamically

              // Row with Email and Preferred Name
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Email'),
                      onChanged: (value) {
                        userDetailsProvider.updateEmail(value);
                      },
                    ),
                  ),
                  SizedBox(width: 16.w), // Adjust space dynamically using screen width
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Preferred Name'),
                      onChanged: (value) {
                        userDetailsProvider.updateReferredBy(value); // Using referredBy field for Preferred Name
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h), // Adjust height dynamically

                  // Sign Up Button at the bottom
              // Sign Up Button at the bottom
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    // Call the onSignUp function when the button is pressed
                    widget.onSignUp();
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white), // Change text color to white for better contrast
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 55, 81, 109), // Set button color to #37516D
                    padding: EdgeInsets.symmetric(horizontal: 32.0.w, vertical: 12.0.h),
                  ).copyWith(
                    // Customize the splash and highlight colors
                    overlayColor: WidgetStateProperty.all(const Color.fromARGB(255, 255, 255, 255).withOpacity(0.2)), // Change overlay color
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
