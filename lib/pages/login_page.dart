import 'package:finace_maneger/components/base_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(titles: 'Login',
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 14),

        ),
    );
  }
}
