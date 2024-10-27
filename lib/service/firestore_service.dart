import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finace_maneger/service/auth_service.dart';

import '../pages/expense_page.dart';

class FirestoreService {

  var db = FirebaseFirestore.instance;

  Future<void> postExpense(String tipo, double valor, String categoria, Timestamp data, String notas) async {
    try {
      await db.collection('Despesas').add({
        "user": await FireAuthService().checkUser(), // Verifica o usuário logado
        "tipo": tipo,
        "valor": valor,
        "categoria": categoria,
        "data": data,
        "notas": notas,
      });
    } catch (e) {
      print("Erro ao adicionar despesa: $e");
      throw e; // Re-lança a exceção para ser capturada onde o método é chamado
    }
  }

  Future<List<Expense>> getExpense() async {
  try {
    var despesas = await db.collection('Despesas').orderBy('data', descending: true).get();
    return despesas.docs.map((doc) {
      // Use doc.data() para obter os dados do documento
      final data = doc.data() as Map<String, dynamic>; // Obtém os dados do documento
      return Expense.fromFirestore({
        ...data, // Espalha os dados do documento
        'id': doc.id, // Adiciona o documentId ao mapa
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

}

 



