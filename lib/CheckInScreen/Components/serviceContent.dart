import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'service_provider.dart';

class WelcomeContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Accessing the spa name from the provider
    final spaName = Provider.of<SpaNameProvider>(context).spaName;

    return Container(
      width: 0.8.sw,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white,
          width: 1.5.w,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.2),
            offset: Offset(0, 0.005.sh),
            blurRadius: 0.005.sh,
            spreadRadius: 0.005.sh,
          ),
          BoxShadow(
            color: Colors.pink.withOpacity(0.15),
            offset: Offset(0.005.sw, 0.003.sh),
            blurRadius: 0.01.sh,
            spreadRadius: 0.01.sh,
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0.001.sh,
            left: 0,
            right: 0,
            child: Center(
              child: AnimatedTextKit(
                repeatForever: false,
                totalRepeatCount: 1,
                animatedTexts: [
                  TyperAnimatedText(
                    'Welcome To',
                    speed: const Duration(milliseconds: 90),
                    textStyle: GoogleFonts.allison(
                      fontSize: 0.1.sh,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0.05.sh,
            left: 0,
            right: 0,
            child: Center(
              child: AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  FadeAnimatedText(
                    spaName,
                    duration: const Duration(milliseconds: 3500),
                    textStyle: GoogleFonts.inriaSerif(
                      fontSize: 0.05.sh,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}