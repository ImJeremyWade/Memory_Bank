
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googleapis/gamesconfiguration/v1configuration.dart';
import 'package:flutter/services.dart';
import 'package:flutter/painting.dart' as paint;

import '../models/place.dart';

class MarkerService {
  String key = 'AIzaSyCoS70FabEnjJ24z_zjrbFbbap8yNo-BKc';

  LatLngBounds? bounds(Set<Marker> markers){
    if(markers == null || markers.isEmpty){
      return null;
    }
    else{
      return createBounds(markers.map((m) => m.position).toList());
    }
  }

  LatLngBounds createBounds(List<LatLng> positions){
    final southwestLat = positions.map((p) => p.latitude).reduce((value, element) => value < element ? value : element); // smallest
    final southwestLon = positions.map((p) => p.longitude).reduce((value, element) => value < element ? value : element);
    final northeastLat = positions.map((p) => p.latitude).reduce((value, element) => value > element ? value : element); // biggest
    final northeastLon = positions.map((p) => p.longitude).reduce((value, element) => value > element ? value : element);
    return LatLngBounds(
        southwest: LatLng(southwestLat, southwestLon),
        northeast: LatLng(northeastLat, northeastLon)
    );
  }

  Marker createMarkerFromPlace(Place place) {
    var marker_id = place.name;

    return Marker(
      markerId: MarkerId(marker_id),
      draggable: false,
      infoWindow: InfoWindow(
        title: place.name,

      ),
      position: LatLng(place.geometry.location.lat ?? 0.0,place.geometry.location.lng ?? 0.0),
    );
  }

}