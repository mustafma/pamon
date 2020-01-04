import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hello_world/Model/room.dart';
import 'package:hello_world/Views/listview_beds.dart';

class RoomCard extends StatefulWidget {
  final Room room;
  RoomCard({@required this.room});

  _RoomCardState createState() => _RoomCardState();
}

class _RoomCardState extends State<RoomCard> {
  int count = 0;
  Color iconTalk1Color = Colors.red;
  Color iconTalk2Color = Colors.grey;
  Color cardColor = Colors.white;

  void _updateNotificationcounter() {
    widget.room.totalNotifications += 1;
    count = widget.room.totalNotifications;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        //
        color: cardColor,
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
            child: Text(
              widget.room.roomName,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          subtitle: buildSubTrial(),
          trailing: buildTrial(),
          onTap: () => onTapBrowseToBeds(context),
        ));
  }

  Widget buildTrial() {
    return Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
      IconButton(
        alignment: Alignment(30.0, 0.0),
        icon: Icon(Icons.people),
        iconSize: 30,
        color: iconTalk2Color,
        onPressed: () => handleTalk1(),
      ),
      IconButton(
        alignment: Alignment(15.0, 0.0),
        icon: Icon(Icons.people),
        iconSize: 30,
        color: iconTalk1Color,
        onPressed: () => handleTalk1(),
      ),
    ]);
  }

  Widget buildSubTrial() {
    if (count == 0)
      return new Center(
          child: new Text(
        "אין הוראות חדשות",
        style: TextStyle(
            color: Colors.green, fontWeight: FontWeight.bold, fontSize: 18),
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
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        overflow: TextOverflow.visible,
        maxLines: 1,
        softWrap: false,
      ));
    }
  }

  void onTapBrowseToBeds(BuildContext context) async {
    // navigate to the next screen.
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ListViewBeds(
                beds: widget.room.beds,
                parentAction: _updateNotificationcounter,
              )),
    );
  }

  @override
  void initState() {
    count = this.widget.room.totalNotifications;
    if (count > 0)
      cardColor = Colors.red.withOpacity(0.4);
    else
      cardColor = Colors.white;
    super.initState();
  }

  handleTalk1() {
    setState(() {
      iconTalk1Color = Colors.yellow;
    });
  }
}
