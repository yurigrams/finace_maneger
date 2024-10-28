import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finace_maneger/service/auth_service.dart';

import '../pages/expense_page.dart';

class FirestoreService {

  var db = FirebaseFirestore.instance;

  Future<void> postExpense(String tipo, double valor, String categoria, Timestamp data, String notas) async {
    try {
      await db.collection('Despesas').add({
        "user": await FireAuthService().checkUser(),
        "tipo": tipo,
        "valor": valor,
        "categoria": categoria,
        "data": data,
        "notas": notas,
      });
    } catch (e) {
      print("Erro ao adicionar despesa: $e");
      throw e;
    }
  }

  Future<List<Expense>> getExpense() async {
  try {
    var despesas = await db.collection('Despesas').orderBy('data', descending: true).get();
    return despesas.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Expense.fromFirestore({
        ...data,
        'id': doc.id,
      });
    }).toList();
  } catch (e) {
    throw Exception("Erro ao obter despesas: $e");
  }
}

  getTotalExpenses() async {
    try {
      double total = 0;
      var expenses = await db.collection('Despesas')
          .get();
      for (var doc in expenses.docs) {
        double value = doc['valor'] ?? 0.0;
        total += value;
      }
      return (total);
    } catch (e) {
      rethrow;
    }
  }

  deleteExpense(id) async {
    try { 
      await db.collection('Despesas').doc(id).delete();
    } catch (e) {
      rethrow;
    }
  }

  Future<DocumentSnapshot> getExpenseById(String documentId) {
    return FirebaseFirestore.instance.collection('Despesas').doc(documentId).get();
  }

  Future<void> updateExpense(
      String documentId,
      String type,
      double amount,
      String category,
      Timestamp date,
      String notes,
      ) {
    return FirebaseFirestore.instance.collection('Despesas').doc(documentId).update({
      'tipo': type,
      'valor': amount,
      'categoria': category,
      'data': date,
      'notas': notes,
    });
  }
}