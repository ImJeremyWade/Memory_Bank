

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mem_bank/services/database.dart';
import 'package:mem_bank/screens/authenticate/SignInScreen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mem_bank/models/person.dart';
class new_Memory extends StatefulWidget {
  new_Memory({Key? key}) : super(key: key);
  @override

  _newMemoryState createState() => _newMemoryState();
}
class _newMemoryState extends State<new_Memory> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _eventnamecontroller = TextEditingController();
  TextEditingController _eventdatecontroller = TextEditingController();
  TextEditingController _foodtypescontroller = TextEditingController();
  TextEditingController _placetypescontroller = TextEditingController();
  TextEditingController _colorscontroller = TextEditingController();
  Future<void> _saveentry() async{
    dynamic id = auth.currentUser?.uid;
    String name = _namecontroller.text;
    // String event_name = _eventnamecontroller.text;
    // String event_date = _eventdatecontroller.text;
    // List<String> food_types = _foodtypescontroller.text.split(',');
    // List<String>  place_types = _placetypescontroller.text.split(',');
    // List<String>  colors = _colorscontroller.text.split(',');

    DatabaseService(uid: id).addUserData(Person(name: name,events: [],likes: {}));
    Navigator.of(context).pop();
  }
  Widget build(BuildContext context){

    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black54,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Add a new Memory'
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              controller: _namecontroller,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: "Enter someone's name",
              ),
            ),
          ),
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          //   child: TextFormField(
          //     controller: _foodtypescontroller,
          //     decoration: const InputDecoration(
          //       border: UnderlineInputBorder(),
          //       labelText: "Enter list of comma separated food likes",
          //     ),
          //   ),
          // ),
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          //   child: TextFormField(
          //     controller: _placetypescontroller,
          //     decoration: const InputDecoration(
          //       border: UnderlineInputBorder(),
          //       labelText: "Enter list of comma separated favorite places",
          //     ),
          //   ),
          // ),
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          //   child: TextFormField(
          //     controller: _colorscontroller,
          //     decoration: const InputDecoration(
          //       border: UnderlineInputBorder(),
          //       labelText: "Enter list of comma separated favorite colors",
          //     ),
          //   ),
          // ),
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          //   child: TextFormField(
          //     controller: _eventnamecontroller,
          //     decoration: const InputDecoration(
          //       border: UnderlineInputBorder(),
          //       labelText: "Enter event name",
          //     ),
          //   ),
          // ),
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          //   child: TextFormField(
          //     controller: _eventdatecontroller,
          //     decoration: const InputDecoration(
          //       border: UnderlineInputBorder(),
          //       labelText: "Enter event date",
          //     ),
          //   ),
          // ),
          Row(children: [
            TextButton(
              child: Text("Save", style: TextStyle(color: Colors.teal)),
              onPressed: (){
                _saveentry();
              },
            )
          ],),
        ]
      ),
    );
  }
}