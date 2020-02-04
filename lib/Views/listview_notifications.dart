import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:BridgeTeam/Model/bed.dart';
import 'package:BridgeTeam/Model/repository.dart';

import 'appBar.dart';
import 'notification_card.dart';

class ListViewInstructions extends StatefulWidget {
  List<dynamic> bedInstructions;
  final String roomId;
  final String bedId;
  ListViewInstructions(
      {Key key, @required this.bedInstructions, this.roomId, this.bedId});

  _ListViewInstructionsState createState() => _ListViewInstructionsState();
}

class _ListViewInstructionsState extends State<ListViewInstructions> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var _firestoreRef = Firestore.instance.collection('rooms');

  Repository repository = new Repository();
  List<dynamic> _listViewData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        key: _scaffoldKey,
        appBar: BaseAppBar(
          title: Text('רשימת ההוראות', textDirection: TextDirection.rtl),
          appBar: AppBar(),
        ),
        body: Center(
            child: StreamBuilder(
                stream: _firestoreRef.document(widget.roomId).snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return LinearProgressIndicator();
                  } else {
                    List item = [];

                    snapshot.data.data['beds'].forEach((bed) => {
                          if (bed['bedId'].toString() == widget.bedId)
                            {
                              item = bed['notifications']
                                  .map((map) => new BedInstruction.fromMap(
                                      map, map['notificationId']))
                                  .toList()
                            }
                        });

                    //map((doc) => Bed.fromMap(doc.data, doc.documentID.toString())).toList();

                    return ListView.builder(
                        itemCount: item.length,
                        itemBuilder: (context, index) {
                          NotificationCard instrCard = NotificationCard(
                              bedInstruction: item[index],
                              roomId: widget.roomId,
                              bedId: widget.bedId);

                          return instrCard;
                        });
                  }
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
