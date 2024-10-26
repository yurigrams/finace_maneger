import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  String titleButton;
  CustomButton({super.key, required this.titleButton});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
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
        },
        child: Text(titleButton),
      ),
    );
  }
}