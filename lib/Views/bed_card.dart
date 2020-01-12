import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:hello_world/Model/bed.dart';
import 'package:hello_world/Model/session.dart';

import 'listview_notifications.dart';

class BedCard extends StatefulWidget {
  final Bed bed;
  final parentRoomAction;

  BedCard({Key key, @required this.bed, this.parentRoomAction});

  _BedCardState createState() => _BedCardState();
}

class _BedCardState extends State<BedCard> {
  bool popMenueBtnEnaled = false;
  bool popMenueBtnEnaled1 = false;
  Color iconTalk1Color = Colors.white;

  List<PopupMenuEntry<int>> _listOfType = [
    new PopupMenuItem<int>(
      value: 1,
      child: Text('הוראה סוג 1'),
    ),
    new PopupMenuItem<int>(
      value: 2,
      child: Text('הוראה סוג 2'),
    ),
    new PopupMenuItem<int>(
      value: 3,
      child: Text('הוראה סוג 3'),
    ),
  ];

  List<PopupMenuEntry<int>> _listOfBedStatuses = [
    new PopupMenuItem<int>(
      value: 1,
      child: Text('מיטה פנוייה'),
    ),
    new PopupMenuItem<int>(
      value: 2,
      child: Text('מיטה לשחרור'),
    ),
    new PopupMenuItem<int>(
      value: 3,
      child: Text('מיטה עם זיהום'),
    ),
  ];

  Color cardColor = Color.fromRGBO(64, 75, 96, 9);
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 135,
        child: Card(
            elevation: 8.0,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: Column(children: <Widget>[
              Container(
                  decoration: BoxDecoration(color: cardColor),
                  child: ListTile(
                    leading: buildLeading(),
                    title: Center(
                      child: Text(widget.bed.name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                    ),
                    subtitle: buildSubTrial(),
                    trailing: buildTrial(),
                    onTap: () => onTapBrowseToBedInstructions(context),
                  )),
              Container(
                decoration: BoxDecoration(
                    color: cardColor,
                    border: new Border(
                        top: new BorderSide(width: 3.0, color: Colors.orange))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.explore),
                      iconSize: 30,
                      color: iconTalk1Color,
                      onPressed: () => {},
                    ),
                    IconButton(
                      icon: Icon(Icons.explore),
                      iconSize: 30,
                      color: iconTalk1Color,
                      onPressed: () => {},
                    ),
                    IconButton(
                      icon: Icon(Icons.explore),
                      iconSize: 30,
                      color: iconTalk1Color,
                      onPressed: () => {},
                    ),
                    IconButton(
                      icon: Icon(Icons.explore),
                      iconSize: 30,
                      color: iconTalk1Color,
                      onPressed: () => {},
                    ),
                    IconButton(
                      icon: Icon(Icons.explore),
                      iconSize: 30,
                      color: iconTalk1Color,
                      onPressed: () => {},
                    )
                  ],
                ),
              )
            ])));
  }

  Widget buildLeading() {
    return new PopupMenuButton(
      icon: Icon(
        Icons.security,
        color: Colors.white,
      ),
      enabled: popMenueBtnEnaled1,
      onSelected: (value) => _selectBedStatus(value),
      itemBuilder: (BuildContext context) {
        return _listOfBedStatuses;
      },
    );
  }

  Widget buildTrial() {
    if (count == 0)
      return new PopupMenuButton(
        icon: Icon(
          Icons.notifications,
          color: Colors.white,
        ),
        enabled: popMenueBtnEnaled,
        onSelected: (value) => _select(value),
        itemBuilder: (BuildContext context) {
          return _listOfType;
        },
      );
    else
      return Badge(
          badgeColor: Colors.orange,
          badgeContent: Text("$count",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
          child: new PopupMenuButton(
            icon: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            color: Colors.white,
            enabled: popMenueBtnEnaled,
            onSelected: (value) => _select(value),
            itemBuilder: (BuildContext context) {
              return _listOfType;
            },
          ));
  }

  Widget buildSubTrial() {
    if (count == 0) {
      return new Center(
          child: new Text(
        "אין הוראות חדשות",
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        overflow: TextOverflow.fade,
        maxLines: 1,
        softWrap: true,
      ));
    } else {
      String text2 = "הוראות שלא בוצעו ";

      String text3 = text2 + "$count";
      return new Center(
          child: new Text(
        text3,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        overflow: TextOverflow.visible,
        maxLines: 1,
        softWrap: false,
      ));
    }
  }

  void _select(int choice) {
    increamentCounter();
  }

  void _selectBedStatus(int choice) {}
  void increamentCounter() {
    // Call Service to update DB  and Push  Notification
    widget.parentRoomAction();
    setState(() {
      count = count + 1;
      this.widget.bed.totalActiveNotifications = count;
      cardColor = Colors.red;
    });
  }

  @override
  void initState() {
    count = this.widget.bed.totalActiveNotifications;
    if (count > 0)
      cardColor = Colors.red;
    else
      cardColor = Color.fromRGBO(64, 75, 96, 9);
    if (Session.instance().iSNursePermessions) {
      popMenueBtnEnaled = false;
      popMenueBtnEnaled1 = true;
    } else {
      popMenueBtnEnaled = true;
      popMenueBtnEnaled1 = false;
    }

    super.initState();
  }

  void onTapBrowseToBedInstructions(BuildContext context) {
    // navigate to the next screen.
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ListViewInstructions(
                  bedInstructions: widget.bed.notifications,
                )));
  }
}
