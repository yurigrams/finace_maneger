import 'package:finace_maneger/components/base_page.dart';
import 'package:finace_maneger/components/custom_button.dart';
import 'package:finace_maneger/components/custom_imput.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(titles: 'Login',
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 14),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlutterLogo(size: 180),
                CustomInput(labelText: 'E-mail'),
                CustomInput(labelText: 'Senha', obscure: true),
                SizedBox(height: 15,),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(titleButton: 'Entrar'),
                    SizedBox(width: 15,),
                    CustomButton(titleButton: 'Cadastrar')
                  ],
                ),
              ],
          ),
        ),
    );
  }
}
