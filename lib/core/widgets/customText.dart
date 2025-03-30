import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText(
    this.text, {
    super.key,
    this.fontSize,
    this.textColor,
    this.fontweight,
    this.textAlign,
    this.decoration,
  });

  final String text;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontweight;
  final TextAlign? textAlign;
  final TextDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight: fontweight,
        decoration: decoration,
        decorationColor: textColor,
      ),
    );
  }
}
