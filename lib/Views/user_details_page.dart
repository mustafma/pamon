import 'package:BridgeTeam/Components/dropdown_form_field_validation.dart';
import 'package:BridgeTeam/Components/flat_button_custom.dart';
import 'package:BridgeTeam/Components/page_header.dart';
import 'package:BridgeTeam/Components/text_form_field_validation.dart';
import 'package:BridgeTeam/Model/User.dart';
import 'package:BridgeTeam/Model/User2.dart';
import 'package:BridgeTeam/services/crud.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'appBar.dart';

class UserDetailsPage extends StatefulWidget {
  final User2 user;
  UserDetailsPage({this.user, Key key}) : super(key: key);

  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  User2 user;
  bool isNew = false;
  @override
  void initState() {
    if (widget.user == null) {
      user = User2();
      user.role = "nr";
      isNew = true;
    } else {
      user = widget.user;
      isNew = false;
    }
    super.initState();
  }

  final formKey = GlobalKey<FormState>();
  var crud = new CrudMethods();

  @override
  Widget build(BuildContext context) {
    //final themeProvider = Provider.of<ThemeProvider>(context);
    //final usersProvider = Provider.of<UsersProvider>(context);
    return Scaffold(
      appBar: BaseAppBar(
        title: Text('ניהול משתמשים',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
            textDirection: TextDirection.rtl),
        backButtonVisible: true,
        appBar: AppBar(),
      ),
      body: Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [
                const Color(0xFF003C64), const Color(0xFF428879)
                //const Color(0xFF003C64),
                //const Color(0xFF00885A)
              ],
              begin: FractionalOffset.topLeft,
              end: FractionalOffset.bottomRight,
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [],
        ),
        child: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              Center(
                child: PageHeader(
                  title: widget.user == null ? 'משתמש חדש' : 'עדכון משתמש קיים',
                ),
              ),
              TextFormFieldValidation(
                hint: 'שם',
                initialValue: user.name,
                onValueChanged: (val) {
                  user.name = val.trim();
                },
              ),
              TextFormFieldValidation(
                hint: 'אימייל',
                initialValue: user.email,
                onValueChanged: (val) {
                  user.email = val.trim();
                },
              ),
              if (widget.user == null)
                TextFormFieldValidation(
                  hint: 'סיסמה',
                  initialValue: user.password,
                  onValueChanged: (val) {
                    user.password = val.trim();
                  },
                ),
              DropDownFormFieldValidation(
                  hint: 'סוג משתמש',
                  initialValue: user.role.toString(),
                  onValueChanged: (val) {
                    user.role = val.trim();
                  }),
              SizedBox(height: 10),
              FlatButtonCustom(
                title: widget.user == null ? 'חדש' : 'עדכן',
                color: Colors.orange,
                onTap: () {
                  if (formKey.currentState.validate()) {
                    crud.addUser(user, isNew);

                    if (user.uid == User.getInstance().loggedInUserId)
                      User.getInstance().populateUserPermessions();

                    showDialog(
                        context: context,
                        child: new AlertDialog(
                          title: Text('ניהול משתמשים'),
                          content: const Text('רשומה עודכנה בהצלחה'),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('סגור'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ));
                    // usersProvider.updateUser(user: user, isRegistering: widget.user == null ? true : false);
                    // Navigator.of(context).pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
