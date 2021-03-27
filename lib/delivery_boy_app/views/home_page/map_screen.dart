import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/delivery_boy_app/models/deli_profile_provider.dart';
import 'package:food_delivery_app/delivery_boy_app/views/orders/current_order.dart';
import 'package:food_delivery_app/resturant_app/model/resturant_profile_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery_app/delivery_boy_app/models/deli_map_model.dart';


class DeliMapScreen extends StatefulWidget {
  @override
  _DeliMapScreenState createState() => _DeliMapScreenState();
}

class _DeliMapScreenState extends State<DeliMapScreen> {

  Completer<GoogleMapController> completer = Completer();
  static LatLng latLng = LatLng(24.832234,67.062513);

  LatLng initPostition = latLng;

  onCameraMove(CameraPosition position){
    initPostition = position.target;
  }
  onMapCreated (GoogleMapController controller) {
    final prov = Provider.of<DeliMapModel>(context,listen: false);
    completer.complete(controller);
    prov.getUserLatMarker(controller);
    print(prov.lat);

  }
   navigate(){
    showDialog(
      context: context,
      child: AlertDialog(
        content: Container(
          height: 150,
          child: Column(
            children: [
              Text("Resturant Name",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
              Text("4KM",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
              Text(""),
              IconButton(
                onPressed: (){},
                icon: Icon(Icons.check,color: Colors.green,size: 70,),
              )
            ],
          ),
        ),
      )
    );
  }
  FirebaseFirestore strem = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<DeliMapModel>(context);
    final pro = Provider.of<DeliProfileProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text("Waiting for Order"),
        actions: [
          InkWell(
            onTap: (){
              prov.putDeliBoyOnline(context,0);
              Navigator.pop(context);
              print(pro.userId);
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage('images/shutdown.png')
                ),
              ),
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: strem.collection('orders').where("deliveryBoyId",isEqualTo: pro.userId).snapshots(),
        builder: (context,snapshot){
          if(snapshot.hasData && snapshot.data.docs.length > 0){
            return AlertDialog(
              content: Column(
                children: [
                  Text("Resturant Name"),
                  Text("4KM"),
                  Text(""),
                  IconButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => CurrentOrderBoy()
                      ));
                    },
                    icon: Icon(Icons.check,color: Colors.green,),
                  )
                ],
              ),
            );
          }else{
            return Container(
            height: double.infinity,
              child: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition:
                    CameraPosition(target: latLng, zoom: 11.0),
                    markers: prov.markers,
                    onCameraMove: onCameraMove,
                    onMapCreated: onMapCreated,
                    mapType: MapType.normal,
                  ),
                ],
              ),
            );
          }
        },
      )
    );
  }
}
