import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/customer_app/views/orders/current_order.dart';
import 'package:food_delivery_app/customer_app/views/orders/order_history.dart';
import 'package:food_delivery_app/customer_app/views/orders/view_orders.dart';

class Orders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final stream = FirebaseFirestore.instance;
    String id = '12';
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          leading: Container(),
          title: Text(
            kGetTranslated(context, 'previous_orders')
          ),
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                child: Text("Current Orders"),
              ),
              Tab(
                child: Text("Previous Orders"),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CurrentOrders(),
            OrderHistory()
          ],
        )
      ),
    );
  }
}
