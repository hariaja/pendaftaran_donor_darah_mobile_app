import 'package:blood_donation_app/themes/theme.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'This Error Page',
          style: darkTextStyle,
        ),
      ),
    );
  }
}
