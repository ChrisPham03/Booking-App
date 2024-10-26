import 'package:booking_app/Providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:booking_app/Providers/service_provider.dart';

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

  void _nextNavigate() {
    if (widget.stepNotifier.value < 1) {
      widget.stepNotifier.value++;
    } else {
      Navigator.pushNamed(context, '/nextPage'); // Update with your route
    }
  }

  void _previousNavigate() {
    if (widget.stepNotifier.value > 0) {
      widget.stepNotifier.value--;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Access the ServiceSelectionProvider here
    final selectionProvider = Provider.of<ServiceSelectionProvider>(context);

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
              Text('Back', style: TextStyle(fontSize: 16.0)),
            ],
          ),
          ValueListenableBuilder<int>(
            valueListenable: widget.stepNotifier,
            builder: (context, step, _) {
              return Text(
                stepMessages[step],
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              );
            },
          ),
          ElevatedButton(
            onPressed: selectionProvider.selectedServices.isNotEmpty ? _nextNavigate : null,
            child: Text('Booking Now'),
          ),
        ],
      ),
    );
  }
}
