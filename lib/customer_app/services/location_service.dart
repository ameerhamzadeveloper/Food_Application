import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class LocationService extends ChangeNotifier{

  double lat;
  double long;

  Future<void> getLatLong() async {
    try{
      final position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      lat = position.latitude;
      long = position.longitude;

      print(lat);
    }catch(e){
      print(e);
    }
  }

}