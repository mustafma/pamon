import 'package:flutter/material.dart';
import 'package:hello_world/Views/ui_login.dart';
import 'Views/landing_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(

        
        title: 'Pamon App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      home: LandingPage(),//home: LoginWidget(),//ListViewRooms(),
        );
  }
}




