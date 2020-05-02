
import 'package:BridgeTeam/Model/crewmember.dart';
import 'package:BridgeTeam/Model/enumTypes.dart';
import 'package:BridgeTeam/Model/room.dart';
import 'package:BridgeTeam/services/crud.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoomCrewDialog extends StatefulWidget {
  final Room room;

  RoomCrewDialog({@required this.room});
  _RoomCrewDialog createState() => _RoomCrewDialog();
}

class _RoomCrewDialog extends State<RoomCrewDialog> {
  CrudMethods crudObj = new CrudMethods();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: new Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: new Container(
                color: Color.fromRGBO(
                    134, 165, 195, 9), //Color.fromRGBO(64, 75, 96, 9),
                child: Center(
                  child: Text("רשימת  צוות של חדר " + widget.room.roomId,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                )),
            content: Container(
                width: 400,
                child: Column(
                    children: <Widget>[getTextWidgets(widget.room.crew)])),
            actions: <Widget>[
             Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new FlatButton(
                        onPressed: () async {
                          joinCrew();
                          Navigator.of(context).pop();
                          // handleYesButton();
                        },
                        child: new Text("הצטרף",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      new FlatButton(
                        onPressed: () {
                          leaveCrew();
                          Navigator.of(context).pop();
                        },
                        child: new Text("יציאה מקבוצה",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ]),
         
            ],
          )),
    );
  }

  Widget getTextWidgets(List<dynamic> crew) {
    return new Column(
        children: crew.map((member) => new Text(generateTextToDispaly(member))).toList());
  }

  void joinCrew() {
    crudObj.addCrewMemberToroom(widget.room.roomId);
  }

  void leaveCrew() {

    crudObj.removeCrewMemberFromRoom(widget.room.roomId);
  }


  String generateTextToDispaly(dynamic member)
  {
    switch((member as CrewMember).type){
      case UserType.Doctor:
      case UserType.DepartmentManager:
          return "דר. " + (member as CrewMember).name ;

      case UserType.Nurse:
      case UserType.NurseShiftManager:
      return " אח/ות " + (member as CrewMember).name ;
       default:
      return (member as CrewMember).name;

    }
  }

}
