import 'package:flutter/material.dart';
import 'package:food_delivery_app/customer_app/model/my_orders_model.dart';
import 'package:food_delivery_app/customer_app/model/profile_provider.dart';
import 'package:food_delivery_app/customer_app/views/orders/view_orders.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
class OrderHistory extends StatefulWidget {
  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  void initState(){
    super.initState();
    final provider = Provider.of<ProfileProvider>(context,listen: false);
    provider.showORders();
  }
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ProfileProvider>(context);
    return prov.orders == null ? Center(child: Text("No Recent Orders"),):
    Container(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: null == prov.orders ? 0 : prov.orders.length,
        itemBuilder: (ctx,i){
          var ord = prov.orders[0];
          var date = ord.date;
          var finalDate = DateFormat('yyyy-MM-dd').format(date);
          if(prov.orders.isNotEmpty){
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => ViewOrders(
                          addres: ord.customerAddress,
                          orderId: ord.orderId,
                          orderStatus: ord.orderStatus,
                          orders: prov.orders,
                          title: ord.bName,
                          image: ord.resutrantSelfie,
                          date: finalDate,
                          delPrice: ord.deliveryFee,
                          totalPrice: ord.totalPrice,
                          index: i,
                        )));
              },
              child: Card(
                elevation: 5.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Image.network("https://tripps.live/tripp_food/${ord.resutrantSelfie}"),
                    title: Text(ord.bName ?? "Loading"),
                    subtitle: Text(ord.items[0].itemDescription ?? "Loading..."),
                    trailing: Text(finalDate ?? "Loading..."),
                  ),
                ),
              ),
            );
          }else{
            return Center(
              child: Text("No Recent Orders"),
            );
          }
        },
      ),
    );
  }
}
