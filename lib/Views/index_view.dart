import 'package:BridgeTeam/Model/User.dart';

import 'package:flutter/material.dart';
import 'package:path/path.dart';

import 'appBar.dart';

class IndexView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Dog App',
      home: Scaffold(
        appBar:  BaseAppBar(
        title: Text('Bridge',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20)),
        backButtonVisible: false,
        appBar: AppBar(),
      ),
        body: Container(
          child: DecoratedBox(
            decoration:  new BoxDecoration(
            gradient: new LinearGradient(
                colors: [const Color(0xFF003C64), const Color(0xFF428879)],
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Row(
                    textDirection: TextDirection.rtl,
                    children: <Widget>[
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text("שלום ,",
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                                color: Colors.orange,
                                // fontWeight: FontWeight.bold,
                                fontSize: 35)),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 5.0),
                    child: Row(
                      textDirection: TextDirection.rtl,
                      children: <Widget>[
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Text( User.getInstance().getUserName() == null ? ".":User.getInstance().getUserName(),
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                        ),
                      ], 
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ClipOval(
                          child: Material(
                              color: Colors.purple, // button color
                              child: Stack(
                                children: <Widget>[
                                  InkWell(
                                    splashColor: Colors.orange, // inkwell color
                                    child: SizedBox(
                                        width: 140,
                                        height: 140,
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(
                                                Icons.airline_seat_flat,
                                                color: Colors.white,
                                              ),
                                              Text(
                                                "מחלקה שלי",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14),
                                              )
                                            ])),

                                    onTap: () => goToRooms(context),
                                  ),
                                ],
                              )),
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                            child: ClipOval(
                              child: Material(
                                  color: Colors.blue, // button color
                                  child: Stack(
                                    children: <Widget>[
                                      InkWell(
                                        splashColor:
                                            Colors.orange, // inkwell color
                                        child: SizedBox(
                                            width: 140,
                                            height: 140,
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.note,
                                                    color: Colors.white,
                                                  ),
                                                  Text("משמרות שלי", style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14)),







                                                ])),

                                        onTap: () => takePicture(context),
                                      ),
                                    ],
                                  )),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  goToRooms(BuildContext context) {
  Navigator.pushNamed(context, '/rooms');
  }

    takePicture(BuildContext context) {
  Navigator.pushNamed(context, '/camera');
  }

}
