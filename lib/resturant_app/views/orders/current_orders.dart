import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/resturant_app/model/orders_porvider.dart';
import 'package:food_delivery_app/resturant_app/model/resturant_profile_provider.dart';
import 'package:food_delivery_app/resturant_app/views/orders/chat_screen.dart';
import 'package:provider/provider.dart';

class CurrentOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ResturantProfileProvider>(context);
    final ordPro = Provider.of<OrdersProvider>(context);
    var stream = FirebaseFirestore.instance;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Current Orders"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: stream.collection('orders').where("resturantId" ,isEqualTo: provider.resturantId).snapshots(),
          builder: (ctx,snapshot){
            // print(snapshot.data.docs.length.toString());
            print(provider.resturantId);
            if(snapshot.data != null){
            if(snapshot.data.docs.length == 0){
              return Center(child: Text("No Orders"),);
            }else if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: Text("No Orders"),);
            }else if(snapshot.hasData){
              ordPro.playBackgroundMusic();
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (ctx,index){
                  var list = snapshot.data.docs[index];
                  if(snapshot.data.docs[index]['orderStatus'] == "Preparing" && snapshot.data.docs[index]['resturantId'] == provider.resturantId){
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
                              itemCount: snapshot.data.docs[index]['totalItems']['items'].length,
                              itemBuilder: (ctx,i){
                                var list2 = list['totalItems']['items'][i];
                                return Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("$i"),
                                      Text("${list2['itemName']}"),
                                      Text("${list2['itemQty']}x"),
                                      Text("${list2['itemPrice']} SAR"),
                                    ],
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 10,),
                            Text("Total : ${list['subtotal']} SAR"),
                            SizedBox(height: 20,),
                            MaterialButton(
                              color: kThemeColor,
                              minWidth: MediaQuery.of(context).size.width,
                              onPressed: (){
                                ordPro.deliverToBoy(list['orderId'], "Way");
                                stream.collection('orders').doc(snapshot.data.docs[index]['orderId']).update({
                                  'orderStatus': 'Way',
                                });
                              },
                              child: Text("Deliver to Boy",style:TextStyle(color:Colors.white)),
                            ),
                            MaterialButton(
                              color: kThemeColor,
                              minWidth: MediaQuery.of(context).size.width,
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => DeliverChatScreen(list.id, 'Resturant')
                                ));
                              },
                              child: Text("Chat",style:TextStyle(color:Colors.white)),
                            )
                          ],
                        ),
                      ),
                    );
                  }else{
                    return Center(child: Text("Waiting for Order"),);
                  }
                },
              );
            }
            else{
              return Center(child: Text(""),);
            }}
            return Padding(
              padding: const EdgeInsets.only(top:20.0),
              child: Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(kThemeColor),)),
            );
          },
        )
      ),
    );
  }
}
