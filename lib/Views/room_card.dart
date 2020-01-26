import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hello_world/Model/bed.dart';
import 'package:hello_world/Model/room.dart';
import 'package:hello_world/Views/listview_beds.dart';

class RoomCard extends StatefulWidget {
  final Room room;
  RoomCard({@required this.room});

  _RoomCardState createState() => _RoomCardState();
}

class _RoomCardState extends State<RoomCard> {
  int count = 0;
  Color iconTalk1Color = Colors.white;
  Color iconTalk2Color = Colors.grey;
  Color cardColor ;

  void _updateNotificationcounter() {
    var totalNotifications = widget.room.getTotalNumberOfNotifications();
    totalNotifications += 1;
    count =totalNotifications;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 147,
        child: Card(
            elevation: 8.0,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            //color: cardColor,
            child: Column(
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(color: Theme.of(context).cardColor),
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
     
                      title: Align(
                        alignment: Alignment(0, -0.75),
                        child: Text(
                          widget.room.roomName,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      subtitle: buildSubTrial(),
                     // trailing: buildTrial(),
                      onTap: () => onTapBrowseToBeds(context),
                    )),
                Container(
                  decoration: BoxDecoration(
                    
                    color: (widget.room.getTotalNumberOfNotifications() == 0)?Theme.of(context).cardColor:Colors.red,
                    border: new Border(top:new BorderSide(width: 3.0,color: Colors.orange)))
                    ,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                    
                      IconButton(
                        icon: Icon(Icons.explore),
                        iconSize: 30,
                        color: iconTalk1Color,
                        onPressed: () => {},
                      ),
                      IconButton(
                        icon: Icon(Icons.explore),
                        iconSize: 30,
                        color: iconTalk1Color,
                        onPressed: () => {},
                      ),
                      IconButton(
                        icon: Icon(Icons.explore),
                        iconSize: 30,
                        color: iconTalk1Color,
                        onPressed: () => {},
                      ),
                            IconButton(
                        icon: Icon(Icons.explore),
                        iconSize: 30,
                        color: iconTalk1Color,
                        onPressed: () => {},
                      ),
                            IconButton(
                        icon: Icon(Icons.explore),
                        iconSize: 30,
                        color: iconTalk1Color,
                        onPressed: () => {},
                      )
                    ],
                  ),
                )
              ],
            )));
  }

  Widget buildTrial() {
    return SingleChildScrollView(
      //padding: const EdgeInsets.all(8.0),
      child: Column(children: <Widget>[
        // Column(
        // children: <Widget>[

        //  ],
        //),
        //Column(
        //children: <Widget>[
        IconButton(
          // alignment: Alignment(10.0, 10.0),
          icon: Icon(Icons.exit_to_app),
          iconSize: 30,
          color: iconTalk1Color,
          onPressed: () => handleTalk1(),
        ),

        //],
        //)
      ]),
    );
  }

  Widget buildSubTrial() {
    if ( widget.room.getTotalNumberOfNotifications() == 0)
      return new Align(
          alignment: Alignment(0, -2.8),
          child: new Text(
            "אין הוראות חדשות",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
            overflow: TextOverflow.fade,
            maxLines: 3,
            // softWrap: true,
          ));
    else {
      String text2 = "הוראות שלא בוצעו ";

      String text3 = text2 +  widget.room.getTotalNumberOfNotifications().toString();

      return new Align(
          alignment: Alignment(0, -2.8),
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

  void onTapBrowseToBeds(BuildContext context) async {
    // navigate to the next screen.
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ListViewBeds(
                beds: widget.room.beds,
                roomId: widget.room.roomId,
                parentAction: _updateNotificationcounter,
              )),
    );
  }

  @override
  void initState() {
    count = this.widget.room.getTotalNumberOfNotifications();
    if (count > 0) cardColor = Colors.red;
    // else
    //  cardColor = Colors.green.withOpacity(0.7);
    super.initState();
  }

  handleTalk1() {
    setState(() {
      iconTalk1Color = Colors.yellow;
    });
  }
}
