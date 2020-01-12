import 'package:flutter/material.dart';
import 'package:hello_world/Model/bed.dart';
import 'package:hello_world/Views/bed_card.dart';

import 'appBar.dart';


class ListViewBeds extends StatefulWidget {
  final List<Bed> beds;
    final  parentAction;
    ListViewBeds({Key key, @required this.beds , this.parentAction});

  //ListViewBeds({@required this.beds});
  _ListViewBedsState createState() => _ListViewBedsState();
}

class _ListViewBedsState extends State<ListViewBeds> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

   List<Bed> _listViewData;

  void _updateRoomCounter()
  {
    widget.parentAction();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color.fromRGBO(58,66,86,1.0),
        key: _scaffoldKey,
        appBar: BaseAppBar(
          title: Text('רשימת מיטות'),
          appBar: AppBar(),
         
        ),
        body: Center(child: 
        ListView.builder(
            itemCount: _listViewData.length,
            itemBuilder: (context, index) {
              BedCard bedCard = BedCard(
                              bed: _listViewData[index],
                              parentRoomAction: _updateRoomCounter,
                            );
                            return bedCard;
            }))
        ); 
  }

  @override
  void initState() {
    _listViewData = this.widget.beds;
    super.initState();
  }
}

