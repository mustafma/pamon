import 'package:BridgeTeam/Components/page_header.dart';
import 'package:BridgeTeam/Views/UserItem.dart';
import 'package:BridgeTeam/Views/user_details_page.dart';
import 'package:BridgeTeam/model_providers/users_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'appBar.dart';

class UsersDashboardPage extends StatefulWidget {
  UsersDashboardPage({Key key}) : super(key: key);

  @override
  _UsersDashboardPageState createState() => _UsersDashboardPageState();
}

class _UsersDashboardPageState extends State<UsersDashboardPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final usersProvider =
        new UsersProvider(); //Provider.of<UsersProvider>(context);
    return Scaffold(
      appBar: BaseAppBar(
        title: Text('ניהול משתמשים',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
            textDirection: TextDirection.rtl),
        backButtonVisible: true,
        appBar: AppBar(),
      ),
      body: Container(
        decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [const Color(0xFF003C64), const Color(0xFF428879)],
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp)),
        child: ListView(
          children: <Widget>[
            Center(child: PageHeader(
              title: 'רשימת משתמשים',
            ),
            
            ),
            
            for (int i = 0; i < usersProvider.users.length; i++)
              UserItem(
                user: usersProvider.users[i],
              ),
          ],
        ),
      ),
      floatingActionButton: Container(
        
        margin: EdgeInsets.only(bottom: 10),
        child: FloatingActionButton.extended(
          backgroundColor: Colors.orange,
            onPressed: () {
              Navigator.of(context).push(
                new MaterialPageRoute<Null>(
                    builder: (BuildContext context) {
                      return UserDetailsPage();
                    },
                    fullscreenDialog: true),
              );
            },
            icon: Icon(
              Icons.add,
            ),
            label: Text("User")),
      ),
    );
  }
}
