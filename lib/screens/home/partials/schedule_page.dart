import 'package:blood_donation_app/themes/theme.dart';
import 'package:flutter/material.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Schedule Page',
          style: darkTextStyle,
        ),
      ),
    );
  }
}
