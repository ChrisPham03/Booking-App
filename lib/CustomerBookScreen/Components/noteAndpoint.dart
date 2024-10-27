import 'package:booking_app/CheckInScreen/Components/serviceContent.dart';
import 'package:flutter/material.dart';
import 'package:booking_app/Providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';



class PointAndNoteBoard extends StatefulWidget {
  @override
  _PointAndNoteState createState() => _PointAndNoteState();
}

class _PointAndNoteState extends State<PointAndNoteBoard> {
  @override
  Widget build(BuildContext context) {
    final customerBook = Provider.of<BookingDetailsProvider>(context);
    customerBook.updateCustomerFullName(Provider.of<UserDetailsProvider>(context).fullName);
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Element 2
        Container(
          alignment: Alignment.topLeft,
          child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.black, // Default text color
                    fontSize: 18, // Set your desired font size
                  ),
                  children: [
                    TextSpan(
                      text: 'Welcome ',
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 9.sp), // Regular text
                    ),
                    TextSpan(
                      text: '${customerBook.customerFullName} ', // Customer's name
                      style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold,fontSize: 9.sp), // Highlighted in red
                    ),
                    TextSpan(
                      text: '!', // Customer's name
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 9.sp), // Highlighted in red
                    ),
                    TextSpan(
                      text: '\nYou are successfully checked in ',
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 9.sp), // Regular text
                    ),
                  ],
                ),
                textAlign: TextAlign.start,
              ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Element 1
             Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                   child: Row (
                children: [
                  Container(
                    width: 60.w,
                     padding: EdgeInsets.all(9.0), // Add padding around the text // Padding inside the container
                    decoration: BoxDecoration(
                      color: Colors.deepOrange, // Background color
                      borderRadius: BorderRadius.circular(8.0), // Rounded corners
                      border: Border.all(color: Colors.blueAccent), // Border color
                    ), 
                    child: Text('Your Current Point:',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 5.sp,color: Colors.white)),
                  ),
                  SizedBox(width:10.w),
                  Icon(
                      Icons.card_giftcard_outlined, // Gift box icon
                      color: Colors.deepOrange,           // Set the color to orange
                      size: 12.w,                    // Adjust the size as needed
                    ),
                  SizedBox(width:3.w),
                  Container(  
                  child: Text('${customerBook.point ?? 'N/A'} points',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 6.sp,color: Colors.deepOrange)),
                  ), 
                ],
            ),
            ),
            SizedBox(height:20),
            // Element 3
             Text('Booking note',
             textAlign: TextAlign.start,
             style: TextStyle(fontSize: 7.sp,color: Colors.white)
             ),
             // Element 4
              Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: 100.0, // Set a specific height
              padding: EdgeInsets.all(16.0), // Add padding around the text // Padding inside the container
              margin: EdgeInsets.only(top: 8.0), // Margin above the container
              decoration: BoxDecoration(
                color: Colors.blue[50], // Background color
                borderRadius: BorderRadius.circular(8.0), // Rounded corners
                border: Border.all(color: Colors.blueAccent), // Border color
              ),
                child: Text('${customerBook.bookingNote ?? 'N/A'}',textAlign: TextAlign.start,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis, // Optional: handle overflow 
                        style: TextStyle(fontSize: 5.sp,color: Colors.black),
                        ),
              ),
            
          ],
        ),
      ],
    );
  }
}
