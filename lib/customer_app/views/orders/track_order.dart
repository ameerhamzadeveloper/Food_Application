import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/customer_app/model/drop_down_list.dart';
import 'package:food_delivery_app/customer_app/model/profile_provider.dart';
import 'package:food_delivery_app/customer_app/views/orders/track_deli_boy.dart';
import 'package:provider/provider.dart';
class TrackOrder extends StatefulWidget {
  final String docRef;
  TrackOrder({this.docRef});
  @override
  _TrackOrderState createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  var stream = FirebaseFirestore.instance;
  double lat;
  double long;
  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<ProfileProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Track Order"),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              onChanged: (OrderDropDown name){
                print(name.namel);
                if(name.namel == "Track Delivery Boy"){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => TrackDeliBoy(lat: lat, long: long,docRef: widget.docRef,)
                  ));
                }
              },
              icon: Icon(Icons.more_vert,color: Colors.white,),
              items: OrderDropDown.nameList().map((name) => DropdownMenuItem(
                value: name,
                child: Text(name.namel),
              )).toList(),
            ),
          )
        ],
      ),
      body: StreamBuilder(
        stream: stream.collection('orders').doc(widget.docRef).snapshots(),
        builder: (ctx,snapshot){
          print(snapshot.data['totalItems']['items'].length);
          if(snapshot.hasData){
            lat = snapshot.data['customerLat'];
            long = snapshot.data['customerLong'];
            print(lat);
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(50),
                        bottomLeft: Radius.circular(50),
                      ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(kImageUrlEnd+snapshot.data['resturantImage'])
                      )
                    ),
                  ),
                  SizedBox(height: 10,),
                 Padding(
                   padding: const EdgeInsets.all(20.0),
                   child: Column(
                     children: [
                       Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text("Order Details",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                         ],
                       ),
                       SizedBox(height: 20,),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text("Your Order Number"),
                           Text("#${snapshot.data['orderId']}",style: TextStyle(fontWeight: FontWeight.bold),),
                         ],
                       ),
                       SizedBox(height: 5,),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text("Your Order From"),
                           Text(snapshot.data['resturantName'],style: TextStyle(fontWeight: FontWeight.bold),),
                         ],
                       ),
                       SizedBox(height: 5,),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text("Delivery Address"),
                           Text(snapshot.data['customerAddress'],style: TextStyle(fontWeight: FontWeight.bold),),
                         ],
                       ),
                       SizedBox(height: 5,),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text("Order Status"),
                           Text(snapshot.data['orderStatus'],style: TextStyle(fontWeight: FontWeight.bold),),
                         ],
                       ),
                       SizedBox(height: 20,),
                       Divider(),
                     ],
                   ),
                 ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data['totalItems']['items'].length,
                    itemBuilder: (ctx,i){
                      var list = snapshot.data['totalItems']['items'][i];
                      return Padding(
                        padding: const EdgeInsets.only(left:30.0,right: 30.0),
                        child: Column(
                          children: [
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("1x",style: TextStyle(fontWeight: FontWeight.w600),),
                                Text(list['itemName']),
                                Text(list['itemPrice']),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        SizedBox(height: 20,),
                        Divider(),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Subtotal",style: TextStyle(fontWeight: FontWeight.w600),),
                            Text("SAR ${snapshot.data['totalPrice'].toString()}")
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Delivery fee"),
                            Text("SAR ${snapshot.data['deliveryFee'].toString()}")
                          ],
                        ),
                        SizedBox(height: 10,),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.grey[200],
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total (inc. VAT)",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                          Text("SAR ${snapshot.data['totalPrice'].toString()}")
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }else{
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }
}
