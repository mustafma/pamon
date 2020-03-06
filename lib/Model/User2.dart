import 'package:BridgeTeam/Model/enumTypes.dart';


class User2 {
  String hospitalId;
  String departmentId;
  String documentID;
  String email;
  String name;
  String password;
  String title;
  String role;
  String uid;
  bool isInShift;
  bool isAdmin;
  UserType userole;


  User2({
    this.email,
    this.hospitalId,
    this.departmentId,
    this.isAdmin,
    this.name,
    this.password,
    this.uid,
    this.role,
    this.title,
    this.isInShift,

  });


  User2.fromMap(Map snapshot, String id):

     // documentID =  id,
      uid =  snapshot['uid'],
      title =  snapshot['title'],
      role =  snapshot['role'],
      isInShift =  snapshot['isInShift'] ?? false,
      email =  snapshot['email'] ?? '',
      password =  snapshot['password'] ?? '',
      name =  snapshot['name'] ?? '',
      isAdmin =  snapshot['isAdmin'] ?? false,
      hospitalId = snapshot['hospitalId'] ?? '',
      departmentId = snapshot['departmentId'] ?? '';



}
