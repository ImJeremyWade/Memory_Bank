import 'package:mem_bank/models/person.dart';
class MyUser {

  final String? uid;
  MyUser({this.uid});
}

class UserData {
  final String uid;
  final String name;
  final Map<String,dynamic> events;
  final Map<String, dynamic> likes;

  UserData({required this.uid, required this.name, required this.events, required this.likes});
}