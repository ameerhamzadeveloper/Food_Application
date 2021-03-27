import 'package:food_delivery_app/resturant_app/model/menu_card_item_model.dart';
class MenuCardModel{
  dynamic cardId;
  String cardName;
  String cardMinPrice;
  List<MenuCardItemsModel> listItem;
  MenuCardModel({this.cardMinPrice,this.cardName,this.cardId,this.listItem});
}
