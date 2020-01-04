import 'package:flutter/material.dart';
import 'package:hello_world/Model/bed.dart';
import 'package:hello_world/Model/session.dart';

class NotificationCard extends StatefulWidget {
  final BedInstruction bedInstruction;

  NotificationCard({Key key, @required this.bedInstruction});
  _NotificationCard createState() => _NotificationCard();
}

class _NotificationCard extends State<NotificationCard> {
  int count = 0;
  bool popMenueBtnEnaled = false;
  Color cardColor;

  List<PopupMenuEntry<int>> _listOfBedStatuses = [
    new PopupMenuItem<int>(
      value: 1,
      child: Text('בצע הוראה'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
        //
        color: cardColor,
        child: ListTile(
          leading: buildLeading(),
          title: Center(
            child: Text(widget.bedInstruction.notificationText),
          ),
          //onTap: () => onTapBrowseToBedInstructions(context),
        ));
  }

  Widget buildLeading() {
    return new PopupMenuButton(
      enabled: popMenueBtnEnaled,
      onSelected: (value) => _selectInstructionAction(value),
      itemBuilder: (BuildContext context) {
        return _listOfBedStatuses;
      },
    );
  }

  @override
  void initState() {
    if (session.instance().iSNursePermessions) {
      popMenueBtnEnaled = true;
    } else {
      popMenueBtnEnaled = false;
    }

    super.initState();
  }

  void _selectInstructionAction(int choice) {}
}
