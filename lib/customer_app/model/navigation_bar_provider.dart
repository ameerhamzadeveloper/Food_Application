import 'package:flutter/foundation.dart';

class NavigationProvider extends ChangeNotifier{
  int index = 0;

  // set navigation bar with index

 void setNavBarIndex(int currentIndex){
    index = currentIndex;
    notifyListeners();
 }

}
