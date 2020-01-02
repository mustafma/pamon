import 'package:firebase_auth/firebase_auth.dart';


class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;

  // sign in anony.
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      user = result.user;
      return user;
    } catch(e)
    {
      print(e.toString());
      return null;
    }
  }
  // sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);

      user = result.user;
      return user;
    }
    catch(e) {

    }
  }

  void signOut() async {
    await _auth.signOut();

  }


}