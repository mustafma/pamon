
import 'package:BridgeTeam/Views/Dialogs/moveBed.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:BridgeTeam/Model/PopupMenuEntries.dart';
import 'package:BridgeTeam/Model/User.dart';
import 'package:BridgeTeam/Model/bed.dart';
import 'package:BridgeTeam/Model/enumTypes.dart';
import 'package:BridgeTeam/services/crud.dart';

import 'Dialogs/GeneralDialogs.dart';
import 'Dialogs/bedStatusesDialog.dart';
import 'listview_notifications.dart';

class BedCard extends StatefulWidget {
  final Bed bed;
  String roomId;
  final parentRoomAction;
  final List rooms;
  CrudMethods crudObj = new CrudMethods();
  BedCard(
      {Key key,
      @required this.bed,
      this.parentRoomAction,
      this.roomId,
      this.rooms});
  _BedCardState createState() => _BedCardState();
}

class _BedCardState extends State<BedCard> {
  bool popMenueBtnEnaled = false;
  bool popMenueBtnEnaled1 = false;
  Color iconTalk1Color = Colors.white;
  Color cardColor = Color.fromRGBO(64, 75, 96, 9);
  int count = 0;
  bool allowedForBedStatus = false;
  bool allowedaddingInstruction = false;

  IconData bedIconBystatus = Icons.airline_seat_individual_suite;
  User loggedInUser = User.getInstance();

  //List rooms =  widget.rooms;
  List<PopupMenuEntry<InstructionType>> _listOfType = [
    new PopupMenuItem<InstructionType>(
      value: InstructionType.IV,
      child: ListTile(
        trailing: Icon(
          Icons.filter_1,
          color: Color.fromRGBO(64, 75, 96, 9),
        ),
        title: Center(child:Text('I.V מתן עירוי תרופה/נוזל',textAlign: TextAlign.justify,textDirection: TextDirection.rtl)),
      ),
    ),
    new PopupMenuItem<InstructionType>(
      value: InstructionType.PO,
      child: ListTile(
        trailing: Icon(
          Icons.filter_2,
          color: Color.fromRGBO(64, 75, 96, 9),
        ),
        title: Center(child: Text('P.O מתן תרופה מיוחדת',textAlign: TextAlign.justify,textDirection: TextDirection.rtl)),
      ), 
    ),
    new PopupMenuItem<InstructionType>(
      value: InstructionType.SPO,
      child: ListTile(
        trailing: Icon(
          Icons.filter_3,
          color: Color.fromRGBO(64, 75, 96, 9),
        ),
        title: Center(child:Text('P.O הפסקת תרופה ',textAlign: TextAlign.justify,textDirection: TextDirection.rtl)),
      ),  
    ),
     new PopupMenuItem<InstructionType>(
      value: InstructionType.SIV,
      child: ListTile(
        trailing: Icon(
          Icons.filter_4,
          color: Color.fromRGBO(64, 75, 96, 9),
        ),
         title: Center(child:Text('I.V הפסקת עירוי',textAlign: TextAlign.justify,textDirection: TextDirection.rtl)),
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
          child: Container(
              decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                      colors: [
                        const Color(0xFF003C64), const Color(0xFF428879)
                        //const Color(0xFF003C64),
                        //const Color(0xFF00885A)
                      ],
                      begin: FractionalOffset.topLeft,
                      end: FractionalOffset.bottomRight,
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp)),
              child: Column(children: <Widget>[
                Container(
                    //decoration: BoxDecoration(color: cardColor),
                    child: ListTile(
                  leading: buildLeading(),
                  title: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        if (widget.bed.dismissed)
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
                  //onLongPress: () => moveBed(context),
                )),
                Container(
                  decoration: BoxDecoration(
                      // color: cardColor,
                      border: new Border(
                          top: new BorderSide(
                              width: 1.5, color: const Color(0xFF428879)))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: generateListOfIcons()),
                      new Spacer(),
                      Container(
                          // margin: EdgeInsets.only(left: 310),

                          child: IconButton(
                              icon: Icon(Icons.list),
                              onPressed: () => {
                                    showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) {
                                          return new BedStatusDialog(
                                            bed: widget.bed,
                                            roomId: widget.roomId,
                                          );
                                        })
                                  })),
                    ],
                  ),
                )
              ])),
        ));
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
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
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
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
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
  
      switch (choice) {
        case BedAction.Clean:
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return new CustomDialog(
                    text: "לנקות מיטה",
                    bedId: widget.bed.bedId,
                    roomId: widget.roomId,
                    operationName: "cleanbed");
              });

          break;
        case BedAction.Move:
          showDialog(
              context: context,
              builder: (context) {
                return new MoveBedDialog(
                    bed: widget.bed,
                    rooms: widget.rooms,
                    roomId: widget.roomId);
              });
          break;
        case BedAction.Swap:
          break;
        case BedAction.Release:
          showDialog(
              context: context,
              builder: (context) {
                return new CustomDialog(
                    text: "החולה לשחרור",
                    bedId: widget.bed.bedId,
                    roomId: widget.roomId,
                    operationName: "releasebed");
              });
          break;
      }
  }


 
  void addInstruction(InstructionType choice) {
    // Call Service to update DB  and Push  Notification
    String choiceText;


    switch(choice)
    {
      case InstructionType.IV : 
      choiceText = new Text("  I.Vמתן עירוי תרופה",textAlign: TextAlign.justify,textDirection: TextDirection.rtl,).data;
      break;
      case InstructionType.PO : 
      choiceText = "מתן תרופה מיוחדת" + " P.O" ;
      break;
      case InstructionType.SIV:
        choiceText = "הפסקת עירוי" + " I.V";
      break;
      case InstructionType.SPO:
      choiceText = "הפסקת תרופה" + " P.O";
      break;
    }



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
 
    allowedaddingInstruction =loggedInUser.userPermessions[BridgeOperation.AddInstruction];
    allowedForBedStatus  = loggedInUser.userPermessions[BridgeOperation.ChangeBedStatus];

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

  void handleIconStatusSelection(BedStatus status, bool highlight) {
    String fieldName = (status.toString()).split(".")[1];
    if (status == BedStatus.Cateter) fieldName = "Cateter";
    if (status == BedStatus.Infected) fieldName = "Infected";
    if (status == BedStatus.Fasting) fieldName = "Fasting";
    if (status == BedStatus.Pranola) fieldName = "pranola";
    if (status == BedStatus.Pranola) fieldName = "pranola";
    if (status == BedStatus.Seodi) fieldName = "seodi";
    if (status == BedStatus.Cognitive) fieldName = "cognitive";

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
      case BedStatus.Pranola:
        res = widget.bed.pranola;
        break;
      case BedStatus.Seodi:
        res = widget.bed.seodi;
        break;
      case BedStatus.Cognitive:
        res = widget.bed.cognitive;
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
        message = "החולה זקוק לחמצן ביתי";
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
      case BedStatus.Pranola:
        message = "החולה זקוק לברנולה";
        break;
      case BedStatus.Seodi:
        message = "חולה סיעודי";
        break;
      case BedStatus.Cognitive:
        message = "חולה עם ירידה קוגניטיבית";
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
    String url;
    for (var stat in bedStatuses) {
      switch (stat) {
        case BedStatus.Cateter:
          String cuttDate = (widget.bed.CatDate).day.toString() +
              "/" +
              (widget.bed.CatDate).month.toString() +
              "/" +
              (widget.bed.CatDate).year.toString();
          message = "החולה עם קטטר מתאריך " + cuttDate;
          url = 'assets/pamon-cateter.png';
          break;
        case BedStatus.CT:
          message = "CT החולה מתוכנן לו";
          url = 'assets/pamon-yeredacog.png';
          break;
        case BedStatus.DiatentAid:
          message = "החולה זקוק להתערבות דיאטנית";
          url = 'assets/pamon-ditanet.png';
          break;
        case BedStatus.Fasting:
          message = "החולה בצום";
          url = 'assets/pamon-fasting.png';
          break;
        case BedStatus.Infected:
          message = "החולה עם זיהום";
          url = 'assets/pamon-o2.png';
          break;
        case BedStatus.Invasive:
          message = " החולה מונשם Invasive";
          url = 'assets/pamon-invasive.png';
          break;
        case BedStatus.O2:
          message = "החולה זקוק לחמצן";
          url = 'assets/pamon-o2.png';
          break;
        case BedStatus.Petsa:
          message = "החולה עם פצע לחץ";
          url = 'assets/pamon-petsa.png';
          break;
        case BedStatus.PhysoAid:
          message = "החולה זקוק לפיזוטרפיה";
          url = 'assets/pamon-phesotraphy.png';
          break;
        case BedStatus.SocialAid:
          message = "החולה זקוק לעזרה סוציאלית";
          url = 'assets/pamon-social.png';
          break;
        case BedStatus.Pranola:
          message = "החולה זקוק לברנולה";
          url = 'assets/pamon-pranola.png';
          break;
        case BedStatus.Seodi:
          message = "חולה סיעודי";
          url = 'assets/pamon-seodi.png';
          break;
        case BedStatus.Cognitive:
          message = "חולה עם ירידה קוגניטיבית";
           url = 'assets/pamon-yeredacog.png';
      }
      genList.add(new IconButton(
        icon:  Container(
          child: Image(
            image: AssetImage(
              url,
            ),
            fit: BoxFit.cover,
            
          ),
          height: 32,
          width: 32,
         
        ),
        iconSize: 32,
        //color: Colors.yellow,
        onPressed: () => alertDialog(context, getMessageToShow(stat), stat),
      ));
    }

    return genList;
  }
}
