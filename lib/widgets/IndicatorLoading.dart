import 'package:flutter/material.dart';

class IndicatorLoading extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;

  const IndicatorLoading({
    super.key,
    this.width = 24,
    this.height = 24,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation(
          color,
        ),
      ),
    );
  }
}
