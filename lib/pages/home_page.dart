import 'package:finace_maneger/components/app_colors.dart';
import 'package:finace_maneger/components/base_page.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HomePage extends StatelessWidget {
  final List<double> monthlyExpenses = [
    500,
    700,
    600,
    400,
    800,
    750,
    670,
    900,
    850,
    720,
    660,
    780
  ];

  @override
  Widget build(BuildContext context) {
    double maxY = monthlyExpenses.isNotEmpty
        ? monthlyExpenses.reduce((a, b) => a > b ? a : b) + 100
        : 1000;

    return BasePage(
      titles: 'Gráfico de Gastos',
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Gastos Mensais',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                height: 300,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: maxY.isFinite ? maxY : 1000,
                    barGroups: List.generate(
                      monthlyExpenses.length,
                          (index) => BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                            toY: monthlyExpenses[index].isFinite
                                ? monthlyExpenses[index]
                                : 0,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ),
                  ),
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
