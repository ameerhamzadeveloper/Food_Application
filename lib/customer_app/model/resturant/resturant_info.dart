// To parse this JSON data, do
//
//     final resturantInfo = resturantInfoFromJson(jsonString);

import 'dart:convert';

List<ResturantInfo> resturantInfoFromJson(String str) => List<ResturantInfo>.from(json.decode(str).map((x) => ResturantInfo.fromJson(x)));

String resturantInfoToJson(List<ResturantInfo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ResturantInfo {
  ResturantInfo({
    this.bName,
    this.resutrantSelfie,
    this.resStatus,
    this.resturantId,
    this.lat,
    this.long,
    this.deliPrice,
    this.card,
  });

  String bName;
  String resutrantSelfie;
  int resStatus;
  String resturantId;
  double lat;
  double long;
  int deliPrice;
  List<Card> card;

  factory ResturantInfo.fromJson(Map<String, dynamic> json) => ResturantInfo(
    bName: json["b_name"],
    resutrantSelfie: json["resutrant_selfie"],
    resStatus: json["resStatus"],
    resturantId: json["resturant_id"],
    lat: json["lat"].toDouble(),
    long: json["long"].toDouble(),
    deliPrice: json["deli_price"],
    card: List<Card>.from(json["card"].map((x) => Card.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "b_name": bName,
    "resutrant_selfie": resutrantSelfie,
    "resStatus": resStatus,
    "resturant_id": resturantId,
    "lat": lat,
    "long": long,
    "deli_price": deliPrice,
    "card": List<dynamic>.from(card.map((x) => x.toJson())),
  };
}

class Card {
  Card({
    this.cardId,
    this.cardName,
    this.minPrice,
    this.cardStatus,
    this.item,
  });

  String cardId;
  String cardName;
  String minPrice;
  int cardStatus;
  List<Item> item;

  factory Card.fromJson(Map<String, dynamic> json) => Card(
    cardId: json["card_id"],
    cardName: json["card_name"],
    minPrice: json["min_price"],
    cardStatus: json["cardStatus"],
    item: List<Item>.from(json["item"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "card_id": cardId,
    "card_name": cardName,
    "min_price": minPrice,
    "cardStatus": cardStatus,
    "item": List<dynamic>.from(item.map((x) => x.toJson())),
  };
}

class Item {
  Item({
    this.itemId,
    this.itemPrice,
    this.itmeImg,
    this.itemName,
    this.itemDescription,
    this.cardId,
    this.itemStatus,
  });

  String itemId;
  int itemPrice;
  String itmeImg;
  String itemName;
  String itemDescription;
  String cardId;
  int itemStatus;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    itemId: json["item_id"] == null ? null : json["item_id"],
    itemPrice: json["item_price"] == null ? null : json["item_price"],
    itmeImg: json["itme_img"] == null ? null : json["itme_img"],
    itemName: json["item_name"] == null ? null : json["item_name"],
    itemDescription: json["item_description"] == null ? null : json["item_description"],
    cardId: json["card_id"] == null ? null : json["card_id"],
    itemStatus: json["itemStatus"],
  );

  Map<String, dynamic> toJson() => {
    "item_id": itemId == null ? null : itemId,
    "item_price": itemPrice == null ? null : itemPrice,
    "itme_img": itmeImg == null ? null : itmeImg,
    "item_name": itemName == null ? null : itemName,
    "item_description": itemDescription == null ? null : itemDescription,
    "card_id": cardId == null ? null : cardId,
    "itemStatus": itemStatus,
  };
}
