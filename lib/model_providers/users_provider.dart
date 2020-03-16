import 'package:BridgeTeam/Model/User.dart';
import 'package:BridgeTeam/services/crud.dart';
import 'package:flutter/material.dart';

//import '../models_services/users_services.dart';

class UsersProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

/* ------------------------------- NOTE Users ------------------------------- */
  List<User> _users = [];
  List<User> get users => _users;


  UsersProvider()  {
    updateUSersList().then((value) => _users = List.from(value));
    /*usersList.then((value) =>
    _users = List.from(value)
    );*/


  }



  Future initState() async {
    var crud = new CrudMethods();

    var usersList = crud.getUsers("001", "001");
    usersList.then((value) =>_users = List.from(value));
    
    //var res = await UsersService.streamUsers();
   // res.listen((r) {
    //  _users = r;
    //  notifyListeners();
    //});
  }

  Future updateUser({@required User user, @required bool isRegistering}) async {
    //await UsersService.updateUser(user: user, isRegistering: isRegistering);
    print('runinng');
  }

  Future updateUserPassword({User user}) async {
    //await UsersService.updateUserPassword(user: user);
  }

  Future<List<User>> updateUSersList() async
  {

    var crud = new CrudMethods();
    return await crud.getUsers("001", "001");
  }
}