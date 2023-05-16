import 'package:blood_donation_app/themes/theme.dart';
import 'package:flutter/material.dart';

class FooterAuth extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const FooterAuth({
    super.key,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 30,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: secondaryTextStyle.copyWith(
              fontSize: 12,
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Text(
              subtitle,
              style: primaryTextStyle.copyWith(
                fontSize: 12,
                fontWeight: semiBold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
