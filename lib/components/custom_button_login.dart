import 'package:finace_maneger/components/app_colors.dart';
import 'package:finace_maneger/service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomButtonLogin extends StatelessWidget {

  String titleButton;
  TextEditingController email;
  TextEditingController senha;


  CustomButtonLogin({super.key, required this.titleButton, required this.email, required this.senha});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 200,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primarygroundColor),
        onPressed: () async {
                  try { 
                    await FireAuthService().login(email.text, senha.text);
                    Navigator.pushReplacementNamed(context, '/');
                    print('logou');
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text('Usuário ou senha incorretos')
                        )
                      );
                  }
                }, 
        child: Text(titleButton),
      ),
    );
  }
}