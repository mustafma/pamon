import 'package:BridgeTeam/model_providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShadowContainer extends StatelessWidget {
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Widget child;

  const ShadowContainer({this.margin, this.padding, this.child, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: margin ?? EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: padding ?? EdgeInsets.symmetric(horizontal: 12, vertical: 12),


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

      child: child,
    );
  }
}