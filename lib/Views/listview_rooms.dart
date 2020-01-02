import 'package:flutter/material.dart';
import 'package:hello_world/Model/repository.dart';
import 'package:hello_world/Views/room_card.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

import 'appBar.dart';

class ListViewRooms extends StatefulWidget {
  _ListViewRoomsState createState() => _ListViewRoomsState();
}

class _ListViewRoomsState extends State<ListViewRooms> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  //final List<String> _listViewData = ["Room 1", "Room 2", "Room 3", "Room 4"];

  Repository repository = new Repository();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: BaseAppBar(
          title: Text('title'),
          appBar: AppBar(),
          
        ),
        body: Center(
          child:  FutureBuilder(
            future: repository.getRooms(),
            builder:(BuildContext context , AsyncSnapshot snapshot){
              if(snapshot.data == null){
                 return Container(
                   child:Center(
                     child: Text("Loading ...")
                   )
                   );
              }
              else{
                  return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index){
                    RoomCard roomCard = RoomCard(
                  room: repository.rooms[index],
                );
                return roomCard;
                  },
                );
              }
       

            })
            

          

        ));
  }
}
