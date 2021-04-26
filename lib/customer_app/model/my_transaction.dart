// To parse this JSON data, do
//
//     final myTransaction = myTransactionFromJson(jsonString);

import 'dart:convert';

List<MyTransaction> myTransactionFromJson(String str) => List<MyTransaction>.from(json.decode(str).map((x) => MyTransaction.fromJson(x)));

String myTransactionToJson(List<MyTransaction> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyTransaction {
  MyTransaction({
    this.resturant,
    this.totalPrice,
    this.date,
    this.orderId,
  });

  String resturant;
  String totalPrice;
  DateTime date;
  String orderId;

  factory MyTransaction.fromJson(Map<String, dynamic> json) => MyTransaction(
    resturant: json["resturant"],
    totalPrice: json["total_price"],
    date: DateTime.parse(json["date"]),
    orderId: json["order_id"],
  );

  Map<String, dynamic> toJson() => {
    "resturant": resturant,
    "total_price": totalPrice,
    "date": date.toIso8601String(),
    "order_id": orderId,
  };
}
