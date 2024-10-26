import 'package:firebase_auth/firebase_auth.dart';

class FireAuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

  login() async {
    try {
      var user = await auth.signInWithEmailAndPassword(
          email: 'yurigrams@gmail.com', password: '123456789');
      return user;
    } catch (e) {
      throw e;
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

  register(name, email, password) async {
    try {
      var user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await user.user!.updateDisplayName(name);
      return user;
    } catch (e) {
      throw e;
    }
  }
}
