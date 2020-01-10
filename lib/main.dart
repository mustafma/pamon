import 'package:flutter/material.dart';
import 'package:hello_world/Views/ui_login.dart';
import 'Views/landing_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          '/SignOut': (context) => LoginWidget(),
        },
        theme: new ThemeData(
          primaryColor: Color.fromRGBO(58, 66, 86, 1.0)
          ),
        home: Directionality(
          textDirection: TextDirection.rtl,
          child: LandingPage(),
        )

        //home: LoginWidget(),//ListViewRooms(),
        );
  }
}
