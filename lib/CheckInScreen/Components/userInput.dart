

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user_provider.dart'; // Make sure to adjust the import according to your project structure.
import 'package:flutter_screenutil/flutter_screenutil.dart';


class NumericKeypad extends StatelessWidget {
  
  final Function(String) onKeyPress;
  final Function onDelete;
  final Function onCheckMark;

  NumericKeypad({
    required this.onKeyPress,
    required this.onDelete,
    required this.onCheckMark,
  });

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final isLandscape = orientation == Orientation.landscape;
    return GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 1.5,
      mainAxisSpacing: isLandscape? 28.h : 18.h,
      crossAxisSpacing: 12.w,
      physics: NeverScrollableScrollPhysics(),
      children: List.generate(12, (index) {
          // Determine font size based on orientation
        double fontSize = isLandscape ? 19.sp : 29.sp;
        if (index < 9) {
          return _buildButton((index + 1).toString(),fontSize: fontSize);
        } else if (index == 9) {
          return _buildButton('', icon: Icons.backspace, onPressed: () => onDelete(),fontSize: fontSize);
        } else if (index == 10) {
          return _buildButton('0',fontSize: fontSize);
        } else if (index == 11) {
          return Visibility(
            visible: Provider.of<PhoneNumberProvider>(context).phoneNumber.length >= 10,
            child: _buildButton('', icon: Icons.check, onPressed: () => onCheckMark(),fontSize: fontSize),
          );
        }
        return Container();
      }),
    );
  }

  Widget _buildButton(String text, {IconData? icon, VoidCallback? onPressed, double? fontSize}) {
    return Container(
      child: OutlinedButton(
        onPressed: onPressed ?? () => onKeyPress(text),
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(0.3),
          side: BorderSide(color: Colors.white, width: 1.0),
          
        ),
        child: icon != null
            ? Icon(icon, size: fontSize, color: Colors.white)
            : Text(
                text,
                style: TextStyle(fontSize:fontSize, color: Colors.white),
              ),
      ),
    );
  }
}
