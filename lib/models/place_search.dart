

class PlaceSearch {
  final String description;
  final String place_id;

  PlaceSearch({required this.description, required this.place_id});

  factory PlaceSearch.fromJson(Map<String,dynamic> json){
    return PlaceSearch(
      description: json['description'],
      place_id: json['place_id']
    );
  }
}