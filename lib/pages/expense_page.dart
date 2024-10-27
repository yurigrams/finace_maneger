import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../components/base_page.dart';
import '../service/firestore_service.dart';

class Expense {
  final String tipo;
  final double valor;
  final String categoria;
  final Timestamp data;
  final String notas;

  Expense({
    required this.tipo,
    required this.valor,
    required this.categoria,
    required this.data,
    required this.notas,
  });

  factory Expense.fromFirestore(Map<String, dynamic> json) {
    return Expense(
      tipo: json['tipo'] ?? '',
      valor: (json['valor'] ?? 0).toDouble(),
      categoria: json['categoria'] ?? '',
      data: json['data'] as Timestamp? ?? Timestamp.now(),
      notas: json['notas'] ?? '',
    );
  }

  String getFormattedDate() {
    return DateFormat('dd/MM/yyyy').format(data.toDate());
  }
}

class ExpensePage extends StatelessWidget {
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return BasePage(
      titles: "Despesas",
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: FutureBuilder<List<Expense>>(
          future: _getExpenses(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              print("Erro ao carregar despesas: ${snapshot.error}");
              return Center(child: Text("Erro ao carregar despesas: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("Nenhuma despesa encontrada."));
            } else {
              final expenses = snapshot.data!;
              return DataTable(
                columns: [
                  DataColumn(label: Text("Tipo")),
                  DataColumn(label: Text("Valor")),
                  DataColumn(label: Text("Categoria")),
                  DataColumn(label: Text("Data")),
                  DataColumn(label: Text("Notas")),
      
                ],
                rows: expenses.map((expense) {
                  return DataRow(
                    cells: [
                    DataCell(Text(expense.tipo)),
                    DataCell(Text(expense.valor.toStringAsFixed(2))),
                    DataCell(Text(expense.categoria)),
                    DataCell(Text(expense.getFormattedDate())),
                    DataCell(Text(expense.notas)),
                  ]);
                }).toList(),
              );
            }
          },
        ),
      ),
    );
  }

  Future<List<Expense>> _getExpenses() async {
    try {
      var docs = await firestoreService.getExpense();
      return docs;
    } catch (e) {
      print("Erro ao obter despesas: $e");
      throw Exception("Erro ao obter despesas: $e");
    }
  }
}
