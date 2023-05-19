import 'package:blood_donation_app/themes/theme.dart';
import 'package:blood_donation_app/widgets/button_action.dart';
import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonTitle;
  final double widthIcon;
  final VoidCallback? onPressed;

  const EmptyPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.buttonTitle,
    this.widthIcon = 80,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        color: lightText,
        padding: EdgeInsets.all(defaultMargin),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/ic_inbox.png',
              width: widthIcon,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              title,
              style: darkTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              subtitle,
              style: secondaryTextStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            ButtonAction(
              width: 200,
              title: buttonTitle,
              onPressed: onPressed,
            ),
          ],
        ),
      ),
    );
  }
}
