// To parse this JSON data, do
//
//     final myTotalOrders = myTotalOrdersFromJson(jsonString);

import 'dart:convert';

List<MyTotalOrders> myTotalOrdersFromJson(String str) => List<MyTotalOrders>.from(json.decode(str).map((x) => MyTotalOrders.fromJson(x)));

String myTotalOrdersToJson(List<MyTotalOrders> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyTotalOrders {
  MyTotalOrders({
    this.orderId,
    this.bName,
    this.customerAddress,
    this.date,
    this.resutrantSelfie,
    this.orderStatus,
    this.totalPrice,
    this.status,
    this.deliveryFee,
    this.items,
  });

  String orderId;
  String bName;
  String customerAddress;
  DateTime date;
  String resutrantSelfie;
  String orderStatus;
  String totalPrice;
  int status;
  String deliveryFee;
  List<Item> items;

  factory MyTotalOrders.fromJson(Map<String, dynamic> json) => MyTotalOrders(
    orderId: json["order_id"],
    bName: json["b_name"],
    customerAddress: json["customer_address"],
    date: DateTime.parse(json["date"]),
    resutrantSelfie: json["resutrant_selfie"],
    orderStatus: json["order_status"],
    totalPrice: json["total_price"],
    status: json["status"],
    deliveryFee: json["delivery_fee"],
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "order_id": orderId,
    "b_name": bName,
    "customer_address": customerAddress,
    "date": date.toIso8601String(),
    "resutrant_selfie": resutrantSelfie,
    "order_status": orderStatus,
    "total_price": totalPrice,
    "status": status,
    "delivery_fee": deliveryFee,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class Item {
  Item({
    this.itemId,
    this.itemPrice,
    this.itemName,
    this.itemDescription,
    this.itemStatus,
  });

  String itemId;
  String itemPrice;
  String itemName;
  String itemDescription;
  int itemStatus;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    itemId: json["item_id"],
    itemPrice: json["item_price"],
    itemName: json["item_name"],
    itemDescription: json["item_description"],
    itemStatus: json["itemStatus"],
  );

  Map<String, dynamic> toJson() => {
    "item_id": itemId,
    "item_price": itemPrice,
    "item_name": itemName,
    "item_description": itemDescription,
    "itemStatus": itemStatus,
  };
}
