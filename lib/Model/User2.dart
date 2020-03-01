import 'package:cloud_firestore/cloud_firestore.dart';

class User2 {
  String documentID;
  String email;
  String name;
  String password;

  bool isAdmin;

  User2({
    this.documentID,
    this.email,
    this.isAdmin,
    this.name,
    this.password,
  });

  factory User2.fromFirestore(DocumentSnapshot document) {
    Map data = document.data;

    return User2(
      documentID: document.documentID,
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      isAdmin: data['isAdmin'] ?? false,
    );
  }
}