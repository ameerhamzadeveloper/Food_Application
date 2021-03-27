import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/delivery_boy_app/models/deli_map_model.dart';
import 'package:food_delivery_app/delivery_boy_app/models/deli_profile_provider.dart';
import 'package:food_delivery_app/delivery_boy_app/views/home_page/map_route.dart';
import 'package:food_delivery_app/delivery_boy_app/views/home_page/resturant_map_route.dart';
import 'package:food_delivery_app/resturant_app/model/orders_porvider.dart';
import 'package:food_delivery_app/resturant_app/model/resturant_profile_provider.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
class CurrentOrderBoy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DeliProfileProvider>(context);
    final provid = Provider.of<OrdersProvider>(context);
    final mapPro = Provider.of<DeliMapModel>(context);
    var stream = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text("Current Order"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder(
            stream: stream.collection('orders').where("deliveryBoyId" ,isEqualTo: provider.userId).snapshots(),
            builder: (ctx,snapshot){
              print(snapshot.data.docs.length.toString());
              if(snapshot.data.docs.length == 0){
                return Center(child: Text("No Orders"),);
              }else if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: Text("No Orders"),);
              }else if(snapshot.hasData && snapshot.data.docs.length > 0){
                var list = snapshot.data.docs[0];
                return Card(
                  elevation: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("No #1"),
                            Text("Order No : ${list['orderId']}"),
                          ],
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.docs[0]['totalItems']['items'].length,
                          itemBuilder: (ctx,i){
                            var list2 = list['totalItems']['items'][i];
                            return Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("$i"),
                                  Text("${list2['itemName']}"),
                                  Text("1x"),
                                  Text("${list2['itemPrice']} SAR"),
                                ],
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 20,),
                        Text("Resturant : ${['resturantName']}"),
                        SizedBox(height: 10,),
                        Text("Customer Name : ${list['customerName']}"),
                        SizedBox(height: 10,),
                        Text("Customer Phone : ${list['customerPhone']}"),
                        SizedBox(height: 10,),
                        Text("Customer Address : ${list['customerAddress']}"),
                        SizedBox(height: 10,),
                        Text("Total : 150 SAR"),
                        SizedBox(height: 20,),
                        list['deliveryBoyStatus'] == "Active" ?
                        MaterialButton(
                          color: kThemeColor,
                          minWidth: MediaQuery.of(context).size.width,
                          onPressed: (){
                            print(list['customerLat']);
                            Future.delayed(Duration.zero).then((value){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => ResturantRoute(lat: list['customerLat'],long: list['customerLong'],)
                              ));
                            });
                          },
                          child: Text("Resturant Route",style: TextStyle(color: Colors.white),),
                        ):
                        MaterialButton(
                          color: kThemeColor,
                          minWidth: MediaQuery.of(context).size.width,
                          onPressed: (){
                            print(list['customerLat']);
                            Future.delayed(Duration.zero).then((value){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => MapRoute(lat: list['customerLat'],long: list['customerLong'],)
                              ));
                            });
                          },
                          child: Text("User Route",style: TextStyle(color: Colors.white),),
                        ),
                        MaterialButton(
                          color: kThemeColor,
                          minWidth: MediaQuery.of(context).size.width,
                          onPressed: (){
                            if(list['deliveryBoyStatus'] == "Active"){
                              stream.collection('orders').doc(snapshot.data.docs[0]['orderId']).update({
                                'deliveryBoyStatus': 'Picked',
                              });
                            }else{
                              stream.collection('orders').doc(snapshot.data.docs[0]['orderId']).update({
                                'deliveryBoyStatus': 'Delivered',
                              });
                              mapPro.completeOrderInDB(snapshot.data.docs[0]['orderId']);
                              // stream.collection('orders').doc(snapshot.data.docs[0]['orderId']).delete().then((value){
                              //   provid.deliverToBoy(list['orderId'], "Delivered");
                              // });
                            }

                          },
                          child: Text(list['deliveryBoyStatus'] == 'Active' ? "Picked" : "Deliver",style: TextStyle(color: Colors.white),),
                        )
                      ],
                    ),
                  ),
                );
              }else{
                return Center(child: Text("No current order"),);
              }
            },
          )
      ),
    );
  }

}
