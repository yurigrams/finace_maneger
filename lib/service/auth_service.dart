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
      rethrow;
    }
  }

  Future<String?> checkUser() async {
    return auth.currentUser?.uid;
  }

  Future<void> logout() async {
    await auth.signOut();
  }

  Future<bool> recoverPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      print('Erro ao enviar email de recuperação: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>?> getUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .get();
        return userDoc.data() as Map<String, dynamic>?;
      }
    } catch (e) {
      print('Erro ao buscar dados do usuário: $e');
    }
    return null;
  }
}
