import 'package:flutter/material.dart';
import 'package:BridgeTeam/Views/listview_rooms.dart';
import 'package:BridgeTeam/services/auth.dart';

class LoginWidget extends StatefulWidget {
  LoginWidget({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _LoginWidget createState() => _LoginWidget();
}

enum FormType {
  login,
  register,
}

class EmailFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Email can\'t be empty' : null;
  }
}

class PasswordFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Password can\'t be empty' : null;
  }
}

class _LoginWidget extends State<LoginWidget> {
  final AuthService _auth = AuthService();
  String _email = '';
  String _password = '';
  String error = '';

  FormType _formType = FormType.login;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextStyle style =
      TextStyle(fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor:  const Color(0xFF144464),
          title: Center(
              child: Text("Bridge",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold))),
          leading: new Visibility(
            visible: false,
            child: IconButton(
              icon: new Icon(
                Icons.keyboard_return,
                color: Colors.white,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
        body: Container(
          decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [const Color(0xFF003C64), const Color(0xFF428879)],
                  begin: FractionalOffset.topLeft,
                  end: FractionalOffset.bottomRight,
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp)),
          child: Center(
            child: Container(
             // color: Color.fromRGBO(
                //  134, 165, 195, 9), //Color.fromRGBO(58, 66, 86, 1.0),

              child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: buildInputs() + buildSubmitButtons()),
                  )),
            ),
          ),
        ));
  }

  List<Widget> buildInputs() {
    return <Widget>[
      //SizedBox(height: 45.0),
      TextFormField(
        obscureText: false,
        style: style,
        decoration: InputDecoration(
            filled: true,
            fillColor: Color.fromRGBO(
                200, 201, 202, 1.0), //Color.fromRGBO(64, 75, 96, 9),

            //hintStyle: TextStyle(fontFamily: 'Montserrat', fontSize: 10.0 , color: Colors.white),
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "אימייל",
            hintStyle: TextStyle(
                fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.white),
            border: OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(5.0))),
        keyboardType: TextInputType.emailAddress,
        validator: EmailFieldValidator.validate,
        onSaved: (String value) => _email = value,
      ),

      SizedBox(height: 10.0),
      TextFormField(
        obscureText: true,
        style: style,
        decoration: InputDecoration(
            filled: true,
            fillColor: Color.fromRGBO(
                200, 201, 202, 1.0), //Color.fromRGBO(64, 75, 96, 9),
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            //  hintStyle: TextStyle(fontFamily: 'Montserrat', fontSize: 10.0 , color: Colors.white),
            hintText: "סיסמה",
            hintStyle: TextStyle(
                fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.white),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
        validator: PasswordFieldValidator.validate,
        onSaved: (String value) => _password = value,
      ),

      SizedBox(height: 10.0),
    ];
  }

  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return <Widget>[
        Material(
          // elevation: 5.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.orange,
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () => validateAndSubmit(context),
            child: Text("כניסה",
                textAlign: TextAlign.center,
                style: style.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ),
        FlatButton(
          child: Text('חשבון חדש',
              style: TextStyle(fontSize: 15.0, color: Colors.white)),
          onPressed: moveToRegister,
        ),
        SizedBox(
          height: 15.0,
        ),
      ];
    } else {
      return <Widget>[
        Material(
          //  elevation: 5.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.orange,
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () => validateAndSubmit(context),
            child: Text("צור חשבון",
                textAlign: TextAlign.center,
                style: style.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ),
        FlatButton(
          child: Text('כניסה ?',
              style: TextStyle(fontSize: 20.0, color: Colors.white)),
          onPressed: moveToLogin,
        ),
        SizedBox(
          height: 15.0,
        ),
      ];
    }
  }

  bool validateAndSave() {
    final FormState form = formKey.currentState;
    if (form.validate()) {
      form.save();

      return true;
    }
    return false;
  }

  Future<void> validateAndSubmit(BuildContext context) async {
    if (validateAndSave()) {
      print(_email);
      print(_password);
      dynamic result =
          await _auth.signInWithEmailAndPassword(_email, _password);
      if (result == null) {
        setState(() => error = 'could not sign in with those credentials.');
      }
      if (result != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ListViewRooms()),
        );
      }
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }
}
