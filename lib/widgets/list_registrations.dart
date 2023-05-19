import 'package:blood_donation_app/data/models/registration.dart';
import 'package:blood_donation_app/themes/theme.dart';
import 'package:flutter/material.dart';

class ListRegistrations extends StatelessWidget {
  final Registration registration;

  const ListRegistrations({
    super.key,
    required this.registration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: formLight,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Expanded(
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  registration.number!,
                  style: darkTextStyle.copyWith(
                    fontWeight: semiBold,
                  ),
                ),
                Text(
                  registration.status!,
                  style: registration.status! == 'Pending'
                      ? blueTextStyle.copyWith(fontWeight: semiBold)
                      : greenTextStyle.copyWith(fontWeight: semiBold),
                ),
              ],
            ),
            const Spacer(),
            Icon(
              Icons.info_outline_rounded,
              color: secondaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
