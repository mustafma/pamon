import 'package:BridgeTeam/Model/bed.dart';
import 'package:BridgeTeam/Model/enumTypes.dart';
import 'package:BridgeTeam/services/crud.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BedStatusDialog extends StatefulWidget {
  final String roomId;
  final Bed bed;
  CrudMethods crudObj = new CrudMethods();
  BedStatusDialog({@required this.bed, @required this.roomId});
  _BedStatusDialog createState() => _BedStatusDialog();
}

class _BedStatusDialog extends State<BedStatusDialog> {
  List<StatusTypeValue> statusTypesValues = new List<StatusTypeValue>();
  String flagsForUpdate = "";
  DateTime selectedDate = DateTime.now();
  bool cateterOptionSelected = false;

  bool cateterChecked = false;

  @override
  Widget build(BuildContext context) {
    return new Directionality(
        textDirection: TextDirection.rtl,
        //return Container(
        child: AlertDialog(
          title: new Container(
              color: Color.fromRGBO(134, 165, 195, 9), //Color.fromRGBO(64, 75, 96, 9),
              child: Center(
                child: Text("בחר סוג התראה",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              )),
          content: Container(
            width: 400,
            height: 385,
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    new Row(children: <Widget>[
                      Switch(
                          value: widget.bed.Cateter,
                          onChanged: (bool newValue) {
                            cateterOptionSelected = newValue;
                            var obj = new StatusTypeValue();
                            obj.bedStatus = BedStatus.Cateter;
                            obj.value = newValue;
                            obj.dbFieldName = "withCut";
                            statusTypesValues.add(obj);
                            if (newValue) _selectDate(context);
                          }),
                      new Padding(padding: EdgeInsets.all(1.0)),
                      Text('קטטר שתן',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                    ]),
                    new Row(children: <Widget>[
                      Switch(
                          value: widget.bed.Petsa,
                          onChanged: (bool newValue) {
                            var obj = new StatusTypeValue();
                            obj.bedStatus = BedStatus.Petsa;
                            obj.value = newValue;
                            obj.dbFieldName = "Petsa";
                            statusTypesValues.add(obj);
                          }),
                      new Padding(padding: EdgeInsets.all(1.0)),
                      Text('פצע לחץ דרגה',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                    ]),
                    new Row(children: <Widget>[
                      Switch(
                          value: widget.bed.PhysoAid,
                          onChanged: (bool newValue) {
                            var obj = new StatusTypeValue();
                            obj.bedStatus = BedStatus.PhysoAid;
                            obj.value = newValue;
                            obj.dbFieldName = "PhysoAid";
                            statusTypesValues.add(obj);
                          }),
                      new Padding(padding: EdgeInsets.all(1.0)),
                      Text('זקוק לפיזוטרפיה',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                    ]),
                    new Row(children: <Widget>[
                      Switch(
                          value: widget.bed.SocialAid,
                          onChanged: (bool newValue) {
                            var obj = new StatusTypeValue();
                            obj.bedStatus = BedStatus.SocialAid;
                            obj.value = newValue;
                            obj.dbFieldName = "SocialAid";
                            statusTypesValues.add(obj);
                          }),
                      new Padding(padding: EdgeInsets.all(1.0)),
                      Text('זקוק להערכה סוציאלית',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                    ]),
                    new Row(children: <Widget>[
                      Switch(
                          value: widget.bed.DiatentAid,
                          onChanged: (bool newValue) {
                            var obj = new StatusTypeValue();
                            obj.bedStatus = BedStatus.DiatentAid;
                            obj.value = newValue;
                            obj.dbFieldName = "DiatentAid";
                            statusTypesValues.add(obj);
                          }),
                      new Padding(padding: EdgeInsets.all(1.0)),
                      Text('זקוק להתערבות של דיאטנית',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                    ]),
                    new Row(children: <Widget>[
                      Switch(
                          value: widget.bed.Invasive,
                          onChanged: (bool newValue) {
                            var obj = new StatusTypeValue();
                            obj.bedStatus = BedStatus.Invasive;
                            obj.value = newValue;
                            obj.dbFieldName = "Invasive";
                            statusTypesValues.add(obj);
                          }),
                      new Padding(padding: EdgeInsets.all(1.0)),
                      Text('מונשם Invasive ',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                    ]),
                    new Row(children: <Widget>[
                      Switch(
                          value: widget.bed.O2,
                          onChanged: (bool newValue) {
                            var obj = new StatusTypeValue();
                            obj.bedStatus = BedStatus.O2;
                            obj.value = newValue;
                            obj.dbFieldName = "O2";
                            statusTypesValues.add(obj);
                          }),
                      new Padding(padding: EdgeInsets.all(1.0)),
                      Text('זקוק לחמצן BiPAP/CPAP ',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                    ]),
                    new Row(children: <Widget>[
                      Switch(
                          value: widget.bed.Fasting,
                          onChanged: (bool newValue) {
                            var obj = new StatusTypeValue();
                            obj.bedStatus = BedStatus.Fasting;
                            obj.value = newValue;
                            obj.dbFieldName = "fasting";
                            statusTypesValues.add(obj);
                          }),
                      new Padding(padding: EdgeInsets.all(1.0)),
                      Text('צום',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                    ]),
                  ],
                )
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              onPressed: () {
                handleIconStatusSelection2(context);
                Navigator.of(context).pop();
              },
              child: new Text("סגור",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ],
        ));
  }

  void handleIconStatusSelection2(BuildContext context) {
    if (statusTypesValues != null && statusTypesValues.length > 0) {
      widget.crudObj
          .updateListOfBedStatuses(widget.roomId, widget.bed.bedId, statusTypesValues);

      if (cateterOptionSelected)
        widget.crudObj.updateBedDateField(
            widget.roomId, widget.bed.bedId, "CatDate", selectedDate);
    }
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        firstDate: DateTime(2015, 8),
        initialDate: selectedDate,
        lastDate: DateTime(2101));

    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
}
