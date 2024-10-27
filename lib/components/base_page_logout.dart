import 'package:finace_maneger/components/app_colors.dart';
import 'package:finace_maneger/pages/expense_page.dart';
import 'package:finace_maneger/pages/home_page.dart';
import 'package:finace_maneger/pages/login_page.dart';
import 'package:finace_maneger/pages/register_expense_page.dart';
import 'package:finace_maneger/service/auth_service.dart';
import 'package:flutter/material.dart';

class BasePageLogout extends StatefulWidget {
  String titles;
  Widget body;

  BasePageLogout({super.key, required this.titles, required this.body});

  @override
  State<BasePageLogout> createState() => _BasePageLogoutState();
}

class _BasePageLogoutState extends State<BasePageLogout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
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
