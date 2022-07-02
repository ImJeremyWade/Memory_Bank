import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mem_bank/models/person.dart';
import 'package:provider/provider.dart';
import 'package:mem_bank/models/person.dart';
import 'package:mem_bank/screens/home/memory_tile.dart';

class MemoryList extends StatefulWidget {

  @override
  _MemoryListState createState() => _MemoryListState();
}

class _MemoryListState extends State<MemoryList> {
  @override
  Widget build(BuildContext context) {

    final memories = Provider.of<List<Person>>(context);
    print("current data:");
    print(memories);

    if(memories != null){
      memories.forEach((element) {
        print(element.name);
        //print(element.events);
        //print(element.likes);
      });
      }
    return ListView.builder(
        itemCount: memories.length,
        itemBuilder: (context,index){
          return MemoryTile(person: memories[index]);
        }
    );
  }
}
