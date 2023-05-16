import 'package:blood_donation_app/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFilledForm extends StatelessWidget {
  final String title;
  final String hintText;
  final String iconPath;
  final bool obsecureText;
  final bool readOnly;
  final double vertical;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final IconButton? iconButton;

  const CustomFilledForm({
    super.key,
    required this.title,
    required this.hintText,
    required this.iconPath,
    this.obsecureText = false,
    this.readOnly = false,
    this.controller,
    this.keyboardType,
    this.vertical = 14,
    this.validator,
    this.inputFormatters,
    this.iconButton,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: darkTextStyle.copyWith(
            fontWeight: medium,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        TextFormField(
          obscureText: obsecureText,
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          inputFormatters: inputFormatters,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            filled: true,
            fillColor: formLight,
            hintText: hintText,
            hintStyle: secondaryTextStyle.copyWith(
              fontSize: 14,
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: vertical,
            ),
            suffixIcon: iconButton,
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Image.asset(
                iconPath,
                width: 17,
              ),
            ),
          ),
          readOnly: readOnly,
        ),
      ],
    );
  }
}
