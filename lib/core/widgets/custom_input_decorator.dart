import 'package:flutter/material.dart';

InputDecoration customInputDecoration({
  String? labelText,
  String? hintText,
  Widget? prefixIcon,
  Widget? suffixIcon,
}) {
  return InputDecoration(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    labelText: labelText,
    hintText: hintText,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
    // contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
  );
}
