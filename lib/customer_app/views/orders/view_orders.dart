import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/customer_app/model/my_orders_model.dart';

class ViewOrders extends StatelessWidget {
  final String title;
  final String orderStatus;
  final String date;
  final String orderId;
  final String addres;
  final String image;
  final String delPrice;
  final String totalPrice;
  final int index;
  final List<MyTotalOrders> orders;
  ViewOrders({this.image, this.title, this.date, this.orderStatus,this.orders,this.addres,this.orderId,this.totalPrice,this.delPrice,this.index});
  @override
  Widget build(BuildContext context) {
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
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(
                        "https://tripps.live/tripp_food/${image}",
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
                      title,
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
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
                        "Order Number : $orderId\nDelivery Address : $addres"),
                  ),
                ),
              ),
              Card(
                child: Column(
                  children: [
                    Divider(),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: null == orders[index].items.length ? 0 : orders[index].items.length,
                      itemBuilder: (ctx,i){
                        var ord = orders[index].items[i];
                        return ListTile(
                          leading: Text("2x"),
                          title: Text(ord.itemDescription),
                          trailing: Text("SAR ${ord.itemPrice}"),
                        );
                      },
                    ),
                    ListTile(
                      leading: Text("Delivery fee"),
                      trailing: Text("SAR $delPrice"),
                    ),
                    Divider(),
                    ListTile(
                      leading: Text("Total (incl, VAT)"),
                      trailing: Text("SAR $totalPrice"),
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
