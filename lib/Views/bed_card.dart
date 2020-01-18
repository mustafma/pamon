import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:hello_world/Model/bed.dart';
import 'package:hello_world/Model/session.dart';
import 'package:hello_world/services/crud.dart';

import 'listview_notifications.dart';

class BedCard extends StatefulWidget {
  final Bed bed;
  String roomId;
  final parentRoomAction;
  CrudMethods crudObj = new CrudMethods();
  BedCard({Key key, @required this.bed, this.parentRoomAction, this.roomId});
  _BedCardState createState() => _BedCardState();
}

enum Status { none, withKatter, forCT, isInficted, fasting }

class _BedCardState extends State<BedCard> {
  bool popMenueBtnEnaled = false;
  bool popMenueBtnEnaled1 = false;
  Color iconTalk1Color = Colors.white;
  Color cardColor = Color.fromRGBO(64, 75, 96, 9);
  int count = 0;

  Color icon1Color = Colors.white;
  Color icon2Color = Colors.white;
  Color icon3Color = Colors.white;
  Color icon4Color = Colors.white;
  Color icon5Color = Colors.white;

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

  @override
  Widget build(BuildContext context) {
    count = this.widget.bed.totalActiveNotifications;
    if (count > 0)
      cardColor = Colors.red;
    else
      cardColor = Color.fromRGBO(64, 75, 96, 9);
      
   // initState();
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
                      color: widget.bed.withCut? Colors.yellow: Colors.white,
                      onPressed: () => alertDialog(
                          context, "החולה עם קטטר", Status.withKatter),
                    ),
                    IconButton(
                      icon: Icon(Icons.explore),
                      iconSize: 30,
                      color: widget.bed.forCT? Colors.yellow: Colors.white,
                       onPressed: () => alertDialog(
                          context, "החולה יעבור CT", Status.forCT),
                    ),
                    IconButton(
                      icon: Icon(Icons.explore),
                      iconSize: 30,
                      color: widget.bed.fasting? Colors.yellow: Colors.white,
                         onPressed: () => alertDialog(
                          context, "החולה צריך להיות בצום ", Status.fasting),
                    ),
                    IconButton(
                      icon: Icon(Icons.explore),
                      iconSize: 30,
                      color: widget.bed.isInfected? Colors.yellow: Colors.white,
                         onPressed: () => alertDialog(
                          context, "החולה עם זיהום ", Status.isInficted),
                    ),
                    IconButton(
                      icon: Icon(Icons.explore),
                      iconSize: 30,
                      color: icon5Color,
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
        Icons.airline_seat_individual_suite,
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
    if (widget.bed.totalActiveNotifications == 0)
      return new PopupMenuButton(
        icon: Icon(
          Icons.add_circle,
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
          badgeContent: Text(widget.bed.totalActiveNotifications.toString(),
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
          child: new PopupMenuButton(
            icon: Icon(
              Icons.add_circle,
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
    if (widget.bed.totalActiveNotifications == 0) {
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

      String text3 = text2 + widget.bed.totalActiveNotifications.toString();
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
      widget.bed.totalActiveNotifications = widget.bed.totalActiveNotifications + 1;
      cardColor = Colors.red;
    });
  }

  @override
  void initState() {
    
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

  void handleIconStatusSelection(Status status, bool highlight) {
    switch (status) {
      case Status.withKatter:
        setState(() {
          if (highlight) {

            icon1Color = Colors.yellow;
          }
          else {
            icon1Color = Colors.white;
          }
        });
        widget.bed.withCut = highlight;
        widget.crudObj.updateBedStatus(widget.roomId, widget.bed.bedId, "withCut", highlight);
        break;
      case Status.forCT:
        setState(() {
          if (highlight)
            icon2Color = Colors.yellow;
          else
            icon2Color = Colors.white;
        });
        widget.bed.forCT = highlight;
        widget.crudObj.updateBedStatus(widget.roomId, widget.bed.bedId, "forCT", highlight);
        break;
      case Status.isInficted:
        setState(() {
          if (highlight)
            icon4Color = Colors.yellow;
          else
            icon4Color = Colors.white;
        });
        widget.bed.isInfected = highlight;
        widget.crudObj.updateBedStatus(widget.roomId, widget.bed.bedId, "isInficted", highlight);
        break;
      case Status.fasting:
        setState(() {
          if (highlight)
            icon3Color = Colors.yellow;
          else
            icon3Color = Colors.white;
        });
        widget.bed.fasting = highlight;
        widget.crudObj.updateBedStatus(widget.roomId, widget.bed.bedId, "fasting", highlight);
        break;
      case Status.none:
        break;
    }
  }

  void alertDialog(BuildContext context, String message, Status status) {
    var alert = new Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: new Text("הודעה",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          content: new Text(message,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          actions: <Widget>[
            new FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
                handleIconStatusSelection(status, true);
              },
              child: new Text("כן",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            new FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
                handleIconStatusSelection(status, false);
              },
              child: new Text("לא",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            )
          ],
        ));
    showDialog(
        context: context,
        builder: (BuildContext c) {
          return alert;
        });
  }
}
