import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart'; // Import Animated Text Kit

class CheckInPage extends StatefulWidget {
  @override
  _CheckInPageState createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  // Variable to hold the user's phone number
  String _phoneNumber = '';

  // Method to handle key presses on the numeric keyboard
  void _onKeyPress(String value) {
    setState(() {
      _phoneNumber += value; // Append the pressed key value to the phone number
    });
  }

  // Method to delete the last character from the phone number
  void _onDelete() {
    if (_phoneNumber.isNotEmpty) {
      setState(() {
        // Remove the last character
        _phoneNumber = _phoneNumber.substring(0, _phoneNumber.length - 1);
      });
    }
  }

  // Method to handle check mark button press
  void _onCheckMark() {
    // Here, you can define what should happen when the check mark is pressed
    print("Phone number: $_phoneNumber");
    // Implement validation or further actions if needed
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size
    Size screenSize = MediaQuery.of(context).size;
    double buttonSize = screenSize.width / 4; 
    double spacing = 10.0; // Space between buttons
    double textFieldFontSize = screenSize.width * 0.1; // Responsive font size for the text field
    double buttonFontSize = screenSize.width * 0.1; // Responsive font size for buttons
    double iconSize = buttonFontSize * 0.8; // Icon size based on button size

    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/loginbackground.jpg'), // Load the background image from assets
                fit: BoxFit.cover, // Make the image cover the entire background
              ),
            ),
          ),
          // Use SafeArea to avoid system UI obstructions
          SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(17.0), // Padding around the content
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
                    children: <Widget>[
                      // Centered board with increased size
                      Container(
                        padding: EdgeInsets.all(1.0), // Padding inside the container
                        width: screenSize.width * 0.8, // Set width to 80% of screen width
                        height: screenSize.height * 0.195, // Set height to 19.5% of screen height
                        decoration: BoxDecoration(
                          color: Colors.transparent, // Keep background transparent
                          borderRadius: BorderRadius.circular(16.0), // Rounded corners with a radius of 16
                          border: Border.all(
                            color: Colors.white, // White border color
                            width: 1.5, // Border width
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.2), // Semi-transparent white shadow
                              offset: Offset(0, screenSize.height * 0.005), // Responsive vertical offset
                              blurRadius: screenSize.height * 0.005, // Responsive blur radius
                              spreadRadius: screenSize.height * 0.005, // Responsive spread radius
                            ),
                            BoxShadow(
                              color: Colors.pink.withOpacity(0.15), // Semi-transparent pink shadow
                              offset: Offset(screenSize.width * 0.005, screenSize.height * 0.003), // Responsive offsets
                              blurRadius: screenSize.height * 0.01, // Responsive blur radius
                              spreadRadius: screenSize.height * 0.01, // Responsive spread radius
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            // Positioned welcome message
                            Positioned(
                              top: screenSize.height * -0.03,
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
                                        fontSize: screenSize.height * 0.1,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Positioned spa name
                            Positioned(
                              top: screenSize.height * 0.1,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: AnimatedTextKit(
                                  repeatForever: true,
                                  animatedTexts: [
                                    FadeAnimatedText(
                                      'Holidays Nails',
                                      duration: const Duration(milliseconds: 2500),
                                      textStyle: GoogleFonts.inriaSerif(
                                        fontSize: screenSize.height * 0.035,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      // Phone number input field
                      Container(
                        width: screenSize.width * 0.8,
                        child: TextField(
                          controller: TextEditingController(text: _phoneNumber),
                          readOnly: true,
                          style: TextStyle(fontSize: textFieldFontSize, color: Colors.white), // Responsive font size
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: 'Please enter your cell phone number',
                            hintStyle: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 19),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      // Custom numeric keyboard
                      GridView.count(
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: List.generate(13, (index) {
                          if (index < 9) {
                            // Create buttons for numbers 1 to 9
                            return Container(
                              padding: EdgeInsets.all(spacing),
                              child: OutlinedButton(
                                onPressed: () => _onKeyPress((index + 1).toString()),
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.white.withOpacity(0.3),
                                  side: BorderSide(color: Colors.white, width: 1),
                                  minimumSize: Size(buttonSize, buttonSize),
                                ),
                                child: Text(
                                  (index + 1).toString(),
                                  style: TextStyle(fontSize: buttonFontSize, color: Colors.white), // Responsive font size
                                ),
                              ),
                            );
                          } else if (index == 9) {
                            // Create the delete button
                            return Container(
                              padding: EdgeInsets.all(spacing),
                              child: OutlinedButton(
                                onPressed: _onDelete,
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.white.withOpacity(0.3),
                                  side: BorderSide(color: Colors.white, width: 1),
                                  minimumSize: Size(buttonSize, buttonSize),
                                ),
                                child: Icon(Icons.backspace, size: buttonFontSize, color: Colors.white),
                              ),
                            );
                          } else if (index == 10) {
                            // Create button for number 0
                            return Container(
                              padding: EdgeInsets.all(spacing),
                              child: OutlinedButton(
                                onPressed: () => _onKeyPress('0'),
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.white.withOpacity(0.3),
                                  side: BorderSide(color: Colors.white, width: 1),
                                  minimumSize: Size(buttonSize, buttonSize),
                                ),
                                child: Text(
                                  '0',
                                  style: TextStyle(fontSize: buttonFontSize, color: Colors.white), // Responsive font size
                                ),
                              ),
                            );
                          } else if (index == 11) {
                            // Create the check mark button only if the phone number has at least 10 digits
                            return Visibility(
                              visible: _phoneNumber.length >= 10,
                              child: Container(
                                padding: EdgeInsets.all(spacing),
                                child: OutlinedButton(
                                  onPressed: _onCheckMark, // Enable the button since we check visibility
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.white.withOpacity(0.3),
                                    side: BorderSide(color: Colors.white, width: 1),
                                    minimumSize: Size(buttonSize, buttonSize),
                                  ),
                                  child: Icon(
                                    Icons.check,
                                    size: iconSize,
                                    color: Colors.white, // Icon color is always white
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Container(); // Empty container for layout consistency
                          }
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
