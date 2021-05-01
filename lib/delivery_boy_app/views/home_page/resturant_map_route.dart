import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/delivery_boy_app/models/deli_map_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
class ResturantRoute extends StatefulWidget {
  final double lat;
  final double long;
  ResturantRoute({this.lat,this.long});
  @override
  _ResturantRouteState createState() => _ResturantRouteState();
}

class _ResturantRouteState extends State<ResturantRoute> {
  Completer<GoogleMapController> completer = Completer();
  static LatLng latLng = LatLng(24.832234,67.062513);

  LatLng initPostition = latLng;


  onCameraMove(CameraPosition position){
    initPostition = position.target;
  }
  @override
  void initState() {
    super.initState();
    Geolocator().getPositionStream().listen(
            (Position position) {
          print(position == null ? 'Unknown' : position.latitude.toString() + ', ' + position.longitude.toString());
        });
  }
  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<DeliMapModel>(context);
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition:
            CameraPosition(target: latLng, zoom: 11.0),
            markers: pro.resturantMarker,
            myLocationButtonEnabled: true,
            compassEnabled: true,
            myLocationEnabled: true,
            onCameraMove: onCameraMove,
            onMapCreated:  (GoogleMapController controller) {
              completer.complete(controller);
              pro.addResturantMarkerInMap(controller, widget.lat, widget.long);
              pro.addMyMarkerOnMap(controller);
            },
            mapType: MapType.normal,
          ),
        ],
      ),
    );
  }
}
