import 'package:flutter/material.dart';
import 'package:mem_bank/models/person.dart';
import 'package:mem_bank/screens/home/view_likes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mem_bank/services/auth.dart';
import 'package:mem_bank/services/database.dart';

class LikesTile extends StatelessWidget {

  final Person person;
  TextEditingController _colorscontroller = TextEditingController();
  TextEditingController _foodscontroller = TextEditingController();
  TextEditingController _placescontroller = TextEditingController();

  LikesTile({required this.person});

  @override
  Widget build(BuildContext context) {
  final _formKey = GlobalKey<FormState>();

  void _showPlaceEditPanel(){
    showModalBottomSheet(context: context, builder: (context){
      return Form(
          key: _formKey,
          child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _placescontroller,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "Add places separated by comma",
                  ),
                ),
                ElevatedButton(
                  onPressed: (){
                    List<String>  places = _placescontroller.text.split(',');
                    DatabaseService(uid: AuthService().getUid()).addPlaces(person.name, places);
                    Navigator.pop(context);
                  },
                  child: Text('Add Places'),
                ),
              ]
          )
      );
    });
  };

    void _showFoodEditPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                controller: _foodscontroller,
                  decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Add foods separated by comma",
                  ),
                ),
                ElevatedButton(
                onPressed: (){
                List<String>  foods = _foodscontroller.text.split(',');
                DatabaseService(uid: AuthService().getUid()).addFoods(person.name, foods);
                Navigator.pop(context);
                },
                child: Text('Add Foods'),
                ),
              ]
            )
        );
      });
    };
    void _showColorEditPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _colorscontroller,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Add colors separated by comma",
                ),
              ),
              ElevatedButton(
                onPressed: (){
                  List<String>  colors = _colorscontroller.text.split(',');
                  DatabaseService(uid: AuthService().getUid()).addColors(person.name, colors);
                  Navigator.pop(context);
                },
                child: Text('Add Colors'),
              ),
            ]
          ),
        );
      });
    }
    return Column(

        children: [
          Card(
            margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 10.0),
            color: Colors.cyan,
            elevation: 10,
            child: ListTile(
              onTap: (){
                _showColorEditPanel();
              },//display all information on Person
              leading: Icon(
                Icons.favorite,
                color: Colors.pink,
              ),
              //title: Text(person.name.name),
              title: Text("Colors"),
              subtitle: Text(person.likes.entries.elementAt(2).value.toString())
            //${person.likes.entries.firstWhere((element) => element.key == 'colors').value}
          ),
        ),
          Card(
            color: Colors.cyan,
            margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 10.0),
            elevation: 10,
            child: ListTile(
                onTap: (){
                  _showPlaceEditPanel();
                },//display all information on Person
                leading: Icon(
                  Icons.favorite,
                  color: Colors.pink,
                ),
                //title: Text(person.name.name),
                title: Text("Places"),
                subtitle: Text(person.likes.entries.elementAt(1).value.toString())
              //${person.likes.entries.firstWhere((element) => element.key == 'colors').value}
            ),
          ),
          Card(
            color: Colors.cyan,
            margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 10.0),
            elevation: 10,
            child: ListTile(
                onTap: (){
                  _showFoodEditPanel();
                },//display all information on Person
                leading: Icon(
                  Icons.favorite,
                  color: Colors.pink,
                ),
                //title: Text(person.name.name),
                title: Text("Food"),
                subtitle: Text(person.likes.entries.elementAt(0).value.toString())
              //${person.likes.entries.firstWhere((element) => element.key == 'colors').value}
            ),
          )
    ]
    );
  }
}