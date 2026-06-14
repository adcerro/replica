import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  final String hintText;
  final enabledBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.35)),
    borderRadius: BorderRadius.circular(12),
  );
  final focusedBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
    borderRadius: BorderRadius.circular(12),
  );
  TextAlign textAlign;
  CustomTextField({
    super.key,
    required this.hintText,
    this.textAlign = TextAlign.start,
  });
  @override
  Widget build(BuildContext context) {
    final inputHintStyle = TextTheme.of(context).labelSmall?.copyWith(
      color: Colors.white.withValues(alpha: 0.35),
      fontSize: 14,
    );
    final inputTextStyle = TextTheme.of(
      context,
    ).labelSmall?.copyWith(color: Colors.white, fontSize: 14);
    return TextField(
      textAlign: textAlign,
      cursorColor: Colors.white,
      style: inputTextStyle,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: inputHintStyle,
        enabledBorder: enabledBorder,
        focusedBorder: focusedBorder,
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.13),
        hoverColor: Colors.white.withValues(alpha: 0.13),
      ),
    );
  }
}
