import 'package:firebase_auth/firebase_auth.dart';
import 'package:hello_world/Model/User.dart';
import 'package:hello_world/Model/session.dart';
import 'package:hello_world/services/crud.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _userCached;
  static Session sessionObj;

  // sign in anony.
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      _userCached = result.user;
      setUserInfo(_userCached.uid, _userCached.displayName , "Dr"); // Set UserInfor
      return _userCached;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  FirebaseUser getUser()
  {
    return _userCached;
  }

  // sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      _userCached = result.user;
      CrudMethods crudObj = new CrudMethods();
      setUserInfo(_userCached.uid , _userCached.displayName, await crudObj.getUserRole(_userCached.uid)); // Set UserInfor
      return _userCached;
    } catch (e) {
      throw new AuthException(e.code, e.message);
    }
  }

  void signOut() async {
    await _auth.signOut();
  }

  void setUserInfo(String userId, String displayName, String typeAsString) {
    User user = User.getInstance();
    user.setUserId(userId);
    user.setUserName(displayName);
    user.setUserType(user.stringToUserTypeConvert(typeAsString));
  }
}
