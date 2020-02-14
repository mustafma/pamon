import 'package:BridgeTeam/Model/room.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:BridgeTeam/Model/PopupMenuEntries.dart';
import 'package:BridgeTeam/Model/User.dart';
import 'package:BridgeTeam/Model/bed.dart';
import 'package:BridgeTeam/Model/enumTypes.dart';
import 'package:BridgeTeam/services/crud.dart';

import 'Dialogs/GeneralDialogs.dart';
import 'listview_notifications.dart';

class BedCard extends StatefulWidget {
  final Bed bed;
  String roomId;
  final parentRoomAction;
  final List rooms;
  CrudMethods crudObj = new CrudMethods();
  BedCard({Key key, @required this.bed, this.parentRoomAction, this.roomId, this.rooms});
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
  String _selectedRoomNumber;
  //List rooms =  widget.rooms;
  List<PopupMenuEntry<InstructionType>> _listOfType = [
    new PopupMenuItem<InstructionType>(
      value: InstructionType.IV,
      child: ListTile(
        trailing: Icon(
          Icons.filter_1,
          color: Color.fromRGBO(64, 75, 96, 9),
        ),
        title: Text('I.V מתן עירוי תרופה/נוזל'),
      ),
    ),
    new PopupMenuItem<InstructionType>(
      value: InstructionType.PO,
      child: ListTile(
        trailing: Icon(
          Icons.filter_2,
          color: Color.fromRGBO(64, 75, 96, 9),
        ),
        title: Text('P.O מתו תרופה מיוחדת'),
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    count = this.widget.bed.getNumberOfActiveNotifications();
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
                      
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          if(widget.bed.dismissed)
                          new Icon(
                            Icons.exit_to_app,
                            color: Colors.green,
                          ),
                          new Padding(padding: EdgeInsets.all(10.0)),
                          Text(widget.bed.name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    subtitle: buildSubTrial(),
                    trailing: buildTrial(),
                    onTap: () => onTapBrowseToBedInstructions(context),
                    onLongPress: () => moveBed(context),
                  )),
              Container(
                decoration: BoxDecoration(
                    color: cardColor,
                    border: new Border(
                        top: new BorderSide(width: 3.0, color: Colors.orange))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: generateListOfIcons()),
                    new Spacer(),
                    Container(
                      // margin: EdgeInsets.only(left: 310),

                      child: PopupMenuButton(
                        color: Theme.of(context).popupMenuTheme.color,
                        icon: Icon(
                          Icons.list,
                          color: Colors.white,
                        ),
                        // enabled: popMenueBtnEnaled1,
                        onSelected: (value) =>
                            handleIconStatusSelection2(value, context),
                        itemBuilder: (BuildContext context) {
                          return PamonMenus.BedStatuses;
                        },
                      ),
                    ),
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
        onSelected: (value) => _selectBedStatus(value, context),
        itemBuilder: (BuildContext context) {
          return PamonMenus.BedActions;
        },
      );
    }
    return null;
  }

  Widget buildTrial() {
    if (allowedaddingInstruction) {
      if (widget.bed.getNumberOfActiveNotifications() == 0)
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
            badgeContent: Text(
                widget.bed.getNumberOfActiveNotifications().toString(),
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
        badgeContent: Text(
            widget.bed.getNumberOfActiveNotifications().toString(),
            style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold)),
      );
    }
  }

  Widget buildSubTrial() {
    if (widget.bed.getNumberOfActiveNotifications() == 0) {
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

      String text3 =
          text2 + widget.bed.getNumberOfActiveNotifications().toString();
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

  void _selectBedStatus(BedAction choice, BuildContext context) {
    if (User.getInstance().loggedInUserType == UserType.Nurse ||
        User.getInstance().loggedInUserType == UserType.NurseShiftManager)
      switch (choice) {
        case BedAction.Clean:
          showDialog(
              context: context,
              builder: (context) {
                return new CustomDialog(
                  text: "לנקות מיטה",
                  handleYesButton:
                      widget.crudObj.cleanBed(widget.roomId, widget.bed.bedId),
                  handleNoButton: () => {},
                );
              });

          //setState(() {
          // bedIconBystatus = Icons.airline_seat_legroom_reduced;
          //});

          break;
        case BedAction.Move:
          showDialog(
              context: context,
              builder: (context) {
                return moveBed(context);
              });

          //setState(() {
          //  bedIconBystatus = Icons.airline_seat_recline_normal;
          //});
          break;
        case BedAction.Swap:
          //setState(() {
          //   bedIconBystatus = Icons.airline_seat_flat_angled;
          // });
          break;
        case BedAction.Release:
          showDialog(
              context: context,
              builder: (context) {
                return new CustomDialog(
                  text: "החולה לשחרור",
                  handleYesButton:()=>{widget.crudObj.updateBedStatus(
                      widget.roomId, widget.bed.bedId, "dismissed", true)
                  },
                  handleNoButton: widget.crudObj.updateBedStatus(
                      widget.roomId, widget.bed.bedId, "dismissed", false),
                );
              });
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
      /*
      widget.bed.totalActiveNotifications =
          widget.bed.totalActiveNotifications + 1;*/
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

  void handleIconStatusSelection2(BedStatus status, BuildContext context) async {
    bool highlight = true;
    switch (status) {
      case BedStatus.Cateter:
         widget.bed.Cateter = true;
        await _selectDate(context);
        widget.crudObj.updateBedStatus(
            widget.roomId, widget.bed.bedId, "withCut", highlight);
       // widget.crudObj.updateBedDateField(
         //   widget.roomId, widget.bed.bedId, "CatDate", widget.bed.CatDate);
        break;
      case BedStatus.CT:
        widget.bed.CT = highlight;
        widget.crudObj.updateBedStatus(
            widget.roomId, widget.bed.bedId, "forCT", highlight);
        break;
      case BedStatus.Infected:
        widget.bed.Infected = highlight;
        widget.crudObj.updateBedStatus(
            widget.roomId, widget.bed.bedId, "isInficted", highlight);
        break;
      case BedStatus.Fasting:
        widget.bed.Fasting = highlight;
        widget.crudObj.updateBedStatus(
            widget.roomId, widget.bed.bedId, "fasting", highlight);
        break;
      case BedStatus.PhysoAid:
        widget.bed.PhysoAid = highlight;
        widget.crudObj.updateBedStatus(
            widget.roomId, widget.bed.bedId, "PhysoAid", highlight);
        break;
      case BedStatus.SocialAid:
        widget.bed.SocialAid = highlight;
        widget.crudObj.updateBedStatus(
            widget.roomId, widget.bed.bedId, "SocialAid", highlight);
        break;
      case BedStatus.Petsa:
        widget.bed.Petsa = highlight;
        widget.crudObj.updateBedStatus(
            widget.roomId, widget.bed.bedId, "Petsa", highlight);
        break;
      case BedStatus.DiatentAid:
        widget.bed.DiatentAid = highlight;
        widget.crudObj.updateBedStatus(
            widget.roomId, widget.bed.bedId, "DiatentAid", highlight);
        break;
      case BedStatus.O2:
        widget.bed.O2 = highlight;
        widget.crudObj
            .updateBedStatus(widget.roomId, widget.bed.bedId, "O2", highlight);
        break;
      case BedStatus.Invasive:
        widget.bed.Invasive = highlight;
        widget.crudObj.updateBedStatus(
            widget.roomId, widget.bed.bedId, "Invasive", highlight);
        break;
    }
  }

  void handleIconStatusSelection(BedStatus status, bool highlight) {
    String fieldName = (status.toString()).split(".")[1];
    if (status == BedStatus.Cateter) fieldName = "withCut";
    if (status == BedStatus.Infected) fieldName = "isInficted";
    if (status == BedStatus.Fasting) fieldName = "fasting";

    widget.crudObj
        .updateBedStatus(widget.roomId, widget.bed.bedId, fieldName, highlight);
  }

  bool getCurrentBedStatus(BedStatus status) {
    bool res = false;
    switch (status) {
      case BedStatus.Fasting:
        res = widget.bed.Fasting;
        break;
      case BedStatus.CT:
        res = widget.bed.CT;
        break;
      case BedStatus.Infected:
        res = widget.bed.Infected;
        break;
      case BedStatus.Cateter:
        res = widget.bed.Cateter;
        break;
      case BedStatus.DiatentAid:
        res = widget.bed.DiatentAid;
        break;
      case BedStatus.Invasive:
        res = widget.bed.Invasive;
        break;
      case BedStatus.O2:
        res = widget.bed.O2;
        break;
      case BedStatus.Petsa:
        res = widget.bed.Petsa;
        break;
      case BedStatus.PhysoAid:
        res = widget.bed.PhysoAid;
        break;
      case BedStatus.SocialAid:
        res = widget.bed.SocialAid;
        break;
    }
    return res;
  }

  String getMessageToShow(BedStatus status) {
    String message;
    switch (status) {
      case BedStatus.Cateter:
        String cuttDate = (widget.bed.CatDate).day.toString() +
            "/" +
            (widget.bed.CatDate).month.toString() +
            "/" +
            (widget.bed.CatDate).year.toString();
        message = "החולה עם קטטר מתאריך " + cuttDate;
        break;
      case BedStatus.CT:
        message = "CT החולה מתוכנן לו";
        break;
      case BedStatus.DiatentAid:
        message = "החולה זקוק להתערבות דיאטנית";
        break;
      case BedStatus.Fasting:
        message = "החולה בצום";
        break;
      case BedStatus.Infected:
        message = "החולה עם זיהום";
        break;
      case BedStatus.Invasive:
        message = " החולה מונשם Invasive";
        break;
      case BedStatus.O2:
        message = "החולה זקוק לחמצן";
        break;
      case BedStatus.Petsa:
        message = "החולה עם פצע לחץ";
        break;
      case BedStatus.PhysoAid:
        message = "החולה זקוק לפיזוטרפיה";
        break;
      case BedStatus.SocialAid:
        message = "החולה זקוק לעזרה סוציאלית";
        break;
    }
    return message;
  }

  void alertDialog(BuildContext context, String message, BedStatus status) {
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
      barrierDismissible: false,
        context: context,
        builder: (BuildContext c) {
          return alert;
        });
  }

  List<Widget> generateListOfIcons() {
    List<Widget> genList = new List<Widget>();
    String message;

    List<BedStatus> bedStatuses = widget.bed.listOfIcons();
    IconData calcIcon;
    for (var stat in bedStatuses) {
      switch (stat) {
        case BedStatus.Cateter:
          String cuttDate = (widget.bed.CatDate).day.toString() +
              "/" +
              (widget.bed.CatDate).month.toString() +
              "/" +
              (widget.bed.CatDate).year.toString();
          message = "החולה עם קטטר מתאריך " + cuttDate;
          calcIcon = Icons.explore;
          break;
        case BedStatus.CT:
          message = "CT החולה מתוכנן לו";
          calcIcon = Icons.explore;
          break;
        case BedStatus.DiatentAid:
          message = "החולה זקוק להתערבות דיאטנית";
          calcIcon = Icons.explore;
          break;
        case BedStatus.Fasting:
          message = "החולה בצום";
          calcIcon = Icons.explore;
          break;
        case BedStatus.Infected:
          message = "החולה עם זיהום";
          calcIcon = Icons.explore;
          break;
        case BedStatus.Invasive:
          message = " החולה מונשם Invasive";
          calcIcon = Icons.explore;
          break;
        case BedStatus.O2:
          message = "החולה זקוק לחמצן";
          calcIcon = Icons.explore;
          break;
        case BedStatus.Petsa:
          message = "החולה עם פצע לחץ";
          calcIcon = Icons.explore;
          break;
        case BedStatus.PhysoAid:
          message = "החולה זקוק לפיזוטרפיה";
          calcIcon = Icons.explore;
          break;
        case BedStatus.SocialAid:
          message = "החולה זקוק לעזרה סוציאלית";
          calcIcon = Icons.explore;
          break;
      }
      genList.add(new IconButton(
        icon: Icon(calcIcon),
        iconSize: 30,
        color: Colors.yellow,
        onPressed: () => alertDialog(context, getMessageToShow(stat), stat),
      ));
    }

    return genList;
  }

  Future<Null> _selectDate(BuildContext context) async {
   showDatePicker(
        context: context,
        initialDate: widget.bed.CatDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101)
        ).then((date){
          widget.crudObj.updateBedDateField(widget.roomId, widget.bed.bedId, "CatDate", date);
             print("Success");
        });
    
   // if (picked != null )
     // setState(() {
     //   widget.crudObj.updateBedDateField(widget.roomId, widget.bed.bedId, "CatDate", picked);
        //widget.bed.CatDate = picked;
     // });
  }

  Widget moveBed(BuildContext context) {
    return new Directionality(
        textDirection: TextDirection.rtl,
        //return Container(
        child: AlertDialog(
          title: new Text("העבר מיטה " + widget.bed.name,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          content: Container(
            width: 200,
            height: 70,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    new Text("אל חדר",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                    new Padding(padding: EdgeInsets.all(16.0)),
                    new DropdownButton<String>(
                      iconSize: 30,
                      value: _selectedRoomNumber,
                      onChanged: (String newValue) {
                        setState(() {
                          _selectedRoomNumber = newValue;
                        });

                        // });
                      },
                      items: widget.rooms.map((var room) {
                        return new DropdownMenuItem<String>(
                          value: (room as Room).roomId,
                          child: new Text( (room as Room).roomName),
                        );
                      }).toList(),
                    ),
                  ],
                )
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
                //handleIconStatusSelection(status, isSwitched);
              },
              child: new Text("אישור",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            new FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
                //handleIconStatusSelection(status, isSwitched);
              },
              child: new Text("ביטול",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ],
        ));
  }
}
