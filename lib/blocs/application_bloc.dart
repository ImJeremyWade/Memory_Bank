
import 'dart:async';

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mem_bank/models/geometry.dart';
import 'package:mem_bank/models/location.dart';
import 'package:mem_bank/models/photo.dart';
import 'package:mem_bank/models/place_search.dart';
import 'package:mem_bank/services/geolocator.dart';
import 'package:mem_bank/services/marker_service.dart';
import 'package:mem_bank/services/places_service.dart';
import 'package:flutter/painting.dart' as paint;
import '../models/place.dart';

class ApplicationBloc with ChangeNotifier{
  final geoLocatorService = GeolocatorService();
  final placesService = PlacesService();
  final markerService = MarkerService();

  Position ?currentLocation;
  List<PlaceSearch> ?searchResults;
  StreamController<Place> selectedLocation = StreamController<Place>.broadcast();
  StreamController<LatLngBounds> bounds = StreamController<LatLngBounds>.broadcast();
  late Place selectedLocationStatic;
  String ?place_type;
  String key = "";
  List<Marker> markers = <Marker>[];
  late String current_photo;

  ApplicationBloc(){
    setCurrentLocation();
    current_photo = 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=100&maxheight=75&photoreference=Aap_uEAU6HyFU0BNc-58RXy-bF2LUoUC5a8uS7dirjVFOPQqPTuQVm0N6j3LRT3kQ7dHI4MggxTVCJx-7B9XBVH92S0cjIHhgYRT_YV3sOmeZayZPtF9KPP8r2ayXJfvN9t_XB48A7OUR6-8E_4GuewbHeTC-d356VUdweedksgPQJ2NrmVz&key=AIzaSyCoS70FabEnjJ24z_zjrbFbbap8yNo-BKc';
  }

  setCurrentLocation() async{
    currentLocation = await geoLocatorService.getCurrentLocation();
    if(currentLocation != null) {
      selectedLocationStatic = Place(
        name: '',
        geometry: Geometry(
            location: Location(
              lat: currentLocation?.latitude ?? 0.0,
              lng: currentLocation?.longitude ?? 0.0
            )
        ),
        placeID: '',
        photo: Photo(photo_reference: ''),
          );
    }
    notifyListeners();
  }

  searchPlaces(String searchTerm) async{
    searchResults = await placesService.getAutoComplete(searchTerm);
    notifyListeners();
  }

  getCurrentPhoto(){
    // if(current_photo == ''){
    //   return ''
    // }
    return current_photo;
  }

  setSelectedLocation(String place_id) async{
    var sLocation = await placesService.getPlace(place_id);
    selectedLocation.add(sLocation);
    selectedLocationStatic = sLocation;
    searchResults = null;
    notifyListeners();
  }
  togglePlaceType(String value,String query, bool selected) async {
    var tmp_place_type;
    if (selected) {
      place_type = value;
    } else {
      place_type = null;
    }
    if (place_type != null) {

      if (place_type == 'fake' || place_type == 'fake#2') {
        tmp_place_type = '';
      }else{
        tmp_place_type = place_type;
      }
        var places = await placesService.getPlaces(
          selectedLocationStatic.geometry.location.lat ?? 0.0,
          selectedLocationStatic.geometry.location.lng ?? 0.0,
          tmp_place_type,
          query,
        );

      markers =[];
      if(places.length > 0 && place_type == 'fake'){
        var tmp_place = places[Random().nextInt(places.length)];
        current_photo = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=200&maxheight=125&photoreference=${tmp_place.photo.photo_reference}&key=$key";
        print(current_photo);
        var newMarker = MarkerService().createMarkerFromPlace(tmp_place/*finds random*/);
        markers.add(newMarker);
      }else if(places.length > 0 && place_type == 'fake#2'){
        current_photo = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=200&maxheight=125&photoreference=${places[0].photo.photo_reference}&key=$key";

        var newMarker = MarkerService().createMarkerFromPlace(places[0]/*finds nearest*/);
        markers.add(newMarker);
      }else{
        current_photo = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=200&maxheight=125&photoreference=${places[0].photo.photo_reference}&key=$key";
        print(current_photo);
        var newMarker = MarkerService().createMarkerFromPlace(places[0]/*finds nearest aka firs in list */);
        markers.add(newMarker);
      }
      //current_photo = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=50&maxheight=50&photoreference=${selectedLocationStatic.photos.photo_reference}&key=$key"

      var locationMarker = MarkerService().createMarkerFromPlace(selectedLocationStatic);
      markers.add(locationMarker);

      var _bounds = MarkerService().bounds(Set<Marker>.of(markers));
      bounds.add(_bounds!);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    selectedLocation.close();
    super.dispose();
  }
}