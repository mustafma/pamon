import 'package:BridgeTeam/Components/flat_button_custom.dart';
import 'package:BridgeTeam/Components/page_header.dart';
import 'package:BridgeTeam/Components/text_form_field_validation.dart';
import 'package:BridgeTeam/Model/User2.dart';
import 'package:BridgeTeam/Views/appBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserPasswordPage extends StatefulWidget {
  final User2 user;
  UserPasswordPage({this.user, Key key}) : super(key: key);

  @override
  _UserPasswordPageState createState() => _UserPasswordPageState();
}

class _UserPasswordPageState extends State<UserPasswordPage> {
  User2 user;
  @override
  void initState() {
    user = widget.user;
    user.password = '';
    super.initState();
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
   // final themeProvider = Provider.of<ThemeProvider>(context);
  //  final usersProvider = Provider.of<UsersProvider>(context);
    return Scaffold(
      appBar: BaseAppBar(
          title: Text('ניהול משתמשים',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              textDirection: TextDirection.rtl),
          backButtonVisible: true,
          appBar: AppBar(),
        ),
      body:Container(
        
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

child:Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            Center(
              child:PageHeader(
              title: 'שנה סיסמה',
            )),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Text('${user.name}'),
            ),
            SizedBox(height: 10),
            TextFormFieldValidation(
              hint: 'סיסמה',
              initialValue: user.password,
              onValueChanged: (val) {
                user.password = val;
              },
            ),
            SizedBox(height: 10),
            FlatButtonCustom(
              title: 'עדכן',
              color: Colors.orange,
              onTap: () {
                if (formKey.currentState.validate()) {
                 // usersProvider.updateUserPassword(user: user);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),
      ),
      ) 
    );
  }
}