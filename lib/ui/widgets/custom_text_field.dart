import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  final TextAlign textAlign;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  CustomTextField({
    super.key,
    required this.hintText,
    this.textAlign = TextAlign.start,
    this.controller,
    this.keyboardType,
    this.inputFormatters,
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
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      controller: controller,
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
