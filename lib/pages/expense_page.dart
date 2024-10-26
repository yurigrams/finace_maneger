import 'package:flutter/material.dart';

import '../components/base_page.dart';

class Expense {
  final String type;
  final double value;
  final String category;
  final String date;
  final String notes;

  Expense({
    required this.type,
    required this.value,
    required this.category,
    required this.date,
    required this.notes,
  });
}

class ExpensePage extends StatelessWidget {

  final List<Expense> expenses = [
    Expense(type: "Alimentação", value: 150.0, category: "Almoço", date: "01/10/2024", notes: "Almoço no restaurante"),
    Expense(type: "Transporte", value: 30.0, category: "Uber", date: "02/10/2024", notes: "Corrida para o trabalho"),
    Expense(type: "Lazer", value: 200.0, category: "Cinema", date: "03/10/2024", notes: "Filme com amigos"),
  ];

  @override
  Widget build(BuildContext context) {
    return BasePage(titles: "Despesas",
      body:
      Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: DataTable(
            columns: [
              DataColumn(label: Text("Tipo")),
              DataColumn(label: Text("Valor")),
              DataColumn(label: Text("Categoria")),
              DataColumn(label: Text("Data")),
              DataColumn(label: Text("Notas")),
            ],
            rows: expenses.map((expense) {
              return DataRow(cells: [
                DataCell(Text(expense.type)),
                DataCell(Text(expense.value.toStringAsFixed(2))),
                DataCell(Text(expense.category)),
                DataCell(Text(expense.date)),
                DataCell(Text(expense.notes)),
              ]);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
