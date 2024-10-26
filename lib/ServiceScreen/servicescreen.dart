import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../Providers/service_provider.dart';
import '../../Providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Components/header.dart';
import 'Components/navigatebar.dart';
import 'Components/ChooseBoard/serviceboard.dart';

class ServicePage extends StatefulWidget {
  @override
  _ServicePageState createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  @override
  void initState() {
    super.initState();
    _setOrientationBasedOnSize();
  }

  void _setOrientationBasedOnSize() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      double width = MediaQuery.of(context).size.width;

      if (width <= 430) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
      } else {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
      }
    });
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    if (width <= 430) {
      return _buildPortrait();
    }

    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return _buildPortrait();
        } else {
          return _buildLandScape(context);
        }
      },
    );
  }

  Widget _buildPortrait() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Header(), // Use Header widget
            NavigateBar(), // Add NavigateBar for navigation
            Expanded(
              child: SafeArea(
                child: ServiceBoard(), // Add ServiceBoard below the navbar
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLandScape(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Header(),
            NavigateBar(), // Add NavigateBar for navigation
            Expanded(
              child: SafeArea(
                child: ServiceBoard(), // Add ServiceBoard below the navbar
              ),
            ),
          ],
        ),
      ),
    );
  }
}
