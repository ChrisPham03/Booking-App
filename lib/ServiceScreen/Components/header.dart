import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../Providers/service_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Header extends StatefulWidget {
  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    final spaName = Provider.of<SpaNameProvider>(context).spaName;
    final spaAddress = Provider.of<SpaAddressProvider>(context).spaAddress;

    return Container(
      width: double.infinity, // Set width to fill the screen
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.9), // Semi-transparent white
            Colors.white.withOpacity(0.7), // More transparent for a softer effect
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        border: Border(
          bottom: BorderSide(
            color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.87), // Clear white color
            width: 1.5, // Thickness of the bottom border
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0), // Padding for the header
      child: Row( // Main header container
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribute space between children
        children: [
          // Left-aligned "BooKingApp" text
          Row(
            children: [
              Text(
                "FastBiz",
                style: TextStyle(
                  fontSize: 10.sp, // Adjust font size for "BooKingApp"
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 79, 226, 246), // Set text color to cyan blue
                  fontStyle: FontStyle.italic, // Set text style to italic
                ),
              ),
              SizedBox(width: 16.0), // Space between "BooKingApp" and the spa details container

              // Outer Container for the shadow effect
              Container(
                width: MediaQuery.of(context).size.width * 0.4, // Set width to 40% of the screen width
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.0), // Border radius for outer container
                  color: Colors.transparent, // Make it transparent
                  boxShadow: [ // Box shadow for the outer container
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3), // Shadow color
                      spreadRadius: 4, // Spread of the shadow
                      blurRadius: 10, // Blur effect of the shadow
                      offset: Offset(0, 4), // Position of the shadow below the container
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.0), // Border radius for circular effect
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // Background color for the circular box
                      border: Border.all( // Add border to the ClipRRect
                        color: Colors.white, // Border color
                        width: 1.5, // Border thickness
                      ),
                      borderRadius: BorderRadius.circular(100.0), // Ensure the border radius is consistent
                    ),
                    padding: EdgeInsets.all(15.0), // Optional padding inside the circular box
                    child: Column( // Use Column for stacking spa name and address
                      mainAxisSize: MainAxisSize.min, // Use min to avoid overflow
                      crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                      children: [
                        Text(
                          spaName,
                          style: TextStyle(
                            fontSize: 7.sp, // Adjust font size for header
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.left, // Align text to the left
                        ),
                        SizedBox(height: 0.1), // Space between name and address
                        Text(
                          spaAddress,
                          style: TextStyle(
                            fontSize: 5.sp, // Adjust font size for address
                            color: Colors.black54,
                          ),
                          textAlign: TextAlign.left, // Align text to the left
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Right-aligned Sign Out Text Link
          GestureDetector(
            onTap: () {
              // Handle sign out logic
              _showSignOutConfirmation(context);
            },
            child: Text(
              "Sign Out",
              style: TextStyle(
                color: Colors.red, // Color of the sign-out text
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSignOutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sign Out'),
          content: Text('Are you sure you want to sign out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Implement your sign-out logic here
                Navigator.pushNamed(context, '/');// Close the dialog
              },
              child: Text('Sign Out'),
            ),
          ],
        );
      },
    );
  }
}
