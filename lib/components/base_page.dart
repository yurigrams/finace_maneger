import 'package:finace_maneger/components/app_colors.dart';
import 'package:flutter/material.dart';

class BasePage extends StatefulWidget {
  String titles;
  Widget body;

  BasePage({super.key,
    required this.titles,
    required this.body});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          title: Text(
            widget.titles,
            style: const TextStyle(color: AppColors.white),
          ),
          backgroundColor: AppColors.primarygroundColor,
          centerTitle: true,
        )
    );
  }
}
