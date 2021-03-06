import 'package:BridgeTeam/Model/User.dart';
import 'package:BridgeTeam/Model/enumTypes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:BridgeTeam/services/auth.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor = Colors.blue;
  final Text title;
  final AppBar appBar;
  final bool backButtonVisible;
  final AuthService _auth = AuthService();
  BaseAppBar({Key key, this.title, this.appBar, this.backButtonVisible})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [const Color(0xFF144464), const Color(0xFF546C7D)],
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp)),
        child: AppBar(
            elevation: 0.1,
            title: Center(child: title),
            backgroundColor: const Color(0xFF144464), //Color.fromRGBO(
            // 97, 138, 179, 9), //Color.fromRGBO(58, 66, 86, 1.0),

            leading: new Visibility(
              visible: backButtonVisible,
              child: IconButton(
                icon: new Icon(
                  Icons.keyboard_return,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            actions: <Widget>[
              new PopupMenuButton(
                initialValue: 1,
                icon: Icon(
                  Icons.list,
                  color: Colors.white,
                ),
                itemBuilder: (BuildContext context) {
                  return barOprions();
                },
                onSelected: (selection) {
                  switch (selection) {
                    case 5:
                      _handleSignout(context);
                      break;
                    case 2:
                      _handleSettings(context);
                      break;
                    case 3:
                      _handleUserMangments(context);
                      break;
                    case 6:
                      _handleInstanceMessage(context);
                      break;
                    case 7:
                      _handleShiftView(context);
                      break;
                     case 8:
                      _handleSurvey(context);
                      break;
                  }
                },
              ),

            ]),

      ),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);

  List<PopupMenuEntry<int>> barOprions() {
    List<PopupMenuEntry<int>> _listOfType = [];
    User loggedInUser = User.getInstance();

    _listOfType.add(new PopupMenuItem<int>(
      value: 1,
        child:Container(
          decoration: BoxDecoration( //                    <-- BoxDecoration
            border: Border(bottom: BorderSide(color: Colors.grey[200])),
          ),
          child: ListTile(
            trailing: Icon(
            Icons.person,
            color: Color.fromRGBO(134, 165, 195, 9),

          // color: Color.fromRGBO(64, 75, 96, 9),
        ),

        title:Align(
          child: Text(loggedInUser.getUserName() == null ? "." : loggedInUser.getUserName()),
          alignment: Alignment(1.2, 0),
        ),

      ),
    )
    ));

    _listOfType.add(new PopupMenuItem<int>(
      value: 2,
      child: ListTile(
        trailing: Icon(
          // icon: Icon(
          Icons.settings,
          color: Color.fromRGBO(134, 165, 195, 9),
          //  ),
          // onPressed: () {},
        ),
        title: Text('הגדרות'),
      ),
    ));

    if (loggedInUser.userPermessions[BridgeOperation.SendMessages]) {
      _listOfType.add(new PopupMenuItem<int>(
        value: 6,
        child: ListTile(
          trailing: Icon(
            Icons.speaker_notes,
            color: Color.fromRGBO(134, 165, 195, 9),
            // color: Color.fromRGBO(64, 75, 96, 9),
          ),
          title: Text('כריזה'),
        ),
      ));
    }

    if (loggedInUser.userPermessions[BridgeOperation.UserManagment]) {
      _listOfType.add(new PopupMenuItem<int>(
        value: 3,
        child: ListTile(
          trailing: Icon(
            Icons.control_point_duplicate,
            color: Color.fromRGBO(134, 165, 195, 9),
          ),
          title: Text('ניהול משתמשים'),
        ),
      ));
    }

    if (loggedInUser.userPermessions[BridgeOperation.BuildDoctorsShift] ||
        loggedInUser.userPermessions[BridgeOperation.BuildNursesShift]) {
      _listOfType.add(new PopupMenuItem<int>(
        value: 7,
        child: ListTile(
          trailing: Icon(
            Icons.control_point_duplicate,
            color: Color.fromRGBO(134, 165, 195, 9),
          ),
          title: Text('ניהול משמרת'),
        ),
      ));
    }

    _listOfType.add(new PopupMenuItem<int>(
      value: 4,
      child: ListTile(
        trailing: Icon(
          Icons.contact_phone,
          color: Color.fromRGBO(134, 165, 195, 9),
        ),
        title: Text('צור קשר'),
      ),
    ));

    _listOfType.add(new PopupMenuItem<int>(
      value: 5,
      child: ListTile(
        trailing: Icon(
          Icons.exit_to_app,
          color: Color.fromRGBO(134, 165, 195, 9),
        ),
        title: Text('יציאה'),
      ),
    ));



    _listOfType.add(new PopupMenuItem<int>(
      value: 8,
      child: ListTile(
        trailing: Icon(
          Icons.exit_to_app,
          color: Color.fromRGBO(134, 165, 195, 9),
        ),
        title: Text('שאלון'),
      ),
    ));



    return _listOfType;
  }
}

Future _handleSignout(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.pushNamed(context, '/SignOut');
  //return LoginWidget();
}

void _handleSettings(BuildContext context) {
  Navigator.pushNamed(context, '/Settings');
  //return LoginWidget();
}

void _handleInstanceMessage(BuildContext context) {
  Navigator.pushNamed(context, '/IM');
  //return LoginWidget();
}

void _handleUserMangments(BuildContext context) {
  Navigator.pushNamed(context, '/UserMng');
  //return LoginWidget();
}

void _handleShiftView(BuildContext context) {
  Navigator.pushNamed(context, '/ShiftMng');
  //return LoginWidget();
}
void _handleSurvey(BuildContext context) {
  Navigator.pushNamed(context, '/ZZZ');
  //return LoginWidget();
}
