// class Person{
//   final String name;
//   Person({required this.name});
// }


class Likes{
  final List<String> colors;
  final List<String> place_types;
  final List<String> food_types;

  Likes({required this.colors,required this.place_types,required this.food_types});

}

class Events{
  final String event_name;
  final String event_date;

  Events({required this.event_name,required this.event_date});
}

class Person{
  final String name;
  final List<dynamic> events;
  final Map<String, dynamic> likes;
  Person({required this.name,required this.events,required this.likes});
}

class People{
  final Map<String, dynamic> person;

  People({required this.person});
}
