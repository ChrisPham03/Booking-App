

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user_provider.dart'; // Make sure to adjust the import according to your project structure.

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
    return GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 1.5,
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
      physics: NeverScrollableScrollPhysics(),
      children: List.generate(12, (index) {
        if (index < 9) {
          return _buildButton((index + 1).toString());
        } else if (index == 9) {
          return _buildButton('', icon: Icons.backspace, onPressed: () => onDelete());
        } else if (index == 10) {
          return _buildButton('0');
        } else if (index == 11) {
          return Visibility(
            visible: Provider.of<PhoneNumberProvider>(context).phoneNumber.length >= 10,
            child: _buildButton('', icon: Icons.check, onPressed: () => onCheckMark()),
          );
        }
        return Container();
      }),
    );
  }

  Widget _buildButton(String text, {IconData? icon, VoidCallback? onPressed}) {
    return Container(
      child: OutlinedButton(
        onPressed: onPressed ?? () => onKeyPress(text),
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(0.3),
          side: BorderSide(color: Colors.white, width: 1.0),
        ),
        child: icon != null
            ? Icon(icon, size: 26.0, color: Colors.white)
            : Text(
                text,
                style: TextStyle(fontSize: 26.0, color: Colors.white),
              ),
      ),
    );
  }
}
