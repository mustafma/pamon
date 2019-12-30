import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:hello_world/Model/room.dart';
import 'package:hello_world/Views/listview_beds.dart';
import 'package:cloud_functions/cloud_functions.dart';

class RoomCard extends StatefulWidget {
  final Room room;
  RoomCard({@required this.room});

  _RoomCardState createState() => _RoomCardState();
}

class _RoomCardState extends State<RoomCard> {
  int count = 0;


  void _updateNotificationcounter()
  {
    widget.room.totalNotifications+=1;
    count = widget.room.totalNotifications;
  }
  @override
  Widget build(BuildContext context) {
    return Card(
        //
        child: ListTile(
      leading: Container(
          width: 50, // can be whatever value you want
          child: Row(
            children: <Widget>[
             // FlutterLogo(),
              new Icon(Icons.exit_to_app),
              
            ],
          )),
      title: Center(
        child: Text(widget.room.roomName),
      ),
      subtitle: buildSubTrial(),
      trailing: buildTrial(),
      onTap: () => onTapBrowseToBeds(context),
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

void onTapBrowseToBeds(BuildContext  context) async {

  
    // navigate to the next screen.
     Navigator.push(
       context,
       MaterialPageRoute(builder: (context) => ListViewBeds(
         beds: widget.room.beds,parentAction: _updateNotificationcounter,)),
     );
}






@override
  void initState() {
    count = this.widget.room.totalNotifications;
    super.initState();
  }


}

