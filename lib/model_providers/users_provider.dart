import 'package:BridgeTeam/Model/User2.dart';
import 'package:flutter/material.dart';

//import '../models_services/users_services.dart';

class UsersProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

/* ------------------------------- NOTE Users ------------------------------- */
  List<User2> _users = [];
  List<User2> get users => _users;


  UsersProvider(){
    User2 u2 = new User2(
      documentID: "1",
      name: "Yosef",
      email: "yosuf.abed@gmail.com",
      isAdmin: true,
      password: "123456");

_users.add(u2);

  }



  Future initState() async {

    User2 u2 = new User2(
      documentID: "1",
      name: "Yosef",
      email: "yosuf.abed@gmail.com",
      isAdmin: true,
      password: "123456");

_users.add(u2);
    
    //var res = await UsersService.streamUsers();
   // res.listen((r) {
    //  _users = r;
    //  notifyListeners();
    //});
  }

  Future updateUser({@required User2 user, @required bool isRegistering}) async {
    //await UsersService.updateUser(user: user, isRegistering: isRegistering);
    print('runinng');
  }

  Future updateUserPassword({User2 user}) async {
    //await UsersService.updateUserPassword(user: user);
  }
}