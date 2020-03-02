import 'package:BridgeTeam/Components/dropdown_form_field_validation.dart';
import 'package:BridgeTeam/Components/flat_button_custom.dart';
import 'package:BridgeTeam/Components/page_header.dart';
import 'package:BridgeTeam/Components/text_form_field_validation.dart';
import 'package:BridgeTeam/Model/User2.dart';
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
  @override
  void initState() {
    if (widget.user == null) {
      user = User2();
    } else {
      user = widget.user;
    }
    super.initState();
  }

  final formKey = GlobalKey<FormState>();
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
              Center(child: PageHeader(
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
                initialValue: user.userType.toString(),
                onValueChanged: (val) {
                  user.email = val.trim();
                }),




                
              SizedBox(height: 10),
              FlatButtonCustom(
                title: widget.user == null ? 'חדש' : 'עדכן',
                color: Colors.orange,
                onTap: () {
                  if (formKey.currentState.validate()) {
                    // usersProvider.updateUser(user: user, isRegistering: widget.user == null ? true : false);
                    Navigator.of(context).pop();
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
