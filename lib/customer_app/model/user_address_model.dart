// To parse this JSON data, do
//
//     final userAddress = userAddressFromJson(jsonString);

import 'dart:convert';

List<UserAddress> userAddressFromJson(String str) => List<UserAddress>.from(json.decode(str).map((x) => UserAddress.fromJson(x)));

String userAddressToJson(List<UserAddress> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserAddress {
  UserAddress({
    this.userId,
    this.city,
    this.area,
    this.streetNo,
    this.houseNo,
    this.status,
  });

  String userId;
  String city;
  String area;
  String streetNo;
  String houseNo;
  int status;

  factory UserAddress.fromJson(Map<String, dynamic> json) => UserAddress(
    userId: json["user_id"],
    city: json["city"],
    area: json["area"],
    streetNo: json["street_no"],
    houseNo: json["house_no"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "city": city,
    "area": area,
    "street_no": streetNo,
    "house_no": houseNo,
    "status": status,
  };
}
