import 'package:blood_donation_app/themes/theme.dart';
import 'package:flutter/material.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'This Success Page',
          style: darkTextStyle,
        ),
      ),
    );
  }
}
