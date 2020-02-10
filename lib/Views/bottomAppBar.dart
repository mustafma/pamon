import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:flutter/material.dart';

class BaseBottomBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor = Colors.blue;

 // final BottomBar bottomBar;

  BaseBottomBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        color: Color.fromRGBO(64, 75, 96, 9),
        child: new Container(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Text("Powered  By Adamtec",
                    style: TextStyle(
                        color: Colors.white38,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
              ),
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {},
              )
            ],
          ),
        ));
  }


 Widget  alertDialog(BuildContext context) {

//var parser = EmojiParser();
//var sad = Emoji('😥' , 'sad');
//var happy  = Emoji('😃' , 'happy');
//var angry  = Emoji('😡' , 'angry');

//var heart  = Emoji('heart', '❤️');


    return new Row(
      children: <Widget>[
 
      ]
    );
      
  }




  @override
  // TODO: implement preferredSize
  Size get preferredSize => null;
}
