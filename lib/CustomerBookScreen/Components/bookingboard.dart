import 'package:flutter/material.dart';
import 'package:booking_app/Providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingBoard extends StatefulWidget {
  @override
  _BookingBoardState createState() => _BookingBoardState();
}

class _BookingBoardState extends State<BookingBoard> {
  @override
  Widget build(BuildContext context) {
    final customerBook = Provider.of<BookingDetailsProvider>(context);
    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Booking Details",
              style: TextStyle(
                fontSize: 8.sp,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.0),
            // Container below Booking Note
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: const EdgeInsets.symmetric(vertical: 16.0), // Padding inside the container
              margin: EdgeInsets.only(top: 8.0), // Margin above the container
              decoration: BoxDecoration(
                color: Colors.blue[50], // Background color
                borderRadius: BorderRadius.circular(8.0), // Rounded corners
                border: Border.all(color: Colors.blueAccent), // Border color
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Technician Row with padding
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Technician:',
                          style: TextStyle(color: const Color.fromARGB(255, 55, 81, 109),fontSize: 6.sp),
                        ),
                        Text(
                          customerBook.selectedTechnician?.name ?? 'N/A',
                          style: TextStyle(color:Colors.black, fontSize: 6.sp),
                        ),
                         Text(
                          'Appointed Time:',
                          style: TextStyle( color: const Color.fromARGB(255, 55, 81, 109),fontSize: 6.sp),
                        ),
                        Text(
                          customerBook.appointmentTime ?? 'N/A',
                          style: TextStyle(color: Colors.black, fontSize: 6.sp),
                        ),
                         Text(
                          'Checked In Time:',
                          style: TextStyle( color:  const Color.fromARGB(255, 55, 81, 109),fontSize: 6.sp),
                        ),
                        Text(
                          customerBook.checkInTime ?? 'N/A',
                          style: TextStyle(color: Colors.black, fontSize: 6.sp),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Divider(color: Colors.grey, thickness: 0.5),
                  SizedBox(height: 5.0),

                  // Title Row for Service Details with padding
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'SERVICE',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange,fontSize: 6.sp),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'DURATION',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange,fontSize: 6.sp),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'PRICE',
                            style: TextStyle(fontWeight: FontWeight.bold, color:  Colors.deepOrange,fontSize: 6.sp),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Divider(color: Colors.grey, thickness: 0.5),

                  // Service Details Row with padding
                 Container(
                    padding: const EdgeInsets.all(8.0), // Padding inside the box
                    margin: const EdgeInsets.symmetric(vertical: 15.0), // Space above and below the box
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              customerBook.selectedService?.name ?? 'N/A',
                              style: TextStyle(color: Colors.black, fontSize: 5.5.sp,fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              '${customerBook.selectedService?.duration ?? 'N/A'} min',
                              style: TextStyle(color:Colors.black, fontSize: 5.5.sp,fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              '\$${customerBook.selectedService?.price ?? 'N/A'}',
                              style: TextStyle(color:Colors.black, fontSize: 5.5.sp,fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Divider(color: Colors.grey, thickness: 0.5),
                    Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Estimate',
                            style: TextStyle(color: const Color.fromARGB(255, 55, 81, 109), fontSize: 6.sp),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '${customerBook.selectedService?.duration ?? 'N/A'} min',
                            style: TextStyle(color: Colors.black,  fontSize: 5.sp,fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '\$${customerBook.selectedService?.price ?? 'N/A'} (Will earn ${customerBook.selectedService?.point ?? 'N/A'}) points',
                            style: TextStyle(color: Colors.black,  fontSize: 5.sp,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
