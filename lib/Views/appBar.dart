import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
        trailing: Icon(
          Icons.person,
          color: Color.fromRGBO(64, 75, 96, 9),
        ),
        title: Text('פרופיל'),
      ),
    ),
    new PopupMenuItem<int>(
      value: 2,
      child: ListTile(
        trailing: Icon(
          // icon: Icon(
          Icons.settings,
          color: Color.fromRGBO(64, 75, 96, 9),
          //  ),
          // onPressed: () {},
        ),
        title: Text('הגדרות'),
      ),
    ),
    new PopupMenuItem<int>(
      value: 3,
      child: ListTile(
        trailing: Icon(
          // icon: Icon(
          Icons.exit_to_app,
          color: Color.fromRGBO(64, 75, 96, 9),
          // ),
        ),
        title: Text('יציאה'),
        //  onTap: ()  async {
        //   await _handleSignout();

        // },
      ),
      //child: Text('יציאה'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: AppBar(
          elevation: 0.1,
          title: Center(child: title),
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          actions: <Widget>[
            new PopupMenuButton(
              initialValue: 1,
              icon: Icon(Icons.list),
              itemBuilder: (BuildContext context) {
                return _listOfType;
              },
              onSelected: (selection) {
                switch (selection) {
                  case 3:
                    _handleSignout(context);
                    break;
                }
              },
            ),
          ]),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}

Future _handleSignout(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.pushNamed(context, '/SignOut');
  //return LoginWidget();
}
