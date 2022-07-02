import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mem_bank/models/person.dart';
import 'package:mem_bank/screens/home/memories_list.dart';
import 'package:mem_bank/services/auth.dart';
import 'package:mem_bank/services/database.dart';
import 'package:provider/provider.dart';
import 'package:mem_bank/screens/home/new_memory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mem_bank/models/person.dart';
import 'package:mem_bank/screens/home/memory_tile.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Person>>.value (
      value: DatabaseService(uid: _auth.getUid()).memories,
      initialData:[],
      child: Scaffold(
        backgroundColor: Colors.lightBlueAccent[50],
        appBar: AppBar(
          centerTitle: true,
          title: Text('Memory Bank',style: TextStyle(color: Colors.blueAccent[900]),),
          backgroundColor: Colors.deepPurple[300],
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.person,color: Colors.black,),
              label: Text('logout',style: TextStyle(color: Colors.black),),
              onPressed: ()async{
                await _auth.signOut();
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => new_Memory()));
            // DatabaseService(uid: _auth.getUid()).addUserData(
            //   Person(
            //       name: 'Hello',
            //       events: [],
            //       likes: {},
            //   )
            // );
          },
          child: Icon(
            Icons.add,
          ),
        ),
        body: MemoryList(),
      )
    );
  }
}
