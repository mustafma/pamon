import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:hello_world/Model/bed.dart';

class BedCard extends StatefulWidget {
  final Bed bed;
  final  parentRoomAction;

  BedCard({Key key, @required this.bed , this.parentRoomAction});

  _BedCardState createState() => _BedCardState();
}

class _BedCardState extends State<BedCard> {


  List<PopupMenuEntry<int>> _listOfType = [
    new PopupMenuItem<int>(
      value: 1,
      child: Text('הוראה סוג 1'),
    ),
    new PopupMenuItem<int>(
      value: 2,
       child: Text('הוראה סוג 2'),
    ),
    new PopupMenuItem<int>(
      value: 3,
       child: Text('הוראה סוג 3'),
    ),
  ];

Color cardColor = Colors.white;
  int count = 0;
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
              Icon(
                Icons.notification_important,
              ),
            ],
          )),
      title: Center(child: Text(widget.bed.name),
      ) ,
      subtitle: buildSubTrial(),
      trailing: buildTrial(),
      //onTap: () => increamentCounter(),
    ));
  }

  Widget buildTrial() {
    if (count == 0)
      return new PopupMenuButton(
         onSelected:(value) => _select(value),
        itemBuilder: (BuildContext context) {
          return _listOfType;
        },
      );
    else
      return Badge(
          badgeColor: Colors.yellow,
          badgeContent: Text("$count", style: TextStyle(color: Colors.black , fontSize: 15 , fontWeight: FontWeight.bold )),
          child: new PopupMenuButton(
             onSelected:(value) => _select(value),
            itemBuilder: (BuildContext context) {
              return _listOfType;
            },
          ));
  }

  Widget buildSubTrial() {
    if (count == 0)
    {
       cardColor = Colors.white;
      return new Center(
          child: new Text(
        "אין הוראות חדשות",
        style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold,fontSize: 18),
        overflow: TextOverflow.fade,
        maxLines: 1,
        softWrap: true,
      ));
    }
    else {
      cardColor = Colors.red.withOpacity(0.9);
      String text2 = "הוראות שלא בוצעו ";

      String text3 = text2 + "$count";
      return new Center(
          child: new Text(
        text3,
        style: TextStyle(color: Colors.black ,fontWeight: FontWeight.bold,fontSize: 18),
        overflow: TextOverflow.visible,
        maxLines: 1,
        softWrap: false,
      ));
    }
  }

void _select(int choice) {
  increamentCounter();
  }

  void increamentCounter() {

    // Call Service to update DB  and Push  Notification    
    widget.parentRoomAction();
    setState(() {
      count = count + 1;
      this.widget.bed.totalActiveNotifications +=1;
    });

  }
  @override
  void initState() {
    count = this.widget.bed.totalActiveNotifications;
    super.initState();
  }
}
