import 'package:blood_donation_app/themes/theme.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Registration Page',
          style: darkTextStyle,
        ),
      ),
    );
  }
}
