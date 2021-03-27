// To parse this JSON data, do
//
//     final deliRecentOrder = deliRecentOrderFromJson(jsonString);

import 'dart:convert';

List<DeliRecentOrder> deliRecentOrderFromJson(String str) => List<DeliRecentOrder>.from(json.decode(str).map((x) => DeliRecentOrder.fromJson(x)));

String deliRecentOrderToJson(List<DeliRecentOrder> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DeliRecentOrder {
  DeliRecentOrder({
    this.orderId,
    this.uName,
    this.customerAddress,
    this.date,
    this.userImg,
    this.bName,
    this.resturantImg,
    this.orderStatus,
    this.totalPrice,
    this.deliveryFee,
    this.items,
  });

  String orderId;
  String uName;
  String customerAddress;
  DateTime date;
  String userImg;
  String bName;
  String resturantImg;
  String orderStatus;
  String totalPrice;
  String deliveryFee;
  List<Item> items;

  factory DeliRecentOrder.fromJson(Map<String, dynamic> json) => DeliRecentOrder(
    orderId: json["order_id"],
    uName: json["u_name"],
    customerAddress: json["customer_address"],
    date: DateTime.parse(json["date"]),
    userImg: json["user_img"],
    bName: json["b_name"],
    resturantImg: json["resturant_img"],
    orderStatus: json["order_status"],
    totalPrice: json["total_price"],
    deliveryFee: json["delivery_fee"],
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "order_id": orderId,
    "u_name": uName,
    "customer_address": customerAddress,
    "date": date.toIso8601String(),
    "user_img": userImg,
    "b_name": bName,
    "resturant_img": resturantImg,
    "order_status": orderStatus,
    "total_price": totalPrice,
    "delivery_fee": deliveryFee,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class Item {
  Item({
    this.itemName,
    this.itemPrice,
    this.itemDec,
  });

  String itemName;
  String itemPrice;
  String itemDec;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    itemName: json["itemName"],
    itemPrice: json["itemPrice"],
    itemDec: json["itemDec"],
  );

  Map<String, dynamic> toJson() => {
    "itemName": itemName,
    "itemPrice": itemPrice,
    "itemDec": itemDec,
  };
}
