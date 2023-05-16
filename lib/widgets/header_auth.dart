import 'package:blood_donation_app/themes/theme.dart';
import 'package:flutter/material.dart';

class HeaderAuth extends StatelessWidget {
  final String title;
  final String subtitle;

  const HeaderAuth({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: defaultMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: darkTextStyle.copyWith(
              fontSize: 24,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            subtitle,
            style: secondaryTextStyle,
          ),
        ],
      ),
    );
  }
}
