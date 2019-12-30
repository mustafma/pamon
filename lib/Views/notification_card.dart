import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

class NotificationCard extends StatefulWidget{

    _NotificationCard createState() => _NotificationCard();


}

class _NotificationCard extends State<NotificationCard>{

 int count = 0;

 @override
  Widget build(BuildContext context) {
return Card(
        //
        child: ListTile(
      leading: Container(
          width: 50, // can be whatever value you want
          child: Row(
            children: <Widget>[
              FlutterLogo()
              
            ],
          )),
      title: Center(
        child: Text("CCC"),
      ),
      subtitle: buildSubTrial(),
      trailing: buildTrial(),

    ));
  }
  Widget buildTrial() {
    if (count == 0)
      return new Icon(Icons.notifications_active);
    else
      return Badge(
          badgeContent: Text("$count", style: TextStyle(color: Colors.white)),
          child: new Icon(Icons.notifications_active));
  }

  Widget buildSubTrial() {
    if (count == 0)
      return new Center(
          child: new Text(
        "אין הוראות חדשות",
        style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        overflow: TextOverflow.fade,
        maxLines: 1,
        softWrap: true,
      ));
    else {
      String text2 = "הוראות שלא בוצעו ";

      String text3 = text2 + "$count";
      return new Center(
          child: new Text(
        text3,
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        overflow: TextOverflow.visible,
        maxLines: 1,
        softWrap: false,
      ));
    }
  }

}