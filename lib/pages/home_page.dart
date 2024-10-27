import 'package:finace_maneger/components/app_colors.dart';
import 'package:finace_maneger/components/base_page.dart';
import 'package:finace_maneger/components/custom_button.dart';
import 'package:finace_maneger/service/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirestoreService firestoreService = FirestoreService();
  double totalExpenses = 0.0;

  @override
  void initState() {
    super.initState();
    _loadTotalExpenses();
  }

  Future<void> _loadTotalExpenses() async {
    try {
      double total = await firestoreService.getTotalExpenses();
      setState(() {
        totalExpenses = total;
      });
    } catch (e) {
      print("Error loading total expenses: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      titles: 'Resumo de Gastos',
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Gastos Mensais',
                style: TextStyle(fontSize: 30),
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
                      'R\$ ${totalExpenses.toStringAsFixed(2)}', 
                      style: TextStyle(
                        color: AppColors.primarygroundColor,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 100),
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
                      'R\$ ${totalExpenses.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: AppColors.primarygroundColor,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 100),
              Container(
                child: CustomButton(
                  titleButton: 'Adicionar Despesa',
                  onPressed: () {
                    Navigator.pushNamed(context, 'register/expense');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
