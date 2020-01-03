import 'package:firebase_auth/firebase_auth.dart';
import 'package:hello_world/Model/session.dart';


class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;
  static session sessionObj;

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

// User Object missign type and friendly name that might be used to welcome message in appbar 
// N = Nurse
// D = Doctor
// S = Nurse manager or shift manager
       sessionObj = new session("yosef", "N", DateTime.now());
      return user;
    }
    catch(e) {

    }
  }

  void signOut() async {
    await _auth.signOut();

  }


}