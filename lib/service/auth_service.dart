import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireAuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  register(String email, String password, String name, String cpf, String birthDate) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Após criar o usuário, adicione os detalhes no Firestore
      await firestore.collection('Users').doc(userCredential.user!.uid).set({
        'name': name,
        'cpf': cpf,
        'birthDate': birthDate,
        'email': email,
      });

      return userCredential.user;
    } catch (e) {
      print("Erro ao registrar usuário: $e");
      return null;
    }
  }

  login(String email, String password) async {
    print(email);
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print("Erro ao fazer login: $e");
      rethrow;
    }
  }

  checkUser() async {
    return auth.currentUser?.uid;
  }

  logout() async {
    await auth.signOut();
  }

  recoverPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      throw e;
    }
  }
}
