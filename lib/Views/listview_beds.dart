import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/Model/bed.dart';
import 'package:hello_world/Views/bed_card.dart';

import 'appBar.dart';

class ListViewBeds extends StatefulWidget {
  List<dynamic> beds;
  String roomId;
  final parentAction;
  ListViewBeds(
      {Key key,
      @required this.beds,
      this.parentAction,
      @required this.roomId});

  //ListViewBeds({@required this.beds});
  _ListViewBedsState createState() => _ListViewBedsState();
}

class _ListViewBedsState extends State<ListViewBeds> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var _firestoreRef = Firestore.instance.collection('rooms');

  List<dynamic> _listViewData;

  void _updateRoomCounter() {
    widget.parentAction();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        key: _scaffoldKey,
        appBar: BaseAppBar(
          title: Text('רשימת מיטות'),
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

                    snapshot.data.data['beds'].forEach((bed) => item.add(
                        Bed.fromMap(bed,
                            bed['bedId']))); //map((doc) => Bed.fromMap(doc.data, doc.documentID.toString())).toList();

                    return ListView.builder(
                        itemCount: item.length,
                        itemBuilder: (context, index) {
                          BedCard bedCard = BedCard(
                            bed: item[index],
                            roomId: widget.roomId,
                            parentRoomAction: (_updateRoomCounter),
                            // cardColor:   ((item[index] as Bed).totalActiveNotifications > 0 ) ? Colors.red : Color.fromRGBO(64, 75, 96, 9),
                          );

                          return bedCard;
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

    @override
    void initState() {
      _listViewData = this.widget.beds;
      super.initState();
    }
  }
}
