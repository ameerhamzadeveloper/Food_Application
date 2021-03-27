class MenuCardItemsModel{
  dynamic cardId;
  dynamic itemId;
  String itemName;
  String itemPrice;
  String itemImage;
  String itemDescription;
  dynamic resturantId;
  String itemQty;
  MenuCardItemsModel({this.cardId,this.itemId,this.itemName,this.itemPrice,this.itemImage,this.itemDescription,this.resturantId,this.itemQty});

  String toString(){
    return '{${this.cardId},${this.itemId},${this.itemName},${this.itemPrice},${this.itemDescription},${this.itemQty}';
  }
}