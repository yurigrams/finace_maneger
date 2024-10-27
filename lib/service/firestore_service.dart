import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finace_maneger/service/auth_service.dart';

import '../pages/expense_page.dart';

class FirestoreService {

  var db = FirebaseFirestore.instance;

  postExpense(despesa, tipo, valor, categoria, data, notas) async{

    db.collection('Despesas').add({
      "user": await FireAuthService().checkUser(),
      "tipo":tipo,
      "valor":valor,
      "categoria":categoria,
      "data":data,
      "notas":notas,
    });

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