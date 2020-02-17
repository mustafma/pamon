import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:BridgeTeam/Model/bed.dart';
import 'package:BridgeTeam/Views/bed_card.dart';

import 'appBar.dart';
import 'bottomAppBar.dart';

class ListViewBeds extends StatefulWidget {
  List<dynamic> beds;
  String roomId;
  final parentAction;
  List rooms = [];
  ListViewBeds(
      {Key key,
      @required this.beds,
      this.parentAction,
      @required this.roomId,
      this.rooms});

  //ListViewBeds({@required this.beds});
  _ListViewBedsState createState() => _ListViewBedsState();
}

class _ListViewBedsState extends State<ListViewBeds> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var _firestoreRef = Firestore.instance.collection('rooms');

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

                    item.sort((a,b)=> ((a as Bed).bedId).compareTo((b as Bed).bedId));

                    return ListView.builder(
                        itemCount: item.length,
                        itemBuilder: (context, index) {
                          BedCard bedCard = BedCard(
                            bed: item[index],
                            roomId: widget.roomId,
                            rooms: widget.rooms,
                            parentRoomAction: (_updateRoomCounter),
                            // cardColor:   ((item[index] as Bed).totalActiveNotifications > 0 ) ? Colors.red : Color.fromRGBO(64, 75, 96, 9),
                          );

                          return bedCard;
                        });
                  }
                })),
        bottomNavigationBar: BaseBottomBar());
  }
}
