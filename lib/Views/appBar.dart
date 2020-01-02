import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/Views/ui_login.dart';
import 'package:hello_world/services/auth.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor = Colors.blue;
  final Text title;
  final AppBar appBar;
  final AuthService _auth = AuthService();
  BaseAppBar({Key key, this.title, this.appBar}) : super(key: key);

  final List<PopupMenuEntry<int>> _listOfType = [
    new PopupMenuItem<int>(
      value: 1,
      child: ListTile(
        leading: IconButton(
          icon: Icon(
            Icons.person,
            color: Colors.blue,
          ),
          onPressed: () {},
        ),
        title: Text('פרופיל'),
      ),
    ),
    new PopupMenuItem<int>(
      value: 2,
      child: ListTile(
        leading: IconButton(
          icon: Icon(
            Icons.settings,
            color: Colors.blue,
          ),
          onPressed: () {},
        ),
        title: Text('הגדרות'),
      ),
    ),
    new PopupMenuItem<int>(
      value: 3,
      child: ListTile(
        leading: IconButton(
          icon: Icon(
            Icons.exit_to_app,
            color: Colors.blue,
          ),
          onPressed: () {_handleSignout();},

        ),
        title: Text('יציאה'),
      ),
      //child: Text('יציאה'),
    ),

  ];

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text("pamon"),
        backgroundColor: backgroundColor,
        actions: <Widget>[
          new PopupMenuButton(itemBuilder: (BuildContext context) {
            return _listOfType;
          }),
        ]);
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);



}


Future<LoginWidget> _handleSignout() async{
  await FirebaseAuth.instance.signOut();
  return new LoginWidget();

}