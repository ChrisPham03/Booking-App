import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../Providers/user_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserDetailsInputForm extends StatefulWidget {
  final Function() onSignUp;

  UserDetailsInputForm({required this.onSignUp});

  @override
  _UserDetailsInputFormState createState() => _UserDetailsInputFormState();
}

class _UserDetailsInputFormState extends State<UserDetailsInputForm> {
  bool _isKeyboardVisible = false;
  DateTime? _selectedDate;
  late TextEditingController _birthdayController;

  @override
  void initState() {
    super.initState();
    _birthdayController = TextEditingController();
    KeyboardVisibilityController().onChange.listen((bool isVisible) {
      setState(() {
        _isKeyboardVisible = isVisible;
      });
    });
  }

  @override
  void dispose() {
    _birthdayController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: const Color.fromARGB(255, 55, 81, 109),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _birthdayController.text = DateFormat('MM/dd/yyyy').format(picked);
      });
      Provider.of<UserDetailsProvider>(context, listen: false).updateBirthday(_birthdayController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
  final userDetailsProvider = Provider.of<UserDetailsProvider>(context);
  final phonenumberProvider= Provider.of<PhoneNumberProvider>(context);

  return SingleChildScrollView(
    child: Center(
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        width: 310.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             // Centered text for phone number
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Your phone number is ${phonenumberProvider.phoneNumber}', // Assuming you have a phoneNumber property
                  style: TextStyle(
                    fontSize: 7.sp, // Responsive text size
                    color:const Color.fromARGB(255, 55, 81, 109), // Change as needed
                  ),
                ),
              ),
            SizedBox(height:15),
            Row(
              children: [
                
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Full Name'),
                    onChanged: (value) {
                      userDetailsProvider.updateFullName(value);
                    },
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: TextField(
                    controller: _birthdayController,
                    decoration: InputDecoration(
                      labelText: 'Birthday (OPTIONAL)',
                      hintText: 'MM/DD/YY',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () => _selectDate(context),
                      ),
                    ),
                    onChanged: (value) {
                      userDetailsProvider.updateBirthday(value);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Email'),
                    onChanged: (value) {
                      userDetailsProvider.updateEmail(value);
                    },
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Preferred Name (OPTIONAL)'),
                    onChanged: (value) {
                      userDetailsProvider.updateReferredBy(value);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),


            SizedBox(height: 24.h),

            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: widget.onSignUp,
                child: Text(
                  'Sign Up',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 55, 81, 109),
                  padding: EdgeInsets.symmetric(horizontal: 32.0.w, vertical: 12.0.h),
                ).copyWith(
                  overlayColor: WidgetStateProperty.all(
                    const Color.fromARGB(255, 255, 255, 255).withOpacity(0.2),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

}
