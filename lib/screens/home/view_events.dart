import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mem_bank/models/person.dart';
import 'package:mem_bank/screens/home/event_tile.dart';
import 'package:mem_bank/screens/home/likes_tile.dart';
import 'package:mem_bank/services/auth.dart';
import 'package:mem_bank/services/database.dart';

class ViewEvents extends StatefulWidget {
  ViewEvents({Key? key, required this.person}) : super(key: key);
  final Person person;
  @override
  _ViewEventsState createState() => _ViewEventsState();
}
class _ViewEventsState extends State<ViewEvents> {
  @override


  TextEditingController _event_name_controller = TextEditingController();
  TextEditingController _event_date_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    void _showEditPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Form(
          key: _formKey,
          child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _event_name_controller,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "Add event name",
                  ),
                ),
                TextFormField(
                  controller: _event_date_controller,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "Add event date ",
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    String event_name = _event_name_controller.text;
                    String event_date = _event_date_controller.text;
                    DatabaseService(uid: AuthService().getUid()).addEvent(
                        widget.person.name, event_name,event_date);
                    Navigator.pop(context);

                  },
                  child: Text('Add Event'),
                ),
              ]
          ),

        );
      });
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          leading: BackButton(
            color: Colors.black54,
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
              "${widget.person.name}'s Events"
          ),
          centerTitle: true,
        ),
        body: ListView.builder(
            itemCount: widget.person.events.length,
            itemBuilder: (context,index){
              return EventsTile(event: widget.person.events.elementAt(index),person: widget.person);
            }
        ),
      floatingActionButton: FloatingActionButton(

        onPressed: (){
          _showEditPanel();
          setState(() {});
        },
        tooltip: "Add Event",
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}

