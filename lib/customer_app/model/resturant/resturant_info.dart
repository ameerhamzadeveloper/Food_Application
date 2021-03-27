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
    this.deliPrice,
    this.card,
  });

  String bName;
  String resutrantSelfie;
  int resStatus;
  String resturantId;
  int deliPrice;
  List<Card> card;

  factory ResturantInfo.fromJson(Map<String, dynamic> json) => ResturantInfo(
    bName: json["b_name"],
    resutrantSelfie: json["resutrant_selfie"],
    resStatus: json["resStatus"],
    resturantId: json["resturant_id"],
    deliPrice: json["deli_price"],
    card: List<Card>.from(json["card"].map((x) => Card.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "b_name": bName,
    "resutrant_selfie": resutrantSelfie,
    "resStatus": resStatus,
    "resturant_id": resturantId,
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
    itemId: json["item_id"],
    itemPrice: json["item_price"],
    itmeImg: json["itme_img"],
    itemName: json["item_name"],
    itemDescription: json["item_description"],
    cardId: json["card_id"],
    itemStatus: json["itemStatus"],
  );

  Map<String, dynamic> toJson() => {
    "item_id": itemId,
    "item_price": itemPrice,
    "itme_img": itmeImg,
    "item_name": itemName,
    "item_description": itemDescription,
    "card_id": cardId,
    "itemStatus": itemStatus,
  };
}
