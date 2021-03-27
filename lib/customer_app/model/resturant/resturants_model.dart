class ResturantsModel{
  dynamic id;
  dynamic bName;
  dynamic resturantSelfie;
  dynamic rating;
  dynamic ratingLength;
  dynamic description;
  dynamic minimum;
  dynamic deliFee;

  ResturantsModel({this.id,this.bName,this.resturantSelfie,
    this.rating,this.ratingLength,
    this.description,this.minimum,this.deliFee});
}
class ItemNameModel {
  String itemName;
  ItemNameModel({this.itemName});
}
class ItemPriceModel{
  int itemPrice;

  ItemPriceModel({this.itemPrice});

}