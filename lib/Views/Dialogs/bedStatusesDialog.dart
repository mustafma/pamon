import 'package:BridgeTeam/Model/bed.dart';
import 'package:BridgeTeam/Model/enumTypes.dart';
import 'package:BridgeTeam/services/crud.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatusTypeValue {
  BedStatus bedStatus;
  bool value;

  BedStatus get status {
    return bedStatus;
  }
}

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

  @override
  Widget build(BuildContext context) {
    return new Directionality(
        textDirection: TextDirection.rtl,
        //return Container(
        child: AlertDialog(
          title: new Container(
              color: Color.fromRGBO(64, 75, 96, 9),
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
                          value: false,
                          onChanged: (bool newValue) {
                            var obj = new StatusTypeValue();
                            obj.bedStatus = BedStatus.Cateter;
                            obj.value = newValue;
                            statusTypesValues.add(obj);
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
                          value: false,
                          onChanged: (bool newValue) {
                            var obj = new StatusTypeValue();
                            obj.bedStatus = BedStatus.Petsa;
                            obj.value = newValue;
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
                          value: false,
                          onChanged: (bool newValue) {
                            var obj = new StatusTypeValue();
                            obj.bedStatus = BedStatus.PhysoAid;
                            obj.value = newValue;
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
                          value: false,
                          onChanged: (bool newValue) {
                            var obj = new StatusTypeValue();
                            obj.bedStatus = BedStatus.SocialAid;
                            obj.value = newValue;
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
                          value: false,
                          onChanged: (bool newValue) {
                            var obj = new StatusTypeValue();
                            obj.bedStatus = BedStatus.DiatentAid;
                            obj.value = newValue;
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
                          value: false,
                          onChanged: (bool newValue) {
                            var obj = new StatusTypeValue();
                            obj.bedStatus = BedStatus.Invasive;
                            obj.value = newValue;
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
                          value: false,
                          onChanged: (bool newValue) {
                            var obj = new StatusTypeValue();
                            obj.bedStatus = BedStatus.O2;
                            obj.value = newValue;
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
                          value: false,
                          onChanged: (bool newValue) {
                            var obj = new StatusTypeValue();
                            obj.bedStatus = BedStatus.Fasting;
                            obj.value = newValue;
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

  void doWork(BedStatus status, bool highlight, BuildContext context) async {
    switch (status) {
      case BedStatus.Cateter:
        //widget.bed.Cateter = true;
        await _selectDate(context);

        flagsForUpdate = flagsForUpdate + "withCut;";
        // await widget.crudObj.updateBedStatus(
        //   widget.roomId, widget.bed.bedId, "withCut", highlight);
        // widget.crudObj.updateBedDateField(
        //   widget.roomId, widget.bed.bedId, "CatDate", widget.bed.CatDate);
        break;
      case BedStatus.CT:
        //widget.bed.CT = highlight;
        flagsForUpdate = flagsForUpdate + "forCT;";
        //await widget.crudObj.updateBedStatus(
        //   widget.roomId, widget.bed.bedId, "forCT", highlight);
        break;
      case BedStatus.Infected:
        //widget.bed.Infected = highlight;
        flagsForUpdate = flagsForUpdate + "isInficted;";
        // await widget.crudObj.updateBedStatus(
        //    widget.roomId, widget.bed.bedId, "isInficted", highlight);
        break;
      case BedStatus.Fasting:
        //widget.bed.Fasting = highlight;
        flagsForUpdate = flagsForUpdate + "fasting;";
        //await widget.crudObj.updateBedStatus(
        //  widget.roomId, widget.bed.bedId, "fasting", highlight);
        break;
      case BedStatus.PhysoAid:
        // widget.bed.PhysoAid = highlight;
        flagsForUpdate += "PhysoAid;";
        //await widget.crudObj.updateBedStatus(
        //   widget.roomId, widget.bed.bedId, "PhysoAid", highlight);
        break;
      case BedStatus.SocialAid:
        // widget.bed.SocialAid = highlight;
        flagsForUpdate = flagsForUpdate + "SocialAid;";
        //await widget.crudObj.updateBedStatus(
        //   widget.roomId, widget.bed.bedId, "SocialAid", highlight);
        break;
      case BedStatus.Petsa:
        //widget.bed.Petsa = highlight;
        flagsForUpdate = flagsForUpdate + "Petsa;";
        //await widget.crudObj.updateBedStatus(
        //  widget.roomId, widget.bed.bedId, "Petsa", highlight);
        break;
      case BedStatus.DiatentAid:
        //widget.bed.DiatentAid = highlight;
        flagsForUpdate += "DiatentAid;";
        //await widget.crudObj.updateBedStatus(
        //   widget.roomId, widget.bed.bedId, "DiatentAid", highlight);
        break;
      case BedStatus.O2:
        //widget.bed.O2 = highlight;
        flagsForUpdate = flagsForUpdate + "O2;";
        //await widget.crudObj
        //    .updateBedStatus(widget.roomId, widget.bed.bedId, "O2", highlight);
        break;
      case BedStatus.Invasive:
        //widget.bed.Invasive = highlight;
        flagsForUpdate = flagsForUpdate + "Invasive;";

        break;
    }
  }

  void handleIconStatusSelection2(BuildContext context) {
    if (statusTypesValues != null && statusTypesValues.length > 0) {
      statusTypesValues.forEach((x) => {doWork(x.status, x.value, context)});

      widget.crudObj.updateBedStatus(
          widget.roomId, widget.bed.bedId, flagsForUpdate, true);
    }
  }

  Future<Null> _selectDate(BuildContext context) async {
    showDatePicker(
            context: context,
            initialDate: widget.bed.CatDate,
            firstDate: DateTime(2012, 8),
            lastDate: DateTime(2101))
        .then((date) {
      widget.crudObj.updateBedDateField(widget.roomId, widget.bed.bedId,
          "CatDate", date == null ? DateTime.now() : date);
      print("Success");
    });
  }
}
