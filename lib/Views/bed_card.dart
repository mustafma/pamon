import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:hello_world/Model/bed.dart';
import 'package:hello_world/Model/session.dart';
import 'package:hello_world/services/auth.dart';

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

  Color cardColor;
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Card(
        //
        color: cardColor,
        child: ListTile(
          leading: buildLeading(),
          title: Center(
            child: Text(widget.bed.name),
          ),
          subtitle: buildSubTrial(),
          trailing: buildTrial(),
          onTap: () => onTapBrowseToBedInstructions(context),
        ));
  }

  Widget buildLeading() {
    return new PopupMenuButton(
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
        enabled: popMenueBtnEnaled,
        onSelected: (value) => _select(value),
        itemBuilder: (BuildContext context) {
          return _listOfType;
        },
      );
    else
      return Badge(
          badgeColor: Colors.yellow,
          badgeContent: Text("$count",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
          child: new PopupMenuButton(
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
            color: Colors.green, fontWeight: FontWeight.bold, fontSize: 18),
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
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
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
      cardColor = Colors.red.withOpacity(0.9);
    });
  }

  @override
  void initState() {
    count = this.widget.bed.totalActiveNotifications;
    if (count > 0)
      cardColor = Colors.red.withOpacity(0.9);
    else
      cardColor = Colors.white;
    if (session.instance().iSNursePermessions) {
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
