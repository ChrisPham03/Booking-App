import 'package:booking_app/Providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:booking_app/Providers/service_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class NavigateBar extends StatefulWidget {
  final ValueNotifier<int> stepNotifier; // Add a step notifier

  const NavigateBar({Key? key, required this.stepNotifier}) : super(key: key);

  @override
  _NavigateBarState createState() => _NavigateBarState();
}

class _NavigateBarState extends State<NavigateBar> {
  final List<String> stepMessages = [
    "Step 1/2 - Choose Service",
    "Step 2/2 - Choose Technician",
  ];



  @override
  Widget build(BuildContext context) {

    // Access the ServiceSelectionProvider here
    final selectionProvider = Provider.of<ServiceSelectionProvider>(context);
    final selectTechProvider = Provider.of<TechnicianProvider>(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.blue,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: _previousNavigate,
                ),
              ),
              SizedBox(width: 8.0),
              Text(
                'Back',
                style: TextStyle(
                  fontSize: 7.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold, // Make the text bold
                ),
              ),
            ],
          ),
          ValueListenableBuilder<int>(
            valueListenable: widget.stepNotifier,
            builder: (context, step, _) {
              return Text(
                stepMessages[step],
                style: TextStyle(fontSize: 7.sp, fontWeight: FontWeight.bold, color: Colors.white),
              );
            },
          ),
        ElevatedButton(
         onPressed: (selectionProvider.selectedServices.isNotEmpty || selectTechProvider.selectedTechnicians.isNotEmpty) 
          ? () => _nextNavigate() 
          : null,

          child: Text(
            'Booking Now',
            style: TextStyle(
              fontWeight: FontWeight.bold, // Make the text bold
              fontSize: 6.sp, // Adjusted smaller font size
              color: Colors.white, // Set the text color
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: selectionProvider.selectedServices.isNotEmpty || selectTechProvider.selectedTechnicians.isNotEmpty
                ? Colors.blue // Change color to blue when not empty
                : const Color.fromARGB(255, 55, 81, 109), // Default color
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.0.h), // Reduced button padding
          ).copyWith(
            overlayColor: MaterialStateProperty.all(
              const Color.fromARGB(255, 255, 255, 255).withOpacity(0.2), // Button overlay color on press
            ),
          ),
        ),
        ],
      ),
    );
  }
void _nextNavigate() {
  if (widget.stepNotifier.value < 1) {
    widget.stepNotifier.value++;
  } else {
    // Retrieve booking details
    final selectedServices = Provider.of<ServiceSelectionProvider>(context, listen: false).selectedServices;
    final selectedTechnicians = Provider.of<TechnicianProvider>(context, listen: false).selectedTechnicians;

    final bookingDetailsProvider = Provider.of<BookingDetailsProvider>(context, listen: false);
   
    
    // Check if there's at least one selected service
    if (selectedServices.isNotEmpty) {
      bookingDetailsProvider.setSelectedService(selectedServices.first); // Set the first service
    } else {
      // Handle case where no service is selected
      throw Exception("No service selected");
    }

    // Check if there's at least one selected technician
    if (selectedTechnicians.isNotEmpty) {
      bookingDetailsProvider.setSelectedTechnician(selectedTechnicians.first); // Set the first technician
    } else {
      // Handle case where no technician is selected
      throw Exception("No technician selected");
    }

    // Set the current time as the check-in time
    String currentTime = DateFormat('HH:mm').format(DateTime.now());
    bookingDetailsProvider.setCheckInTime(currentTime); // Set check-in time in provider

    // Navigate to booking page
    Navigator.pushNamed(context, '/checkin');
  }
}


  void _previousNavigate() {
    if (widget.stepNotifier.value > 0) {
      widget.stepNotifier.value--;
    }
  }
}
