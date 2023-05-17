import 'package:blood_donation_app/themes/theme.dart';
import 'package:flutter/material.dart';

class ItemStoreRegistration extends StatelessWidget {
  final String title;
  final String value;
  final double width;
  final double height;

  const ItemStoreRegistration({
    super.key,
    required this.title,
    required this.value,
    this.width = double.infinity,
    this.height = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: formLight,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Expanded(
        child: Row(
          children: [
            Text(
              title,
              style: darkTextStyle,
            ),
            const Spacer(),
            Text(
              value,
              style: darkTextStyle.copyWith(
                fontWeight: medium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
