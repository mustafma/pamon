import 'package:BridgeTeam/Model/bed.dart';
import 'package:BridgeTeam/Model/room.dart';
import 'package:BridgeTeam/services/crud.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MoveBedDialog extends StatefulWidget {
  var _selectedRoomNumber;
  var _selectedBedNumber;
  final List rooms;

  final Bed bed;
  final String roomId;

  CrudMethods crudObj = new CrudMethods();
  MoveBedDialog({@required this.bed, @required this.rooms ,@required this.roomId});
  _MoveBedDialog createState() => _MoveBedDialog();

  List getRoomBeds() {
    List beds;
    rooms.forEach((room) =>
        {if ((room as Room).roomId == roomId) beds = (room as Room).beds});
    return beds;
  }
}

class _MoveBedDialog extends State<MoveBedDialog> {
  @override
  Widget build(BuildContext context) {
    return new Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: new Text("העבר מיטה " + widget.bed.name,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          content: Container(
            width: 400,
            height: 150,
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        new Text("אל חדר",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                        new Padding(padding: EdgeInsets.all(16.0)),
                        new DropdownButton<Room>(
                          iconSize: 30,
                          value: widget._selectedRoomNumber,
                          onChanged: (Room newValue) {
                            setState(() {
                              widget._selectedRoomNumber = newValue;
                            });

                            // });
                          },
                          items: widget.rooms.map((var room) {
                            return new DropdownMenuItem<Room>(
                              value: (room as Room),
                              child: new Text((room as Room).roomName),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        new Text("אל מיטה",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                        new Padding(padding: EdgeInsets.all(16.0)),
                        new DropdownButton<Bed>(
                          iconSize: 30,
                          value: widget._selectedBedNumber,
                          isDense: true,
                          onChanged: (Bed newValue) {
                            _onDropDownChanged(newValue);
                          },
                          items: widget.getRoomBeds().map((var bed) {
                            return new DropdownMenuItem<Bed>(
                              value: bed,
                              child: new Text((bed).bedId + "חדר "),
                            );
                          }).toList(),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
                handleMoveBed(
                    widget.roomId,
                    widget._selectedRoomNumber.roomId,
                    widget._selectedBedNumber.bedId);
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

  void _onDropDownChanged(Bed val) {
    setState(() {
      widget._selectedBedNumber = val;
      // initState();
    });
  }

  void handleMoveBed(fromRoomId, toRoomId, bedId) {
    widget.crudObj.replaceBed(fromRoomId, toRoomId, widget.bed.bedId,bedId);
  }


@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


}
