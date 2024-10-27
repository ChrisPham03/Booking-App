import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenFrameWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.43, // Set frame width
      height: MediaQuery.of(context).size.height * 0.43, // Set frame height
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/ipad.png'), // Background image
          fit: BoxFit.contain, // Fit the image to contain within the container
        ),
      ),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20), // Adjust radius for rounded corners
          child: Container(
            width: MediaQuery.of(context).size.width * 0.40, // Width to fit inside the frame's screen area
            height: MediaQuery.of(context).size.height * 0.40, // Height to fit inside the frame's screen area
            child: Image.asset(
              'assets/images/halloweennails.jpeg', // Inner image
              fit: BoxFit.cover, // Ensure the image fills the rounded rectangle
            ),
          ),
        ),
      ),
    );
  }
}
