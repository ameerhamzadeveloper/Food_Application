import 'package:flutter/foundation.dart';
import 'package:food_delivery_app/customer_app/model/resturant/markeets_model.dart';
import 'package:food_delivery_app/customer_app/model/resturant/resturants_model.dart';

class ResturantList extends ChangeNotifier{

   List<ResturantsModel> resturantList = [];
   List<ResturantsModel> allResturants = [];
   List<MarkeetsModel> markeets = [];

   void clearAllResturants(){
      allResturants.clear();
      notifyListeners();
   }
   void clearMarkeets(){
      markeets.clear();
      notifyListeners();
   }
   void clearAllList(){
      resturantList.clear();
      notifyListeners();
   }

}