

import 'package:BridgeTeam/Model/User.dart';
import 'package:BridgeTeam/Views/listview_rooms.dart';
import 'package:BridgeTeam/Views/shiftview.dart';
import 'package:flutter/material.dart';
import 'package:BridgeTeam/Views/ui_login.dart';
import 'package:BridgeTeam/locator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'Views/Survey/survey.ui.dart';
import 'Views/UserDashboard.dart';
import 'Views/instanseMessage.dart';
import 'Views/landing_page.dart';
import 'Views/settings_view.dart';


import 'dart:async';

import 'package:camera/camera.dart';
import 'Views/takepicture.dart';




Future<void> main() async {


    setupLocator();
     WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
 // final firstCamera = cameras.first;


  runApp(MyApp(firstCamera: cameras.first,));

}


/*void main() {
  setupLocator();
  runApp(MyApp());
}*/

class MyApp extends StatelessWidget {
// create FirebaseMessaging Obj
final firstCamera;
 MyApp(
      {
      @required this.firstCamera
      });
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => User.getInstance(),
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: [
           Locale('he', 'IL'),
        ],
        locale:  Locale('he', 'IL'),
        routes: {
          '/SignOut': (context) => LoginWidget(),
          '/Settings': (context) => SettingsWindow(),
          '/IM': (context) => InstanceMessage(),
          '/UserMng': (context) => UsersDashboardPage(),
          '/ShiftMng':(context) => ShiftView(),
          '/rooms':(context) => ListViewRooms(),
          '/camera':(context) => TakePictureScreen(camera: firstCamera),
           '/Pic':(context) => DisplayPictureScreen(imagePath: "",),
          '/ZZZ':(context) => SurveyUi(),
        },
        theme: new ThemeData(
          //  primaryColor: Color.fromRGBO(58, 66, 86, 1.0),
           // cardColor: Color.fromRGBO(64, 75, 96, 9),
             primaryColor: Color.fromRGBO(200, 201, 202, 1.0),
            cardColor:  const Color(0xFFA1BBCD) ,    //Colors(const [0xFF546C7D])        // Colors.red,//Color.fromRGBO(134, 165, 195, 9),
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
        ) ,
    
    );
  }
}
