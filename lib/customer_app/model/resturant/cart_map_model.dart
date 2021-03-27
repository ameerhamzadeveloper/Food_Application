class CartMapModel{
  String itemName;
  String itemPrice;
  String itemDescription;
  String itemQty;
  CartMapModel({this.itemDescription,this.itemPrice,this.itemName,this.itemQty});
  Map<String, String> toJson() {
    return {
      "itemName": itemName,
      "itemPrice": itemPrice,
      "itemDescription" : itemDescription,
      "itemQty" : itemQty
    };
}
}

class CartPrice{
  int itemPrice;
  CartPrice({this.itemPrice});
}
class FinalCart{
  List<CartMapModel> list = List<CartMapModel>();
  Map<String, dynamic> toJson() {
    return {
      "Items": list.map((list) => list.toJson()).toList().toString()
    };
  }
}
class APIOrder{
  String itemName;
  String itemPrice;
  String itemDescription;
  APIOrder({this.itemName,this.itemPrice,this.itemDescription});
}