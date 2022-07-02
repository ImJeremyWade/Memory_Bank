import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mem_bank/models/person.dart';
import 'package:mem_bank/screens/home/event_tile.dart';
import 'package:mem_bank/screens/home/likes_tile.dart';

class ViewLikes extends StatelessWidget {
  ViewLikes({Key? key,required this.person}) : super(key: key);

  final Person person;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: BackButton(
          color: Colors.black54,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
            "${person.name}'s Likes"
        ),
        centerTitle: true,
      ),
      body: LikesTile(person: person)

    );
  }
}

