import 'package:BridgeTeam/services/crud.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget {
  final String text;
   final bedId;
   final roomId;
   final statusfieldName;
   final operationName;

  CrudMethods crudObj = new CrudMethods();
  CustomDialog(
      {@required this.text, this.bedId, this.roomId , this.statusfieldName ,this.operationName});
  _CustomDialog createState() => _CustomDialog();
}

class _CustomDialog extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return new Directionality(
        textDirection: TextDirection.rtl,
        //return Container(
        child: AlertDialog(
          title: new Text("הודעה",
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
                    new Text(widget.text,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                    new Padding(padding: EdgeInsets.all(16.0)),
                  ],
                )
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              onPressed: () async {
                handleYesButton();
                Navigator.of(context).pop();
               // handleYesButton();
              },
              child: new Text("אישור",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            new FlatButton(
              onPressed: () {
                  handleNoButton();
                Navigator.of(context).pop();
                

              
                
              },
              child: new Text("ביטול",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ],
        ));
  }

  void handleYesButton()
  {

    if(widget.operationName.toString().toLowerCase() ==  "cleanbed")
        widget.crudObj.cleanBed(widget.roomId, widget.bedId);
    else if(widget.operationName.toString().toLowerCase() ==  "releasebed")
          releaseBed(true);
    else if(widget.operationName.toString().toLowerCase() ==  "inficted")
          widget.crudObj.markBedAsInfected(widget.roomId, widget.bedId , true);
  }

    void handleNoButton()
  {
  if(widget.operationName.toString().toLowerCase() ==  "releasebed")
          releaseBed(false);
  else if(widget.operationName.toString().toLowerCase() ==  "inficted")
          widget.crudObj.markBedAsInfected(widget.roomId, widget.bedId , false);
  }


  void releaseBed(bool isReleasedBed)
  {
    widget.crudObj.updateBedStatus(widget.roomId, widget.bedId, "dismissed", isReleasedBed);

  }
}
