
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:mem_bank/models/place_search.dart';

import '../models/place.dart';

class PlacesService{
  final key = 'AIzaSyCoS70FabEnjJ24z_zjrbFbbap8yNo-BKc';

  Future<List<PlaceSearch>> getAutoComplete(String search) async{
    var url = (Uri.parse("https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=(cities)&key=$key"));
    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['predictions'] as List;
    return jsonResults.map((place)=>PlaceSearch.fromJson(place)).toList();
  }

  Future<Place> getPlace(String place_id) async{
    var url = (Uri.parse("https://maps.googleapis.com/maps/api/place/details/json?key=$key&place_id=$place_id"));
    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    var jsonResult = json['result'] as Map<String,dynamic>;
    return Place.fromJson(jsonResult);
  }

  Future<List<Place>> getPlaces(double lat, double lng, String placeType, String query) async{
    var url = (Uri.parse("https://maps.googleapis.com/maps/api/place/textsearch/json?query=$query&type=$placeType&location=$lat,$lng&rankby=distance&key=$key"));
    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['results'] as List;
    return jsonResults.map((place)=>Place.fromJson(place)).toList();
  }
}