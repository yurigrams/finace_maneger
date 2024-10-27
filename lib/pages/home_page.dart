import 'package:finace_maneger/components/app_colors.dart';
import 'package:finace_maneger/components/base_page.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BasePage(
      titles: 'Gráfico de Gastos',
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Gastos Mensais',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              Text(
                "Despesas do mês",
                style: TextStyle(color: AppColors.white, fontSize: 30),
              ),
              SizedBox(height: 20),
              Container(
                width: 300,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Despesas',
                      style: TextStyle(color: AppColors.black, fontSize: 25),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'R\$ 0.00',
                      style: TextStyle(
                          color: AppColors.primarygroundColor, fontSize: 25),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Gasto Anual",
                style: TextStyle(color: AppColors.white, fontSize: 30),
              ),
              SizedBox(height: 20),
              Container(
                width: 300,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Valor Total',
                      style: TextStyle(color: AppColors.black, fontSize: 25),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'R\$ 0.00',
                      style: TextStyle(
                          color: AppColors.primarygroundColor, fontSize: 25),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
