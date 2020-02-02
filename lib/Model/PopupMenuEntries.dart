import 'package:flutter/material.dart';
import 'package:hello_world/Model/enumTypes.dart';


 class PamonMenus {
 
  static List<PopupMenuEntry<BedStatus>> _listBedStatuses = [
  new PopupMenuItem<BedStatus>(
    value: BedStatus.Cateter,
    child: ListTile(
      trailing: Icon(
        Icons.filter_1,
        color: Color.fromRGBO(64, 75, 96, 9),
      ),
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
    value: BedStatus.Invasiv,
    child: ListTile(
      trailing: Icon(
        Icons.filter_2,
        color: Color.fromRGBO(64, 75, 96, 9),
      ),
      title: Text('מונשם Invasive'),
    ),
  ),
  new PopupMenuItem<BedStatus>(
    value: BedStatus.O2,
    child: ListTile(
      trailing: Icon(
        Icons.filter_2,
        color: Color.fromRGBO(64, 75, 96, 9),
      ),
      title: Text('זקוק לחמצן BiPAP או CPAP'),
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

 static List<PopupMenuEntry<BedStatus>> get BedStatuses {
    return _listBedStatuses;
  }
}
