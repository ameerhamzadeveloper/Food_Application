// To parse this JSON data, do
//
//     final previousOrder = previousOrderFromJson(jsonString);

import 'dart:convert';

List<PreviousOrder> previousOrderFromJson(String str) => List<PreviousOrder>.from(json.decode(str).map((x) => PreviousOrder.fromJson(x)));

String previousOrderToJson(List<PreviousOrder> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PreviousOrder {
  PreviousOrder({
    this.orderId,
    this.uName,
    this.customerAddress,
    this.date,
    this.userImg,
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
  String orderStatus;
  String totalPrice;
  String deliveryFee;
  List<Item> items;

  factory PreviousOrder.fromJson(Map<String, dynamic> json) => PreviousOrder(
    orderId: json["order_id"],
    uName: json["u_name"],
    customerAddress: json["customer_address"],
    date: DateTime.parse(json["date"]),
    userImg: json["user_img"],
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
