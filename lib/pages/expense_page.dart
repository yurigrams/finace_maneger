import 'package:finace_maneger/components/app_colors.dart';
import 'package:finace_maneger/pages/register_expense_page.dart';
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
  final String documentId;

  Expense({
    required this.tipo,
    required this.valor,
    required this.categoria,
    required this.data,
    required this.notas,
    required this.documentId,
  });

  factory Expense.fromFirestore(Map<String, dynamic> json) {
    return Expense(
      documentId: json['id'] ?? '',
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

class ExpensePage extends StatefulWidget {
  @override
  _ExpensePageState createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  final FirestoreService firestoreService = FirestoreService();
  late Future<List<Expense>> _expensesFuture;

  @override
  void initState() {
    super.initState();
    _expensesFuture = _getExpenses();
  }

  Future<List<Expense>> _getExpenses() async {
    try {
      var docs = await firestoreService.getExpense();
      print(docs);
      return docs;
    } catch (e) {
      print("Erro ao obter despesas: $e");
      throw Exception("Erro ao obter despesas: $e");
    }
  }

  void _editExpense(BuildContext context, Expense expense) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegisterExpensePage(documentId: expense.documentId),
      ),
    );
  }

  void _deleteExpense(String documentId) async {
    try {
      await firestoreService.deleteExpense(documentId);
      setState(() {
        _expensesFuture = _getExpenses();
      });
    } catch (e) {
      print("Erro ao excluir despesa: $e");
      throw Exception("Erro ao excluir despesa: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      titles: "Despesas",
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: FutureBuilder<List<Expense>>(
          future: _expensesFuture,
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
                columnSpacing: 12,
                columns: [
                  DataColumn(label: Text("Tipo")),
                  DataColumn(label: Text("Valor")),
                  DataColumn(label: Text("Categoria")),
                  DataColumn(label: Text("Data")),
                  DataColumn(label: Text("Notas")),
                  DataColumn(label: Text("Ações")),
                ],
                rows: expenses.map((expense) {
                  return DataRow(cells: [
                    DataCell(Text(expense.tipo)),
                    DataCell(Text(expense.valor.toStringAsFixed(2))),
                    DataCell(Text(expense.categoria)),
                    DataCell(Text(expense.getFormattedDate())),
                    DataCell(Text(expense.notas)),
                    DataCell(Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: AppColors.white),
                          onPressed: () {
                            _editExpense(context, expense);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: AppColors.primarygroundColor),
                          onPressed: () {
                            _deleteExpense(expense.documentId);
                          },
                        ),
                      ],
                    ))
                  ]);
                }).toList(),
              );
            }
          },
        ),
      ),
    );
  }
}
