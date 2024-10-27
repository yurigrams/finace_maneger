import 'package:finace_maneger/components/app_colors.dart';
import 'package:finace_maneger/components/base_page.dart';
import 'package:finace_maneger/components/custom_button.dart';
import 'package:finace_maneger/components/custom_button_login.dart';
import 'package:finace_maneger/components/custom_imput.dart';
import 'package:finace_maneger/pages/register_user_page.dart';
import 'package:flutter/material.dart';

import '../service/auth_service.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      titles: 'Login',
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 14),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(size: 180),
            CustomInput(labelText: 'E-mail'),
            CustomInput(labelText: 'Senha', obscure: true),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButtonLogin(
                  titleButton: 'Entrar',
                ),
                SizedBox(
                  width: 15,
                ),
                CustomButton(
                    titleButton: 'Cadastrar',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserRegistrationPage()));
                    }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Esqueceu a senha?'),
                TextButton(
                    onPressed: () {
                      print('Funcionando');
                      FireAuthService().recoverPassword();
                    },
                    child: Text(
                      'Clique aqui',
                      style: TextStyle(color: AppColors.primarygroundColor),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
