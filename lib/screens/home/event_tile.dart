import 'package:flutter/material.dart';
import 'package:mem_bank/models/person.dart';
import 'package:mem_bank/screens/home/view_likes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mem_bank/services/auth.dart';
import 'package:mem_bank/services/database.dart';
import 'package:mem_bank/models/person.dart';

class EventsTile extends StatelessWidget {

  final Map<String,dynamic> event;
  final Person person;

  EventsTile({required this.event,required this.person});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
      child: Card(
        elevation: 10,
        child: ListTile(
          onTap: (){
            //Show suggestions (google api call)
          },
          onLongPress: (){
            //option to delete
            showMenu(
              context: context,
              position: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
              color: Colors.teal,
              elevation: 25.0,
              items: [
                PopupMenuItem(
                    child: Text("Delete ${event.values.last}"),
                    onTap: (){
                      DatabaseService(uid: AuthService().getUid()).deleteUserEvent(person.name, event.values.last,event.values.first);
                    }
                ),
              ],
            );
          },//display all information on Person
          leading: Icon(
            Icons.calendar_today,
            size: 40.0,
            color: Colors.deepPurple,
          ),
          title: Text(
            '${event.values.elementAt(1)}',
            style: TextStyle(

            ),
          ),
          subtitle: Text('On ${event.values.elementAt(0)}'),

        ),
      ),
    );
  }
}