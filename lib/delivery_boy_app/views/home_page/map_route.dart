import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/delivery_boy_app/models/deli_map_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapRoute extends StatefulWidget {
 final double lat;
 final double long;
  MapRoute({@required this.lat, @required this.long});

  @override
  _MapRouteState createState() => _MapRouteState();
}

class _MapRouteState extends State<MapRoute> {
  Completer<GoogleMapController> completer = Completer();
  static LatLng latLng = LatLng(24.832234,67.062513);

  LatLng initPostition = latLng;


  onCameraMove(CameraPosition position){
    initPostition = position.target;
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
            markers: pro.routeMarkers,
            onCameraMove: onCameraMove,
            onMapCreated:  (GoogleMapController controller) {
             completer.complete(controller);
              pro.addCustomerMarkerOnDeliverFodd(controller, widget.lat, widget.long);
             pro.addMyMarkerOnMap(controller);
          },
            mapType: MapType.normal,
          ),
        ],
      ),
    );
  }
}
