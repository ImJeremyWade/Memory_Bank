import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mem_bank/blocs/application_bloc.dart';
import 'package:mem_bank/models/person.dart';
import 'package:provider/provider.dart';
import '../../models/place.dart';
import 'dart:math';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key, required this.person}) : super(key: key);

  final Person person;


  @override
  State<MapScreen> createState() => _map_screenState();
}

class _map_screenState extends State<MapScreen> {

  Completer<GoogleMapController> _mapController = Completer();
  late StreamSubscription locationSubscription;
  late StreamSubscription boundsSubscription;

  @override
  void initState() {
    final applicationBloc = Provider.of<ApplicationBloc>(context,listen: false);
    locationSubscription = applicationBloc.selectedLocation.stream.asBroadcastStream().listen((place) {
      if (place != null){
        _goToPlace(place);
      }
    });

    boundsSubscription = applicationBloc.bounds.stream.listen((bounds) async{
      final GoogleMapController controller = await _mapController.future;
      controller.animateCamera(CameraUpdate.newLatLngBounds(bounds,50.0));
    });
    super.initState();
  }

  @override
  void dispose() {
    final applicationBloc = Provider.of<ApplicationBloc>(context,listen: false);
    applicationBloc.dispose();
    locationSubscription.cancel();
    boundsSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var person = widget.person;

    final applicationBloc = Provider.of<ApplicationBloc>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: BackButton(
          color: Colors.black54,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
            'Find a place for ${widget.person.name}'
        ),
        centerTitle: true,
      ),
      body: (applicationBloc.currentLocation == null)
          ? Center(child: CircularProgressIndicator(),)
      : ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.search),
                hintText: 'Enter Location:',
              ),
              onChanged: (value) => applicationBloc.searchPlaces(value),
            ),
          ),
          Stack(
            children:[
              Container(
                height: 400.0,
                child: GoogleMap(

                  mapType: MapType.normal,
                  myLocationEnabled: true,
                  markers: Set<Marker>.of(applicationBloc.markers),
                  initialCameraPosition: CameraPosition(
                    target: LatLng((applicationBloc.currentLocation?.latitude ?? 0.0),applicationBloc.currentLocation?.longitude ?? 0.0),
                    zoom: 14,
                  ),
                  onMapCreated: (GoogleMapController controller){
                    _mapController.complete(controller);
                  },
                ),
              ),
             if(applicationBloc.searchResults != null &&
                 applicationBloc.searchResults?.length != 0) Container(
                height: 400.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  backgroundBlendMode: BlendMode.darken),
                ),
              if(applicationBloc.searchResults != null &&
                  applicationBloc.searchResults?.length != 0) Container(
                height: 400.0,
                child: ListView.builder(
                  itemCount: applicationBloc.searchResults?.length,
                  itemBuilder: (context, index){
                    return ListTile(
                      title: Text(
                          applicationBloc.searchResults?[index].description ?? 'Default',
                          style: TextStyle(color: Colors.white)
                      ),
                      onTap: (){
                        applicationBloc.setSelectedLocation(
                            applicationBloc.searchResults?[index].place_id ?? ''
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
                'Find Nearest',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 8.0,
              children: [
                FilterChip(
                    label: Text('Restaurant'),
                    onSelected: (val){
                      return applicationBloc.togglePlaceType(
                      'restaurant',
                      person.likes.entries.first.value.toList()[Random()
                          .nextInt(person.likes.entries.first.value
                          .toList()
                          .length)],
                      val,
                      );
                    },
                  selected: applicationBloc.place_type == 'restaurant',
                  selectedColor: Colors.indigoAccent,
                  ),
                  FilterChip(
                  label: Text('Random place'),
                  onSelected: (val) {
                    return applicationBloc.togglePlaceType(
                      'fake',
                      person.likes.entries.elementAt(1)
                      .value.toList()[Random()
                              .nextInt(person.likes.entries.elementAt(1).value
                              .toList()
                              .length)],
                          val
                      );
                  },
                  selected: applicationBloc.place_type == 'fake',
                  selectedColor: Colors.blue,
                ),
                FilterChip(
                  label: Text('Florist'),
                  onSelected: (val) {
                    return applicationBloc.togglePlaceType(
                        'florist',
                        '',
                        val
                    );
                  },
                  selected: applicationBloc.place_type == 'florist',
                  selectedColor: Colors.blue,
                ),
                FilterChip(
                  label: Text('Close Random Place'),
                  onSelected: (val) {
                    return applicationBloc.togglePlaceType(
                        'fake#2',
                        person.likes.entries.elementAt(1)
                            .value.toList()[Random()
                            .nextInt(person.likes.entries.elementAt(1).value
                            .toList()
                            .length)],
                        val
                    );
                  },
                  selected: applicationBloc.place_type == 'fake#2',
                  selectedColor: Colors.blue,
                ),
                FilterChip(
                  label: Text('Museum'),
                  onSelected: (val){
                    return applicationBloc.togglePlaceType(
                      'museum',
                      '',//no query just find type
                      val,
                    );
                  },
                  selected: applicationBloc.place_type == 'museum',
                  selectedColor: Colors.indigoAccent,
                ),
                Center(
                    //padding: EdgeInsets.all(8.0),
                    child: Image.network(applicationBloc.getCurrentPhoto(), width: 300, height: 125,),

                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _goToPlace(Place place) async{
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(place.geometry.location.lat,place.geometry.location.lng),
          zoom: 20,
        )
      )
    );
  }
}

