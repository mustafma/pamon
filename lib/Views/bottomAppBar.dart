import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:flutter/material.dart';

class BaseBottomBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor = Colors.blue;

  // final BottomBar bottomBar;

  BaseBottomBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        color: const Color(0xFF144464),  //Color.fromRGBO(97, 138, 179, 9) ,//Color.fromRGBO(64, 75, 96, 9),
        child: new Container(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Text("Powered  By Adamtec",
                    style: TextStyle(
                        color: Colors.white38,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
              ),
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            elevation: 16,
                            child: Container(
                              height: 100.0,
                              width: 150.0,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(" ?איך עברה עליך המשמרת",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:MainAxisAlignment.center,
                                      children: <Widget>[
                                        IconButton(
                                          icon: Icon(Icons.explore),
                                          color: Colors.red,
                                          onPressed: () {},
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.explore),
                                          color: Colors.green,
                                          onPressed: () {},
                                        ),
                                            IconButton(
                                          icon: Icon(Icons.explore),
                                          color: Colors.yellow,
                                          onPressed: () {},
                                        ),
                                      ],
                                    )
                                  ]),
                            ));
                      });
                },
              )
            ],
          ),
        ));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => null;
}
