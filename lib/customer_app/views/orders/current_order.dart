import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/customer_app/model/profile_provider.dart';
import 'package:food_delivery_app/customer_app/model/resturant/resturants_providers.dart';
import 'package:food_delivery_app/customer_app/views/orders/track_order.dart';
import 'package:provider/provider.dart';
class CurrentOrders extends StatefulWidget {
  @override
  _CurrentOrdersState createState() => _CurrentOrdersState();
}

class _CurrentOrdersState extends State<CurrentOrders> {
  String time;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final stream = FirebaseFirestore.instance;
    final pro = Provider.of<ProfileProvider>(context);
    final ordPro = Provider.of<NearResturantsProvider>(context);
     return Scaffold(
      body: StreamBuilder(
        stream: stream.collection('orders').where("customerId" ,isEqualTo: pro.userid).snapshots(),
        builder: (context,snapshort){
          if(snapshort.data != null){
          if(snapshort.data.docs.length == 0){
            return Center(
              child: Text("No Orders"),
            );
            }else if(snapshort.hasData){
            ordPro.isCurrentOrder = true;
            return ListView.builder(
              itemCount: snapshort.data.docs.length,
              itemBuilder: (ctx,i){
                if(snapshort.data.docs[i]['deliveryBoyStatus'] == "Active"){
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: 490,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Column(
                          children: [
                            SizedBox(height: 20,),
                            Text("12 min",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                            SizedBox(height: 10,),
                            Text("Your Food is Preparing....",style: TextStyle(fontSize: 24),),
                            Container(
                                height: 300,
                                width: MediaQuery.of(context).size.width / 2,
                                child: Image.asset("images/food_prepare.gif")),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MaterialButton(
                                height: 50,
                                minWidth: MediaQuery.of(context).size.width,
                                color: kThemeColor,
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => TrackOrder(docRef: snapshort.data.docs[0]['orderId'],)
                                  ));
                                },
                                child: Text("Track Order",style: TextStyle(color: Colors.white),),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }else{
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: 490,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Column(
                          children: [
                            SizedBox(height: 20,),
                            Text("12 min",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                            SizedBox(height: 10,),
                            Text("Your Food is On the Way....",style: TextStyle(fontSize: 24),),
                            Container(
                                height: 300,
                                width: MediaQuery.of(context).size.width / 2,
                                child: Image.asset("images/deliveryboy.gif")),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MaterialButton(
                                height: 50,
                                minWidth: MediaQuery.of(context).size.width,
                                color: kThemeColor,
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => TrackOrder(docRef: snapshort.data.docs[0]['orderId'],)
                                  ));
                                },
                                child: Text("Track Order"),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
            );
          }else if(snapshort.connectionState == ConnectionState.waiting){
            return Center(child: Text("No Current Order"),);
          }else{
            return Center(child: Text("No Current Order"),);
          }}else{
            return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(kThemeColor),),);
          }
        },
      ),
    );
  }
}