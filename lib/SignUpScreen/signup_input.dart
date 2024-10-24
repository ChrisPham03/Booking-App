import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Providers/user_provider.dart'; // Adjust the import based on your project structure.
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserDetailsInputForm extends StatelessWidget {
  final Function() onSignUp;

  UserDetailsInputForm({required this.onSignUp});

  @override
  Widget build(BuildContext context) {
    // Access UserDetailsProvider from the context
    final userDetailsProvider = Provider.of<UserDetailsProvider>(context);

    return Center(
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
        width: 310.w,  // Adjust width as needed
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
                SizedBox(width: 200.0), // Space between the fields
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Birthday'),
                    onChanged: (value) {
                      userDetailsProvider.updateBirthday(value);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),

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
                SizedBox(width: 16.0), // Space between the fields
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
            SizedBox(height: 24.0),

            // Sign Up Button at the bottom
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  // Call the onSignUp function when the button is pressed
                  onSignUp();
                },
                child: Text('Sign Up'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
