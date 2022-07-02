
import 'package:mem_bank/models/geometry.dart';
import 'package:mem_bank/models/photo.dart';

class Place{
  final Geometry geometry;
  final String name;
  final String placeID;
  final Photo photo;

  Place({required this.geometry, required this.name, required this.placeID, required this.photo});

  factory Place.fromJson(Map<dynamic,dynamic> parsedJson){
    var results = parsedJson['photos'];
    if(results == null){
      results = [{
        "height" : 1647,
        "html_attributions" : [
          "\u003ca href=\"https://maps.google.com/maps/contrib/104922036182796451660\"\u003eA Google User\u003c/a\u003e"
        ],
        "photo_reference" : "Aap_uEDlF8pzVvUASadDhH3qLChkevuTpA5wuIN6DxAnod3rSHvc_3fgEbZgoSPhmIngU6wdDZOkX5lUmL1P90ckpPdQ_hF4R57eKp_cxTvzr6uaKYXUim-yoxBFf2qGRFe78z2MiUlUMZqNQPO6OTCH9gkEH7z9cJCSuBhAz8NZTriXnoxS",
        "width" : 2928
      }] as List;
    }else{
      results = results as List;
    }
    return Place(
        geometry: Geometry.fromJson(parsedJson['geometry']),
        name: parsedJson['name'],
        placeID: parsedJson['place_id'],
        photo: Photo.fromJson(results.first),
    );
  }
}