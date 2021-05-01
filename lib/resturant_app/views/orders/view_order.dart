import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/delivery_boy_app/views/orders/current_order.dart';
import 'package:food_delivery_app/resturant_app/model/orders_porvider.dart';
import 'package:food_delivery_app/resturant_app/model/previous_orders.dart';
import 'package:provider/provider.dart';

class ViewOrder extends StatelessWidget {
  final String customerName;
  final String customerAddress;
  final String date;
  final String userImage;
  final List<PreviousOrder> orders;
  final String orderStatus;
  final String orderId;
  final String totalPrice;
  final String deliveryPrice;
  final int itemIndex;

  ViewOrder({
    this.customerName,
    this.customerAddress,
    this.date,
    this.userImage,
    this.orders,
    this.orderStatus,
    this.orderId,
    this.totalPrice,
    this.deliveryPrice,
    this.itemIndex
  });

  @override
  Widget build(BuildContext context) {
    var index;
    final pro = Provider.of<OrdersProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  Container(
                      height: 230,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(
                        "https://tripps.live/tripp_food/${userImage}",
                        fit: BoxFit.fill,
                      )),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Positioned(
                    top: 190,
                    left: 20,
                    right: 0,
                    bottom: 0,
                    child: Text(
                      customerName,
                      style: TextStyle(
                          fontSize: 24,
                          color: kThemeColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
              Card(
                elevation: 5.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(orderStatus,style: TextStyle(color: orderStatus == "Completed" ? Colors.green : Colors.red),),
                    subtitle: Text(
                        "Order Number : $orderId\nDelivery Address : $customerAddress"),
                  ),
                ),
              ),
              Card(
                child: Column(
                  children: [
                    Divider(),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: null == orders[itemIndex].items ? 0 : orders[itemIndex].items.length,
                    itemBuilder: (ctx,i){
                      index = i;
                      var ord = orders[itemIndex].items[i];
                      return ListTile(
                        leading: Text("2x"),
                        title: Text(ord.itemDec),
                        trailing: Text("SAR ${ord.itemPrice}"),
                      );
                    },
                  ),
                    ListTile(
                      leading: Text("Delivery fee"),
                      trailing: Text("SAR ${deliveryPrice.toString()}"),
                    ),
                    Divider(),
                    ListTile(
                      leading: Text("Total (incl, VAT)"),
                      trailing: Text("SAR ${totalPrice.toString()}"),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              // Padding(
              //   padding: const EdgeInsets.all(5.0),
              //   child: MaterialButton(
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(20),
              //     ),
              //     height: 50,
              //     color: kThemeColor,
              //     onPressed: () {},
              //     child: Text(
              //       "Go To Resturant",
              //       style: TextStyle(color: Colors.white),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }


}
