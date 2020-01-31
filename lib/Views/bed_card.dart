import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:hello_world/Model/User.dart';
import 'package:hello_world/Model/bed.dart';
import 'package:hello_world/Model/enumTypes.dart';
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
  bool allowedForBedStatus = false;
  bool allowedaddingInstruction = false;

  Color icon1Color = Colors.white;
  Color icon2Color = Colors.white;
  Color icon3Color = Colors.white;
  Color icon4Color = Colors.white;
  Color icon5Color = Colors.white;
  IconData bedIconBystatus = Icons.airline_seat_individual_suite;

  List<PopupMenuEntry<InstructionType>> _listOfType = [
    new PopupMenuItem<InstructionType>(
      value: InstructionType.IVP,
      child: ListTile(
        trailing: Icon(
          Icons.filter_1,
          color: Color.fromRGBO(64, 75, 96, 9),
        ),
        title: Text('הוראה סוג א'),
      ),
    ),
    new PopupMenuItem<InstructionType>(
      value: InstructionType.XX,
      child: ListTile(
        trailing: Icon(
          Icons.filter_2,
          color: Color.fromRGBO(64, 75, 96, 9),
        ),
        title: Text('הוראה סוג ב'),
      ),
    ),
    new PopupMenuItem<InstructionType>(
      value: InstructionType.YY,
      child: ListTile(
        trailing: Icon(
          Icons.filter_3,
          color: Color.fromRGBO(64, 75, 96, 9),
        ),
        title: Text('הוראה סוג ג'),
      ),
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
      cardColor = Theme.of(context).cardColor;

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
                      color: widget.bed.withCut ? Colors.yellow : Colors.white,
                      onPressed: () => alertDialog(
                          context, "החולה עם קטטר", Status.withKatter),
                    ),
                    IconButton(
                      icon: Icon(Icons.explore),
                      iconSize: 30,
                      color: widget.bed.forCT ? Colors.yellow : Colors.white,
                      onPressed: () =>
                          alertDialog(context, "החולה יעבור CT", Status.forCT),
                    ),
                    IconButton(
                      icon: Icon(Icons.explore),
                      iconSize: 30,
                      color: widget.bed.fasting ? Colors.yellow : Colors.white,
                      onPressed: () => alertDialog(
                          context, "החולה צריך להיות בצום ", Status.fasting),
                    ),
                    IconButton(
                      icon: Icon(Icons.explore),
                      iconSize: 30,
                      color:
                          widget.bed.isInfected ? Colors.yellow : Colors.white,
                      onPressed: () => alertDialog(
                          context, "החולה עם זיהום ", Status.isInficted),
                    )
                  ],
                ),
              )
            ])));
  }

  Widget buildLeading() {
    if (allowedForBedStatus) {
      return new PopupMenuButton(
        color: Theme.of(context).popupMenuTheme.color,
        icon: Icon(
          bedIconBystatus,
          color: Colors.white,
        ),
        // enabled: popMenueBtnEnaled1,
        onSelected: (value) => _selectBedStatus(value),
        itemBuilder: (BuildContext context) {
          return _listOfBedStatuses;
        },
      );
    }
    return null;
  }

  Widget buildTrial() {
    if (allowedaddingInstruction) {
      if (widget.bed.totalActiveNotifications == 0)
        return new PopupMenuButton(
          color: Theme.of(context).popupMenuTheme.color,
          icon: Icon(
            Icons.add_circle,
            color: Colors.white,
          ),
          //enabled: popMenueBtnEnaled,
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
              //enabled: popMenueBtnEnaled,
              onSelected: (value) => _select(value),
              itemBuilder: (BuildContext context) {
                return _listOfType;
              },
            ));
    } else {
      return Badge(
        badgeColor: Colors.orange,
        badgeContent: Text(widget.bed.totalActiveNotifications.toString(),
            style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold)),
      );
    }
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

  void _select(InstructionType choice) {
    addInstruction(choice);
  }

  void _selectBedStatus(int choice) {
    if (User.getInstance().loggedInUserType == UserType.Nurse ||
        User.getInstance().loggedInUserType == UserType.NurseShiftManager)
      switch (choice) {
        case 1:
          widget.crudObj.cleanBed(widget.roomId, widget.bed.bedId);
          setState(() {
            bedIconBystatus = Icons.airline_seat_legroom_reduced;
          });

          break;
        case 2:
          setState(() {
            bedIconBystatus = Icons.airline_seat_recline_normal;
          });
          break;
        case 3:
          setState(() {
            bedIconBystatus = Icons.airline_seat_flat_angled;
          });
          break;
          break;
      }
  }

  void addInstruction(InstructionType choice) {
    // Call Service to update DB  and Push  Notification
    String choiceText = choice.toString().split('.').last;
    widget.crudObj.addInstruction(
        widget.roomId, widget.bed.bedId, choice.index, choiceText);

    widget.parentRoomAction();
    setState(() {
      widget.bed.totalActiveNotifications =
          widget.bed.totalActiveNotifications + 1;
      cardColor = Colors.red;
    });
  }

  @override
  void initState() {
    if (User.getInstance().loggedInUserType == UserType.Doctor ||
        User.getInstance().loggedInUserType == UserType.DepartmentManager) {
      allowedaddingInstruction = true;
      allowedForBedStatus = false;
    }

    if (User.getInstance().loggedInUserType == UserType.Nurse ||
        User.getInstance().loggedInUserType == UserType.NurseShiftManager) {
      allowedaddingInstruction = false;
      allowedForBedStatus = true;
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
                  roomId: widget.roomId,
                  bedId: widget.bed.bedId,
                )));
  }

  void handleIconStatusSelection(Status status, bool highlight) {
    switch (status) {
      case Status.withKatter:
        setState(() {
          if (highlight) {
            icon1Color = Colors.yellow;
          } else {
            icon1Color = Colors.white;
          }
        });
        widget.bed.withCut = highlight;
        //widget.crudObj.moveBed("002",widget.roomId, widget.bed.bedId);
        widget.crudObj.updateBedStatus(
            widget.roomId, widget.bed.bedId, "withCut", highlight);
        break;
      case Status.forCT:
        setState(() {
          if (highlight)
            icon2Color = Colors.yellow;
          else
            icon2Color = Theme.of(context).iconTheme.color;
        });
        widget.bed.forCT = highlight;
        widget.crudObj.updateBedStatus(
            widget.roomId, widget.bed.bedId, "forCT", highlight);
        break;
      case Status.isInficted:
        setState(() {
          if (highlight)
            icon4Color = Colors.yellow;
          else
            icon4Color = Theme.of(context).iconTheme.color;
        });
        widget.bed.isInfected = highlight;
        widget.crudObj.updateBedStatus(
            widget.roomId, widget.bed.bedId, "isInficted", highlight);
        break;
      case Status.fasting:
        setState(() {
          if (highlight)
            icon3Color = Colors.yellow;
          else
            icon3Color = Theme.of(context).iconTheme.color;
        });
        widget.bed.fasting = highlight;
        widget.crudObj.updateBedStatus(
            widget.roomId, widget.bed.bedId, "fasting", highlight);
        break;
      case Status.none:
        break;
    }
  }

  bool getCurrentBedStatus(Status status) {
    bool res = false;
    switch (status) {
      case Status.fasting:
        res = widget.bed.fasting;
        break;
      case Status.forCT:
        res = widget.bed.forCT;
        break;
      case Status.isInficted:
        res = widget.bed.isInfected;
        break;
      case Status.withKatter:
        res = widget.bed.withCut;
        break;
      case Status.none:
        res = false;
        break;
    }
    return res;
  }

  void alertDialog(BuildContext context, String message, Status status) {
    bool isSwitched = getCurrentBedStatus(status);
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
            new Switch(
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                });
              },
            ),
            new FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
                handleIconStatusSelection(status, isSwitched);
              },
              child: new Text("סגור",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ],
        ));
    showDialog(
        context: context,
        builder: (BuildContext c) {
          return alert;
        });
  }
}
