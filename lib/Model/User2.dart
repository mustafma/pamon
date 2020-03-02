import 'package:BridgeTeam/Model/enumTypes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User2 {
  String email;
  String name;
  String password;
  UserType userType;
  bool isInMashmert;

  bool isAdmin;

  User2({
    this.email,
    this.isAdmin,
    this.name,
    this.password,
    this.isInMashmert,
    this.userType
  });

  factory User2.fromFirestore(DocumentSnapshot document) {
    Map data = document.data;

    return User2(
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      isAdmin: data['isAdmin'] ?? false,
      userType: UserType.values.firstWhere((e)=> e.toString() ==  data['userType'] ?? "nr"),
      isInMashmert: data['inShift'] ?? false,
    );
  }
}