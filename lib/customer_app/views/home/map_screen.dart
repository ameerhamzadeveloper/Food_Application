import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/customer_app/services/location_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  static double lat;
  static double long;
  var currentPosition;

  Future<void> getLatLong() async {
    try{
      final position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        lat = position.latitude;
        long = position.longitude;
      });
    }catch(e){
      print(e);
    }
  }

  static Set<Marker> marker = {};
  Completer<GoogleMapController> completer = Completer();


  static LocationService service = LocationService();

  static LatLng latLng =  LatLng(service.lat,service.long);


  LatLng initPostition = latLng;

  onCameraMove(CameraPosition position){
      initPostition = position.target;
  }
  onMapCreated (GoogleMapController controller) {
    completer.complete(controller);
  }
  addmarker() {
   setState(() {
     marker.add(Marker(
         markerId: MarkerId(
           initPostition.toString(),
         ),
         position: initPostition,
         infoWindow: InfoWindow(title: "Your Location")));
   });
  }

  @override
  void initState() {
    super.initState();
    addmarker();
    getLatLong();
    Geolocator().getCurrentPosition().then((currtLatLng){
     setState(() {
       currentPosition = LatLng(currtLatLng.latitude,currtLatLng.longitude);
     });
    });
    print("FLag Current ${currentPosition}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LocationService>(
        builder: (context,data,child){
          return latLng == null ?
              Center(child: CircularProgressIndicator(),)
              :
          Stack(
            children: [
              GoogleMap(
                initialCameraPosition:
                CameraPosition(target: LatLng(data.lat,data.long), zoom: 11.0),
                markers: marker,
                onCameraMove: onCameraMove,
                onMapCreated: onMapCreated,
                mapType: MapType.normal,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: MaterialButton(
                    height: 40,
                    minWidth: MediaQuery.of(context).size.width,
                    color: kThemeColor,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Select"),
                  ),
                ),
              )
            ],
          );
        },
      )
    );
  }
}
