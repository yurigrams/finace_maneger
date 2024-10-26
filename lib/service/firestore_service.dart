import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finace_maneger/service/auth_service.dart';

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

  getExpense() async {
    try{
      var despesas = await db.collection('Despesas').orderBy('data', descending: true).get();
      return despesas.docs;
    }catch (e) {
    throw e;
    }
  }
}