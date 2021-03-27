import 'package:flutter/foundation.dart';
import 'package:food_delivery_app/resturant_app/model/menu_card_model.dart';
import 'package:food_delivery_app/resturant_app/model/menu_card_item_model.dart';

class MenuLists extends ChangeNotifier{

   List<MenuCardModel> cardList = [];
   List<MenuCardItemsModel> itemList = [];

  void deleteCardFromIndex(int index){
    cardList.removeAt(index);
    notifyListeners();
  }

  void compareCardandItems(){
    if(cardList.any((cardItem) => itemList.contains(cardItem))){
    }
  }

  void clearAllList(){
    cardList.clear();
    notifyListeners();
  }

   void deleteCardItemFromIndex(int index){
     itemList.removeAt(index);
     notifyListeners();
   }

   void clearAllItemList(){
     itemList.clear();
     notifyListeners();
   }
}