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
        return Expense.fromFirestore(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      throw Exception("Erro ao obter despesas: $e");
    }
  }
}

