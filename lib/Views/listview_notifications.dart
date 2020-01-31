import 'package:flutter/material.dart';
import 'package:hello_world/Model/bed.dart';
import 'package:hello_world/Model/repository.dart';

import 'appBar.dart';
import 'notification_card.dart';

class ListViewInstructions extends StatefulWidget {
  List<dynamic> bedInstructions;
  final String roomId;
  ListViewInstructions({Key key, @required this.bedInstructions, this.roomId});

  _ListViewInstructionsState createState() => _ListViewInstructionsState();
}

class _ListViewInstructionsState extends State<ListViewInstructions> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Repository repository = new Repository();
  List<dynamic> _listViewData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color.fromRGBO(58,66,86,1.0),
        key: _scaffoldKey,
        appBar: BaseAppBar(
          title: Text('רשימת ההוראות' , textDirection:TextDirection.rtl),
          appBar: AppBar(),
        ),
        body: Center(
            child: ListView.builder(
                itemCount: _listViewData.length,
                itemBuilder: (context, index) {
                  NotificationCard notificationCard = NotificationCard(
                    bedInstruction: _listViewData[index],
                    roomId: widget.roomId,
                  );
                  return notificationCard;
                })),
                 bottomNavigationBar: BottomAppBar(
            color: Color.fromRGBO(64, 75, 96, 9),
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
                              fontSize: 18)))
                ],
              ),
            )));
  }

  @override
  void initState() {
    _listViewData = this.widget.bedInstructions;
    super.initState();
  }
}
