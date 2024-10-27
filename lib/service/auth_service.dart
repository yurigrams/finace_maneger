import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireAuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<User?> register(String email, String password, String name, String cpf, String birthDate) async {
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

  Future<User?> login(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print("Erro ao fazer login: $e");
      return null;
    }
  }

  Future<String?> checkUser() async {
    return auth.currentUser?.uid;
  }

  Future<void> logout() async {
    await auth.signOut();
  }

  recoverPassword() async {
    try {
      await auth.sendPasswordResetEmail(email: 'yurigrams@gmail.com');
      return true;
    } catch (e) {
      throw e;
    }
  }
}
