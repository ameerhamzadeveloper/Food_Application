import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/common_widgets/map_pin_pill.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/customer_app/model/pin_pill_info.dart';
import 'package:food_delivery_app/customer_app/views/orders/delivery_chat_screen.dart';
import 'package:food_delivery_app/delivery_boy_app/models/deli_map_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class TrackDeliBoy extends StatefulWidget {
  final double lat;
  final double long;
  String docRef;
  TrackDeliBoy({@required this.lat, @required this.long,this.docRef});
  @override
  _TrackDeliBoyState createState() => _TrackDeliBoyState();
}

class _TrackDeliBoyState extends State<TrackDeliBoy> {
  Completer<GoogleMapController> completer = Completer();
  static LatLng latLng = LatLng(24.832234,67.062513);
  var createdController;

  LatLng initPostition = latLng;

  onCameraMove(CameraPosition position){
    initPostition = position.target;
  }
  double CAMERA_ZOOM = 16;
  double CAMERA_TILT = 80;
  double CAMERA_BEARING = 30;
  double pinPillPosition = -100;
  BitmapDescriptor sourceIcon;
  PinInformation currentlySelectedPin = PinInformation(
      pinPath: '',
      avatarPath: '',
      location: LatLng(0, 0),
      locationName: '',
      labelColor: Colors.grey);
  PinInformation sourcePinInfo;
  FirebaseFirestore strem = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
    inti(context);
  }
  inti(BuildContext context){
    strem.collection('orders').doc(widget.docRef).snapshots().listen((event) {
      print(event.data()['customerLat']);
      Provider.of<DeliMapModel>(context,listen: false).updatePinOnMap(createdController, widget.lat, widget.long);
    });
  }
  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<DeliMapModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery Boy Name"),
      ),
      body: Stack(
        children: [
          GoogleMap(
            // myLocationEnabled: true,
            compassEnabled: true,
            initialCameraPosition:
            CameraPosition(target: latLng, zoom: CAMERA_ZOOM,
              tilt: CAMERA_TILT,
              bearing: CAMERA_BEARING,),
            markers: pro.deliBoyMarker,
            onCameraMove: onCameraMove,
            onMapCreated:  (GoogleMapController controller) async{
              createdController = controller;
              completer.complete(controller);
              print(widget.lat);
              await pro.addDeliveryBoyMarkerOnMap(controller, widget.lat, widget.long);
            },
            mapType: MapType.normal,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: MaterialButton(
                color: kThemeColor,
                height: 50,
                onPressed: (){
                  strem.collection('orders').doc(widget.docRef).update({
                    'customerLat': 37.395660,
                    'customerLong': -121.967071,
                  });
                  // showModalBottomSheet(
                  //   context: context,
                  // isScrollControlled: true,
                  // builder: (context) => Container(
                  // padding: EdgeInsets.only(
                  // bottom: MediaQuery.of(context)
                  //     .viewInsets
                  //     .bottom),
                  // child: DeliveryChatScreen(),
                  // ));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.chat,color: Colors.white,),
                    SizedBox(width: 10,),
                    Text("Chat",style: TextStyle(color:Colors.white),),
                  ],
                )
              ),
            ),
          )
        ],
      ),
    );
  }
}

