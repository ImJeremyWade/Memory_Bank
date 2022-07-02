
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mem_bank/models/myuser.dart';
import 'package:mem_bank/models/person.dart';

class DatabaseService{

  final String? uid;
  DatabaseService({this.uid});
  final CollectionReference memoryCollection = FirebaseFirestore.instance.collection('memories');


  Future setupUserData() async{
    return await memoryCollection.doc(uid).collection('person').doc('Example').set({
      // 'person': [{
      //   'name': 'Testing',
        'events': [{
          'event_name': 'test',
          'event_date': '01/01/2000',
        }],
        'likes': {
          'food_types': ['Pizza', 'toast'],
          'place_types': ['beach'],
          'colors': ['blue'],
        },
      //}]

    });
  }

  void addUserData(Person person) async {
    return await memoryCollection.doc(uid).collection('person').doc(person.name).set ({
        'events': [{
          'event_name': 'Example',
          'event_date': '01/01/2000',
        }],
        'likes': {
          'food_types': [],
          'place_types': [],
          'colors': [],
        }
    });
  }
  Future addColors(String name, List<String> colors) async {
     return await memoryCollection.doc(uid).collection('person').doc(name).set({
       'likes': {
         'colors': FieldValue.arrayUnion(colors),
       }
     },
         SetOptions(merge: true));
   }
  Future addFoods(String name, List<String> foods) async {
    return await memoryCollection.doc(uid).collection('person').doc(name).set({
      'likes': {
        'food_types': FieldValue.arrayUnion(foods),
      }
    },
        SetOptions(merge: true));
  }
  Future addPlaces(String name, List<String> places) async {
    return await memoryCollection.doc(uid).collection('person').doc(name).set({
      'likes': {
        'place_types': FieldValue.arrayUnion(places),
      }
    },
        SetOptions(merge: true));
  }

  Future resetColors(String name) async {
    return await memoryCollection.doc(uid).collection('person').doc(name).set({
      'likes': {
        'colors': [],
      }
    },SetOptions(merge: true));
  }

  Future addEvent(String name, String event_name, String event_date) async{
    return await memoryCollection.doc(uid).collection('person').doc(name).set({
      'events': FieldValue.arrayUnion(
          [{event_name: event_name, event_date: event_date}]),
    },SetOptions(merge: true));
  }

  Future deleteUserEvent(String name, String event_name, String event_date) async {
    print('deleting');print(event_name);print(event_date);print(name);
    return await memoryCollection.doc(uid).collection('person').doc(name).set({
      'events': FieldValue.arrayRemove(
          [{event_name: event_name, event_date: event_date}]),
    },SetOptions(merge: true));

  }

    Future deleteUserEntry(String name) async {
      return await memoryCollection.doc(uid).collection('person').doc(name).delete();
    }

    Stream<List<Person>> get memories {
      //Stream<QuerySnapshot> snapshot_stream = memoryCollection.snapshots();
      print("getting memories: ");
      //print(snapshot_stream.first);
      //print(snapshot_stream.first.toString());
      return memoryCollection.doc(uid).collection('person').snapshots().map(_memoryListFromSnapshot);
    }
    //list memories
    List<Person> _memoryListFromSnapshot(QuerySnapshot snapshot){
      print("in _memorylist");
      return snapshot.docs.map((doc){
        return Person(
            name: doc.id,
            events: doc.get('events'),
            likes: doc['likes'],
        );
      }).toList();
    }

    Stream<UserData> get userData {
      return memoryCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
    }

    UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
      return UserData(
          uid: uid.toString(),
          name: snapshot.get('name') ?? '',
          events: snapshot.get('events'),
          likes: snapshot.get('likes'),
      );
    }

}