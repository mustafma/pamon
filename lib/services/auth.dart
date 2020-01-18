import 'package:firebase_auth/firebase_auth.dart';
import 'package:hello_world/Model/User.dart';
import 'package:hello_world/Model/session.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;
  static Session sessionObj;

  // sign in anony.
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      user = result.user;
      setUserInfo(user.displayName , "Dr"); // Set UserInfor
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      user = result.user;
      setUserInfo(user.displayName , "Nr"); // Set UserInfor
      return user;
    } catch (e) {
      throw new AuthException(e.code, e.message);
    }
  }

  void signOut() async {
    await _auth.signOut();
  }

  void setUserInfo(String userId, String typeAsString) {
    User user = User.getInstance();
    user.setUserId(userId);
    user.setUserType(user.stringToUserTypeConvert(typeAsString));
  }
}
