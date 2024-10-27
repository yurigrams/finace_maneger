import 'package:firebase_auth/firebase_auth.dart';

class FireAuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

  login(String email, String password) async {
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

  recoverPassword() async {
    try {
      await auth.sendPasswordResetEmail(email: 'yurigrams@gmail.com');
      return true;
    } catch (e) {
      throw e;
    }
  }

  checkUser() async {
    var user = auth.currentUser!.displayName;
    return user;
  }

  logout() async {
    await auth.signOut();
  }
}

  