import 'package:flutter/material.dart';
import 'package:mem_bank/models/person.dart';
import 'package:mem_bank/screens/home/map_screen.dart';
import 'package:mem_bank/screens/home/view_likes.dart';
import 'package:mem_bank/screens/home/view_events.dart';
import 'package:mem_bank/services/database.dart';
import 'package:mem_bank/services/auth.dart';

class MemoryTile extends StatelessWidget {

  final Person person;

  MemoryTile({required this.person});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top:8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        color: Colors.cyan,
        child: ListTile(
          onLongPress: (){
            //option to delete
            showMenu(
                context: context,
                position: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
              color: Colors.teal,
              elevation: 25.0,
              items: [
                PopupMenuItem(
                  child: Text("Delete ${person.name}"),
                  onTap: (){
                    DatabaseService(uid: AuthService().getUid()).deleteUserEntry(person.name);
                  }
                ),
              ],
            );
          },
          onTap: (){
            showMenu(
                context: context,
                position: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
                color: Colors.teal,
                elevation: 25.0,
                items: [
                  PopupMenuItem(
                      child: Text("See ${person.name}'s events"),value: '1'
                  ),
                  PopupMenuItem(
                      child: Text("See ${person.name}'s likes"),value: '2'
                  ),
                  PopupMenuItem(
                      child: Text("Find a place for ${person.name}"),value: '3',
                  ),
                ],
            ).then((itemSelected) {
              if(itemSelected == '1'){
                if(person.events.length >= 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewEvents(person: person)),
                   );
                }else{
                  //add events
                }
              }
              if(itemSelected == '2') {
                if (person.likes.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewLikes(person: person)),
                  );
                } else {
                  //add Likes
                }
              }
              if(itemSelected == '3') {
                if (person.likes.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MapScreen(person: person)),
                  );
                } else {
                  //add Likes
                }
              }

            });//showMenu
          },//display all information on Person
          leading: Icon(
            Icons.person,
            size: 40.0,
            color: Colors.deepPurple,

          ),
          //title: Text(person.name.name),
          title: Text(person.name),
          subtitle: Text('Likes ${person.likes.values}')
            //${person.likes.entries.firstWhere((element) => element.key == 'colors').value}
        ),
      )
    );
  }
}

