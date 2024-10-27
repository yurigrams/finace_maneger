import 'package:finace_maneger/components/app_colors.dart';
import 'package:finace_maneger/components/base_page.dart';
import 'package:finace_maneger/components/base_page_logout.dart';
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
    TextEditingController email = TextEditingController();
    TextEditingController senha = TextEditingController();
    return BasePageLogout(
      titles: 'Login',
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 14),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(size: 180),
            CustomInput(labelText: 'E-mail', controller: email),
            CustomInput(labelText: 'Senha', obscure: true, controller: senha),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButtonLogin(email: email,senha: senha,
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
                      FireAuthService().recoverPassword(email.text);
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
