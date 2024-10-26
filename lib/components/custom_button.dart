import 'package:finace_maneger/components/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  String titleButton;
  VoidCallback onPressed;
  CustomButton({super.key, required this.titleButton, required this.onPressed});


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 200,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primarygroundColor),
        onPressed: onPressed
          // try{
          //   await FireAuthService().login();
          //   Navigator.pushReplacementNamed(context, '/');
          // }catch (e) {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //       SnackBar(
          //         backgroundColor: Colors.red,
          //         content: Text('Usuario ou senha incorreto'),
          //       )
          //   );
          // }
        ,
        child: Text(titleButton),
      ),
    );
  }
}