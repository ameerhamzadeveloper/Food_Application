import 'package:flutter/material.dart';
import 'package:food_delivery_app/delivery_boy_app/models/dash_order.dart';
import 'package:food_delivery_app/delivery_boy_app/models/deli_recent_order.dart';
import 'package:food_delivery_app/delivery_boy_app/views/orders/view_order.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DeliRecentOrders extends StatefulWidget {
  @override
  _DeliRecentOrdersState createState() => _DeliRecentOrdersState();
}

class _DeliRecentOrdersState extends State<DeliRecentOrders> {
  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<DashOrders>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Recent Orders"),
        ),
        body: Container(
          child: ListView.builder(
            itemCount: null == pro.orders ? 0 :pro.orders.length,
            itemBuilder: (ctx,i){
              var ord = pro.orders[i];
              var date = ord.date;
              var finalDate = DateFormat('yyyy-MM-dd').format(date);
              return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => DeliViewOrder(
                        totalPrice: ord.totalPrice,
                        orderStatus: ord.orderStatus,
                        orderId: ord.orderId,
                        customerAddress: ord.customerAddress,
                        customerName: ord.uName,
                        date: finalDate,
                        deliveryPrice: ord.deliveryFee,
                        orders: pro.orders,
                        userImage: ord.userImg,
                        itemIndex: i,
                        resturantName: ord.bName,
                      )
                  ));
                },
                child: Card(
                  child: ListTile(
                    leading: ClipOval(
                      child: Image.network(
                        "https://tripps.live/tripp_food/${ord.userImg}",
                        fit: BoxFit.fill,
                        height: 80,
                        width: 60,
                      ),
                    ),
                    title: Text(ord.uName),
                    subtitle: Text(ord.customerAddress),
                    trailing: Text(finalDate),
                  ),
                ),
              );
            },
          ),
        )
    );
  }
}
