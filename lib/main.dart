import 'package:flutter/material.dart';
import 'Views/landing_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Directionality(
      textDirection: TextDirection.rtl,
      child: LandingPage(),
    )

        //home: LoginWidget(),//ListViewRooms(),
        );
  }
}
