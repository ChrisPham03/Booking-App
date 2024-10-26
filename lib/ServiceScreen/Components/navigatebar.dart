import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavigateBar extends StatefulWidget {
  final String text; // Declare a text parameter

  // Constructor to accept the text parameter
  const NavigateBar({Key? key, required this.text}) : super(key: key);

  @override
  _NavigateBarState createState() => _NavigateBarState();
}

class _NavigateBarState extends State<NavigateBar> {}