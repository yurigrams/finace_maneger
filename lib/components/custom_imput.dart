import 'package:finace_maneger/components/app_colors.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {

  String labelText;
  bool obscure;
  TextEditingController controller;


  CustomInput({super.key,
    required this.labelText,
    this.obscure = false,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        style: TextStyle(color: AppColors.black),
        obscureText: obscure,
        controller: controller,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: labelText,
            filled: true,
            fillColor: AppColors.white
        ),
      ),
    );
  }
}