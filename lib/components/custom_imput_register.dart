import 'package:flutter/material.dart';
import 'package:finace_maneger/components/app_colors.dart';

class CustomInputRegister extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool obscure;
  final TextInputType keyboardType;
  final int maxLines;

  CustomInputRegister({
    Key? key,
    required this.labelText,
    required this.controller,
    this.obscure = false,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: labelText,
          filled: true,
          fillColor: AppColors.white,
        ),
      ),
    );
  }
}