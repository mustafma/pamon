
import 'package:BridgeTeam/Model/User.dart';
import 'package:BridgeTeam/services/crud.dart';
import 'package:flutter/material.dart';

import 'appBar.dart';
import 'bottomAppBar.dart';

class InstanceMessage extends StatefulWidget {
  CrudMethods crudObj = new CrudMethods();
  InstanceMessage({
    Key key,
  });
  _InstanceMessage createState() => _InstanceMessage();
}

class _InstanceMessage extends State<InstanceMessage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final textController = TextEditingController();
  bool sendDoctors = false;
  bool sendNurses = false;
  bool sendAll = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BaseAppBar(
          title: Text('שליחת הודעות ',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              textDirection: TextDirection.rtl),
          backButtonVisible: true,
          appBar: AppBar(),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                      colors: [
                        const Color(0xFF003C64),
                        const Color(0xFF428879)
                      ],
                      begin: FractionalOffset.topLeft,
                      end: FractionalOffset.bottomRight,
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp)),
            ),
            Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          color: Colors.white,
                          child: TextField(
                              controller: textController,
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
                              maxLines: 10,
                              decoration: const InputDecoration(
                                fillColor: Colors.white,
                                // icon: const Icon(Icons.calendar_today),
                                hintText: 'תוכן ההודעה',
                                //labelText: "הודעה",
                              )),
                        )),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                        child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(children: <Widget>[
                        new Row(children: <Widget>[
                          Switch(
                              activeColor: Colors.lightBlue,
                              value: false,
                              onChanged: (bool newValue) {
                                sendDoctors = true;
                              }),
                          new Padding(padding: EdgeInsets.all(1.0)),
                          Text('קבוצת רופאים',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                        ]),
                        new Row(children: <Widget>[
                          Switch(
                              activeColor: Colors.lightBlue,
                              value: false,
                              onChanged: (bool newValue) {
                                sendNurses = newValue;
                              }),
                          new Padding(padding: EdgeInsets.all(1.0)),
                          Text('קבוצת אחים/אחיות',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                        ]),
                        new Row(children: <Widget>[
                          Switch(
                              activeColor: Colors.lightBlue,
                              value: false,
                              onChanged: (bool newValue) {
                                sendAll = newValue;
                              }),
                          new Padding(padding: EdgeInsets.all(1.0)),
                          Text('כללי',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                        ]),
                      ]),
                    )),
                    SizedBox(
                      height: 15.0,
                    ),
                    RaisedButton(
                      onPressed: () => sendTextAsNotofocation(context),
                      child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text('שלח הודעה')),
                      color: Colors.orange,
                      textColor: Colors.white,
                    ),
                    SizedBox(
                      height: 2.0,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Divider(
                            color: Colors.white,
                            height: 8.0,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BaseBottomBar());
  }

  Future<void> sendTextAsNotofocation(context) async {
    String msgTxt = textController.text;
    CrudMethods crud = new CrudMethods();
    var topic = "";
    if ((sendDoctors && sendNurses) || sendAll) {
      topic = "messagesFromAdmin_all_topic";
    } else if (sendDoctors) {
      topic = "messagesFromAdmin_doc_topic";
    } else {
      topic = "messagesFromAdmin_nurse_topic";
    }
    User user = User.getInstance();
    var displayName = user.getUserName();
    if (displayName == null)
      displayName = "admin";

    dynamic resp = await crud.sendMessageFunction.call(<String, String>{
      'content': msgTxt,
      'userName': displayName,
      'topic': topic
    });


    showDialog(
        context: context,
        child: new AlertDialog(
          title: Text('שליחת הודעה'),
          content: const Text('הודעה נשלחה בהצלחה'),
          actions: <Widget>[
            FlatButton(
              child: Text('סגור'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }
}
