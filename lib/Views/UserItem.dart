import 'package:BridgeTeam/Components/shadow_container.dart';
import 'package:BridgeTeam/Model/User2.dart';
import 'package:BridgeTeam/Views/user_details_page.dart';
import 'package:BridgeTeam/Views/user_password_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserItem extends StatelessWidget {
  final User2 user;
  const UserItem({
    this.user,
    Key key,
  }) : super(key: key);
@override
  Widget build(BuildContext context) {
    return ShadowContainer(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(user.name,style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.normal)),
                  SizedBox(height: 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(user.email ,style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.normal)),
                    ],
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        new MaterialPageRoute<Null>(
                            builder: (BuildContext context) {
                              return UserDetailsPage(
                                user: user,
                              );
                            },
                            fullscreenDialog: true),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.orange), borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        'שנה',
                        style: TextStyle(fontSize: 15, color: Theme.of(context).buttonColor),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        new MaterialPageRoute<Null>(
                            builder: (BuildContext context) {
                              return UserPasswordPage(
                                user: user,
                              );
                            },
                            fullscreenDialog: true),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.orange), borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        'סיסמה',
                        style: TextStyle(fontSize: 15, color: Theme.of(context).buttonColor),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}