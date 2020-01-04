import 'package:flutter/material.dart';
import 'package:hello_world/Model/bed.dart';
import 'package:hello_world/Model/repository.dart';

import 'appBar.dart';
import 'notification_card.dart';

class ListViewInstructions extends StatefulWidget {
  final List<BedInstruction> bedInstructions;
  ListViewInstructions({Key key, @required this.bedInstructions});

  _ListViewInstructionsState createState() => _ListViewInstructionsState();
}

class _ListViewInstructionsState extends State<ListViewInstructions> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Repository repository = new Repository();
  List<BedInstruction> _listViewData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: BaseAppBar(
          title: Text('רשימת ההוראות' , textDirection:TextDirection.rtl),
          appBar: AppBar(),
        ),
        body: Center(
            child: ListView.builder(
                itemCount: _listViewData.length,
                itemBuilder: (context, index) {
                  NotificationCard notificationCard = NotificationCard(
                    bedInstruction: _listViewData[index],
                  );
                  return notificationCard;
                })));
  }

  @override
  void initState() {
    _listViewData = this.widget.bedInstructions;
    super.initState();
  }
}
