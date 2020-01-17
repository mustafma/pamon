import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'appBar.dart';

class SettingsWindow extends StatefulWidget {
  _SettingsWindowsState createState() => _SettingsWindowsState();
}

class _SettingsWindowsState extends State {

  Future<bool> _getBoolFormSharedPref() async {
    final pref = await SharedPreferences.getInstance();
    final isStopNotification = pref.getBool('stopNotification');
    if (isStopNotification == null) {
      return false;
    }
    return isStopNotification;
  }

  Future<void> _resetNotificationSetup() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool('stopNotification', false);
  }

  Future<void> _setSharedPrefNotificationSetup(bool userSelection) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool('startUpNumber', userSelection);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BaseAppBar(
          title: Text('הגדרות'),
          appBar: AppBar(),
        ),
        body: Align(
           alignment: Alignment.topRight,
        //  textDirection: TextDirection.rtl,
          child: Container(
            width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                  
                Switch(
                  value: true,
                  onChanged: (bool newValue) { 
                   _setSharedPrefNotificationSetup(newValue);
                  },
                ),
                Expanded(
                    child: Text(
                  " השתק הודעות",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),
              
              ],
            ), 
            
           
          ),
        )

        //height: 60,

        );
  }

  @override
  void initState() {
    super.initState();
  //  _incrementStartUp();
  }
}
