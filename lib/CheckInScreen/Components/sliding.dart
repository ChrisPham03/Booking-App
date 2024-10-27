import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SlideWidget extends StatefulWidget {
  @override
  _SlideWidgetState createState() => _SlideWidgetState();
}

class _SlideWidgetState extends State<SlideWidget> {
  final List<String> imageUrls = [
    'assets/images/halloweennails.jpeg',
    'assets/images/ha1.jpg', // Replace with your image paths
    'assets/images/ha2.webp',
    'assets/images/ha3.jpg',
  ];

  late PageController _pageController;
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
    _startAutoSlide();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentIndex < imageUrls.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _pageController.animateToPage(
        _currentIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

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
            child: PageView.builder(
              controller: _pageController,
              itemCount: imageUrls.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage(imageUrls[index]),
                      fit: BoxFit.cover, // Ensure the image fills the rounded rectangle
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
