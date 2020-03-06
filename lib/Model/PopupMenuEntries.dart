import 'package:flutter/material.dart';
import 'package:BridgeTeam/Model/enumTypes.dart';

import 'User.dart';

class PamonMenus {
  
  static List<PopupMenuEntry<BedStatus>> _listBedStatuses = [
    new PopupMenuItem<BedStatus>(
      value: BedStatus.Cateter,
      child: ListTile(
        trailing: Switch(value: true, onChanged: (bool newValue) { }),
        title: Text('קטטר שתן'),
      ),
    ),
    new PopupMenuItem<BedStatus>(
      value: BedStatus.Petsa,
      child: ListTile(
        trailing: Icon(
          Icons.filter_2,
          color: Color.fromRGBO(64, 75, 96, 9),
        ),
        title: Text('פצע לחץ דרגה'),
      ),
    ),
    new PopupMenuItem<BedStatus>(
      value: BedStatus.PhysoAid,
      child: ListTile(
        trailing: Icon(
          Icons.filter_2,
          color: Color.fromRGBO(64, 75, 96, 9),
        ),
        title: Text('זקוק לפיזוטרפיה'),
      ),
    ),
    new PopupMenuItem<BedStatus>(
      value: BedStatus.SocialAid,
      child: ListTile(
        trailing: Icon(
          Icons.filter_2,
          color: Color.fromRGBO(64, 75, 96, 9),
        ),
        title: Text('זקוק להערכה סוציאלית'),
      ),
    ),
    new PopupMenuItem<BedStatus>(
      value: BedStatus.DiatentAid,
      child: ListTile(
        trailing: Icon(
          Icons.filter_2,
          color: Color.fromRGBO(64, 75, 96, 9),
        ),
        title: Text('זקוק להתערבות של דיאטנית'),
      ),
    ),
    new PopupMenuItem<BedStatus>(
      value: BedStatus.Invasive,
      child: ListTile(
        trailing: Icon(
          Icons.filter_2,
          color: Color.fromRGBO(64, 75, 96, 9),
        ),
        title: Text(' Invasive מונשם'),
      ),
    ),
    new PopupMenuItem<BedStatus>(
      value: BedStatus.O2,
      child: ListTile(
        trailing: Icon(
          Icons.filter_2,
          color: Color.fromRGBO(64, 75, 96, 9),
        ),
        title: Text('BiPAP/CPAP זקוק לחמצן'),
      ),
    ),
    new PopupMenuItem<BedStatus>(
      value: BedStatus.Fasting,
      child: ListTile(
        trailing: Icon(
          Icons.filter_2,
          color: Color.fromRGBO(64, 75, 96, 9),
        ),
        title: Text('צום'),
      ),
    ),
  ];

  static List<PopupMenuEntry<BedAction>> _listBedActions = [];

  static List<PopupMenuEntry<BedStatus>> get BedStatuses {
    return _listBedStatuses;
  }

  static List<PopupMenuEntry<BedAction>> get BedActions {
     User loggedInUser = User.getInstance();

_listBedActions = [];
    if (loggedInUser.userPermessions[BridgeOperation.CleanBed])
    {
      var popMenuItem1 = new  PopupMenuItem<BedAction>(
      
      value: BedAction.Clean,
      child: ListTile(
        trailing: Icon(
          Icons.clear,
          color: Color.fromRGBO(64, 75, 96, 9),
        ),
        title: Text('נקה מיטה'),
      ),
    );

    _listBedActions.add(popMenuItem1);
    }


if (loggedInUser.userPermessions[BridgeOperation.MoveBed])
{
  var popMenuItem2 =  new PopupMenuItem<BedAction>(
      value: BedAction.Move,
      child: ListTile(
        trailing: Icon(
          Icons.move_to_inbox,
          color: Color.fromRGBO(64, 75, 96, 9),
        ),
        title: Text('החלף מיטות'),
      ),
    );
    _listBedActions.add(popMenuItem2);

}

if (loggedInUser.userPermessions[BridgeOperation.ReleaseBed])
{
  var popMenuItem3 =   new PopupMenuItem<BedAction>(
      value: BedAction.Release,
      child: ListTile(
        trailing: Icon(
          Icons.exit_to_app,
          color: Color.fromRGBO(64, 75, 96, 9),
        ),
        title: Text('מיטה לשחרור'),
      ),
    );
    _listBedActions.add(popMenuItem3);

}

    return _listBedActions;
  }



 static List<PopupMenuEntry<RoomAction>> get Roomctions {
     User loggedInUser = User.getInstance();

 List<PopupMenuEntry<RoomAction>> _listRoomActions = [];
    if (loggedInUser.userPermessions[BridgeOperation.SetRoomAsInfected])
    {
      var popMenuItem1 = new  PopupMenuItem<RoomAction>(
      
      value: RoomAction.Infected,
      child: ListTile(
        trailing: Icon(
          Icons.add,
          color: Color.fromRGBO(64, 75, 96, 9),
        ),
        title: Text('חדר עם זהום'),
      ),
    );

    _listRoomActions.add(popMenuItem1);
    }

       if (loggedInUser.userPermessions[BridgeOperation.CancelRoomInfectectionStatus])
    {
      var popMenuItem2 = new  PopupMenuItem<RoomAction>(
      
      value: RoomAction.CancelInfection,
      child: ListTile(
        trailing: Icon(
          Icons.clear,
          color: Color.fromRGBO(64, 75, 96, 9),
        ),
        title: Text('בטל הערת זהום'),
      ),
    );

    _listRoomActions.add(popMenuItem2);
    }


    return _listRoomActions;
  }




}
