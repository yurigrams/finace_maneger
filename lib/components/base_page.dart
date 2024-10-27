import 'package:finace_maneger/components/app_colors.dart';
import 'package:finace_maneger/pages/expense_page.dart';
import 'package:finace_maneger/pages/home_page.dart';
import 'package:finace_maneger/pages/login_page.dart';
import 'package:finace_maneger/pages/register_expense_page.dart';
import 'package:finace_maneger/service/auth_service.dart';
import 'package:flutter/material.dart';

class BasePage extends StatefulWidget {
  String titles;
  Widget body;

  BasePage({super.key, required this.titles, required this.body});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      drawer: Drawer(
        backgroundColor: AppColors.primarygroundColor,
        child: FutureBuilder<Map<String, dynamic>?>(
          future: FireAuthService().getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Erro ao carregar dados'));
            }

            if (!snapshot.hasData || snapshot.data == null) {
              return Center(child: Text('Usuário não encontrado'));
            }

            final userData = snapshot.data!;
            final name = userData['name'] ?? 'Nome não disponível';
            final email = userData['email'] ?? 'Email não disponível';

            return ListView(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(name),
                  accountEmail: Text(email),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: AppColors.primarygroundColor,
                    child: Icon(
                      Icons.person,
                      size: 40,
                    ),
                  ),
                ),
                ListTile(
                  title: Text('Inicio'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                ),
                ListTile(
                  title: Text('Exibir Despesas'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ExpensePage()));
                  },
                ),
                ListTile(
                  title: Text('Cadastrar Despesas'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => RegisterExpensePage()));
                  },
                ),
                ListTile(
                  title: Text('Sair'),
                  onTap: () {
                    FireAuthService().logout();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                ),
              ],
            );
          },
        ),
      ),
      appBar: AppBar(
        title: Text(
          widget.titles,
          style: const TextStyle(color: AppColors.white, fontSize: 30),
        ),
        backgroundColor: AppColors.primarygroundColor,
        centerTitle: true,
      ),
      body: widget.body,
    );
  }
}