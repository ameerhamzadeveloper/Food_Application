// To parse this JSON data, do
//
//     final searchedResturantModel = searchedResturantModelFromJson(jsonString);

import 'dart:convert';

List<SearchedResturantModel> searchedResturantModelFromJson(String str) => List<SearchedResturantModel>.from(json.decode(str).map((x) => SearchedResturantModel.fromJson(x)));

String searchedResturantModelToJson(List<SearchedResturantModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchedResturantModel {
  SearchedResturantModel({
    this.bName,
    this.resutrantSelfie,
    this.resStatus,
    this.resturantId,
    this.deliveryFee,
    this.card,
  });

  String bName;
  String resutrantSelfie;
  int resStatus;
  String resturantId;
  int deliveryFee;
  List<Card> card;

  factory SearchedResturantModel.fromJson(Map<String, dynamic> json) => SearchedResturantModel(
    bName: json["b_name"],
    resutrantSelfie: json["resutrant_selfie"],
    resStatus: json["resStatus"],
    resturantId: json["resturant_id"],
    deliveryFee: json["delivery_fee"],
    card: List<Card>.from(json["card"].map((x) => Card.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "b_name": bName,
    "resutrant_selfie": resutrantSelfie,
    "resStatus": resStatus,
    "resturant_id": resturantId,
    "delivery_fee": deliveryFee,
    "card": List<dynamic>.from(card.map((x) => x.toJson())),
  };
}

class Card {
  Card({
    this.cardStatus,
  });

  int cardStatus;

  factory Card.fromJson(Map<String, dynamic> json) => Card(
    cardStatus: json["cardStatus"],
  );

  Map<String, dynamic> toJson() => {
    "cardStatus": cardStatus,
  };
}
