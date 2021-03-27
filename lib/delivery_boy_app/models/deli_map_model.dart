import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery_app/customer_app/model/pin_pill_info.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:food_delivery_app/models/sign_up_model.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class DeliMapModel extends ChangeNotifier{
  double lat;
  double lon;
  String userid;
  String storedEmail;

  get getlat => lat;
  get getlon => lon;

  final Set<Marker> markers = {};
  void getIdEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userid = preferences.getString('id');
    storedEmail = preferences.getString('email');
    print(userid);
  }

  void getUserLatMarker(_controller){
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(lat,lon), zoom: 4.475)));
    MarkerId id = MarkerId(DateTime.now().millisecondsSinceEpoch.toString());
    final Marker marker = Marker(
      markerId: id,
      position: LatLng(lat,lon),
    );
        markers.add(marker);
    notifyListeners();
  }

  void putDeliBoyOnline(context,int status) async{
    final prov = Provider.of<SignUpModel>(context,listen: false);
    String url = "${kServerUrlName}online_boy.php";
    http.Response response = await http.post(url,body: ({
      'email': storedEmail,
      'status': status.toString(),
      'login_id': userid,
      'lat': lat.toString(),
      'long': lon.toString(),
    }));
    var dec = jsonDecode(response.body);
    print(dec);
  }
  void putDeliBoyOffline(context,int status) async{
    final prov = Provider.of<SignUpModel>(context,listen: false);
    String url = "${kServerUrlName}online_boy.php";
    http.Response response = await http.post(url,body: ({
      'email': storedEmail,
      'status': status.toString(),
      'login_id': userid,
      'lat': lat.toString(),
      'long': lon.toString(),
    }));
    var dec = jsonDecode(response.body);
    print(dec);
  }
  final Set<Marker> routeMarkers = {};
  void addCustomerMarkerOnDeliverFodd(controller, lat,long){
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(lat,long), zoom: 4.475)));
    MarkerId id = MarkerId(DateTime.now().millisecondsSinceEpoch.toString());
    final Marker marker = Marker(
      markerId: id,
      position: LatLng(lat,long),
    );
    routeMarkers.add(marker);
    notifyListeners();
  }
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }
  PinInformation sourcePin;
  final Set<Marker> deliBoyMarker = {};
  Future<void> addDeliveryBoyMarkerOnMap(controller, lat,long) async {
    final Uint8List markerIcon =
    await getBytesFromAsset('images/deli_icon.png', 100);
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(lat,long), zoom: 16.475, tilt: 80,bearing: 30)));
    MarkerId id = MarkerId('sourcePin');
    final Marker marker = Marker(
      markerId: id,
      position: LatLng(lat,long),
      icon: BitmapDescriptor.fromBytes(markerIcon),
    );
    deliBoyMarker.add(marker);
    print(deliBoyMarker.length);
    notifyListeners();
  }
  void updatePinOnMap(controlle, lat,long) async {
    final Uint8List markerIcon =
    await getBytesFromAsset('images/deli_icon.png', 100);
    CameraPosition cPosition = CameraPosition(
      zoom: 16,
      tilt: 80,
      bearing: 30,
      target: LatLng(lat, long),
    );
    controlle.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(lat,long), zoom: 16.475, tilt: 80,bearing: 30)));
    deliBoyMarker.removeWhere((m) => m.markerId.value == 'sourcePin');
    deliBoyMarker.add(Marker(
        markerId: MarkerId('sourcePin'),
        onTap: () {},
        position: LatLng(lat,long), // updated position
        icon: BitmapDescriptor.fromBytes(markerIcon)));
    notifyListeners();
  }
  String resturantIconForMap = "images/resturentIcon.png";

  final Set<Marker> resturantMarker = {};
  Future<void> addResturantMarkerInMap(controller, lat,long) async {
    final Uint8List markerIcon =
    await getBytesFromAsset(resturantIconForMap, 100);
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(lat,long), zoom: 16.475, tilt: 80,bearing: 30)));
    MarkerId id = MarkerId('resturantMarker');
    final Marker marker = Marker(
      markerId: id,
      position: LatLng(lat,long),
      icon: BitmapDescriptor.fromBytes(markerIcon),
    );
    resturantMarker.add(marker);
    print(resturantMarker.length);
    notifyListeners();
  }
  Future<void> addMyMarkerOnMap(controller) async {
    final Uint8List markerIcon =
    await getBytesFromAsset('images/deli_icon.png', 100);
    MarkerId id = MarkerId('sourcePin');
    final Marker marker = Marker(
      markerId: id,
      position: LatLng(lat,lon),
      icon: BitmapDescriptor.fromBytes(markerIcon),
    );
    resturantMarker.add(marker);
    print(lat);
    print(resturantMarker.length);
    notifyListeners();
  }

  Future<void> completeOrderInDB(String orderId) async{
    String url = "${kServerUrlName}deli_success.php";
    http.Response response = await http.post(url,body: ({
      'order_id': orderId,
      'order_status': "Completed",
      'deli_boy_id': userid,
      'deli_boy_status': "Delivered",
    }));
    var de = json.decode(response.body);
    print(de);
  }
}