import 'package:flutter/material.dart';
import 'package:BridgeTeam/Views/ui_login.dart';
import 'package:BridgeTeam/locator.dart';

import 'Views/landing_page.dart';
import 'Views/settings_view.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
// create FirebaseMessaging Obj

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          '/SignOut': (context) => LoginWidget(),
          '/Settings': (context) => SettingsWindow(),
        },
        theme: new ThemeData(
            primaryColor: Color.fromRGBO(58, 66, 86, 1.0),
            cardColor: Color.fromRGBO(64, 75, 96, 9),
            popupMenuTheme: new PopupMenuThemeData(
              color: Colors.white,
            ),
            iconTheme: new IconThemeData(
              color: Colors.white,
            )),
        home: Directionality(
          textDirection: TextDirection.rtl,
          child: LandingPage(),
        )

        //home: LoginWidget(),//ListViewRooms(),
        );
  }
}
