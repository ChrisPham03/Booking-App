import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'ChooseBoard/serviceboard.dart';

class NavigateBar extends StatefulWidget {
  const NavigateBar({Key? key}) : super(key: key);

  @override
  _NavigateBarState createState() => _NavigateBarState();
}

class _NavigateBarState extends State<NavigateBar> {
  int step = 0; // Initialize the step here

  // Messages for the two steps
  final List<String> stepMessages = [
    "Step 1/2 - Choose Service",
    "Step 2/2 - Choose Technician",
  ];

  void _nextNavigate() {
    if (step < 1) {
      setState(() {
        step++;
      });
    } else {
      // Navigate to the next page when step is 2
      Navigator.pushNamed(context, '/nextPage'); // Update with your route
    }
  } 

  void _previousNavigate() {
    if (step > 0) {
      setState(() {
        step--;
      });
    }

    else{}
  }

  @override
  Widget build(BuildContext context) {
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
                  onPressed: _previousNavigate, // Call previous step
                ),
              ),
              SizedBox(width: 8.0),
              Text('Back', style: TextStyle(fontSize: 16.0)),
            ],
          ),
          Text(
            stepMessages[step], // Display based on step (0 or 1)
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          ElevatedButton(
            onPressed: _nextNavigate, // Call next step
            child: Text('Booking Now'),
          ),
        ],
      ),
    );
  }
}
