import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:food_delivery_app/resturant_app/model/resturant_card_items.dart';
import 'package:food_delivery_app/resturant_app/model/resturant_profile_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/resturant_app/model/menu_list.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/resturant_app/model/menu_card_model.dart';
import 'package:food_delivery_app/resturant_app/model/menu_card_item_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuProvider extends ChangeNotifier {
  String cardName;
  String cardMinPrice;
  dynamic cardID;

  String itemName;
  String itemPrice;
  String itemDescription;
  File itemImage;
  dynamic getCardId;
  String resturantId;
  String resturantEmail;

  Future pickItemImage() async {
    var sampleImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    itemImage = sampleImage;
    notifyListeners();
  }
  Future<void> getIdEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    resturantId = preferences.getString('id');
    resturantEmail = preferences.getString('email');
    print(resturantId);
  }

  //show Image for Upload

  Widget showItemImage() {
    if (itemImage != null) {
      return Image.file(
        itemImage,
        fit: BoxFit.fill,
        height: 120,
        width: 120,
      );
    } else {
      return Center(
        child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: kThemeColor, width: 5)),
            child: Image.asset(
              "images/profile.png",
              height: 120,
              width: 120,
            )),
      );
    }
  }

  // add resturant menu cards

  Future<void> addMenuCard(context) async {
    final pro = Provider.of<ResturantProfileProvider>(context,listen: false);
    String url = "${kServerUrlName}resturant_card.php";
    print(resturantId);
    print(resturantEmail);
    print(cardMinPrice);
    http.Response response = await http.post(url,
        body: ({
          'email': resturantEmail,
          'resturant_id': resturantId,
          'card_name': cardName,
          'min_price': cardMinPrice,
        }));
    var decode = jsonDecode(response.body);
    print(decode);
    notifyListeners();
  }

  void callFetchFun(context) {
    fetchMenuCards(context);
    notifyListeners();
  }

  Future<void> addCardItems() async {
    String url = "${kServerUrlName}resturant_item.php";
    var request = await http.MultipartRequest('POST',Uri.parse(url));
    var imagee = await http.MultipartFile.fromPath('file', itemImage.path);
    request.fields['item_description'] = itemDescription;
    request.fields['card_id'] = getCardId;
    request.fields['item_name'] = itemName;
    request.fields['item_price'] = itemPrice;
    request.files.add(imagee);
    request.send();
    notifyListeners();
  }

  // fetch all resturant cards and items

  List<ResturantCardItems> cardsItems;

  Future<List<ResturantCardItems>> fetchCardsItems(BuildContext context) async {
    const String url = "${kServerUrlName}fetch_res_card_and_items.php";
    final pro = Provider.of<ResturantProfileProvider>(context,listen: false);
    http.Response response = await http.post(url,body: ({
      'resturant_id': resturantId,
    }));
    if (200 == response.statusCode) {
      List<ResturantCardItems> myOrders = resturantCardItemsFromJson(response.body);
      return myOrders;
    }else{
      return List<ResturantCardItems>();
    }

  }

  Future<void> showCardItems(BuildContext context)async{
    await fetchCardsItems(context).then((value){
      cardsItems = value;
    });
    notifyListeners();
  }

  Future<void> fetchMenuCards(context) async {
    String url = "${kServerUrlName}fetch_resturant_card.php";
    http.Response response = await http.post(url,
        body: ({
          'resturant_id': resturantId,
        }));
    var decodee = jsonDecode(response.body);
    List<MenuCardItemsModel> lstItems;

    if (response.statusCode == 200) {
      lstItems = List();
      String url1 = "${kServerUrlName}fetch_card_item.php";
      http.Response response1 = await http.post(
        url1,
      );
      var decode1 = jsonDecode(response1.body);

      for (var decode in decode1['data']) {
        lstItems.add(MenuCardItemsModel(
          itemPrice: decode['item_price'],
          itemName: decode['item_name'],
          itemDescription: decode['item_description'],
          itemImage: decode['itme_img'],
          itemId: decode['item_id'],
          cardId: decode['card_id'],
        ));
      }
    }
    final pro = Provider.of<MenuLists>(context, listen: false);
    pro.clearAllList();
    for (var decode in decodee['data']) {
      cardID = decode['card_id'];
      print(decode['card_id']);
      List<MenuCardItemsModel> lstCardItems = List();
      for (MenuCardItemsModel tempItem in lstItems) {
        if (tempItem.cardId == cardID) {
          lstCardItems.add(tempItem);
        }
      }
      pro.cardList.add(MenuCardModel(
        cardMinPrice: decode['min_price'],
        cardName: decode['card_name'],
        cardId: decode['card_id'],
        listItem: lstCardItems,
      ));
    }
    notifyListeners();
    print(decodee);
  }

  // fetch menu card items
  Future<void> fetchMenuCardItems(context) async {
    String url = "${kServerUrlName}fetch_card_item.php";
    http.Response response = await http.post(url,
        body: ({
          'card_id': cardID,
        }));
    var decodee = jsonDecode(response.body);
    final pro = Provider.of<MenuLists>(context, listen: false);
    pro.clearAllList();
    for (var decode in decodee['data']) {
      pro.itemList.add(MenuCardItemsModel(
        itemPrice: decode['item_price'],
        itemName: decode['item_name'],
        itemDescription: decode['item_description'],
        itemImage: decode['itme_img'],
        itemId: decode['item_id'],
        cardId: decode['item_price'],
      ));
    }
    notifyListeners();
    print(decodee);
  }

  Future<void> deleteCard(dynamic cardId, context, int index) async {
    String url = "${kServerUrlName}del_card.php";
    http.Response response = await http.post(url,
        body: ({
          'card_id': cardId,
        }));
    final pro = Provider.of<MenuLists>(context, listen: false);
    pro.deleteCardFromIndex(index);
    fetchMenuCards(context);
    notifyListeners();
  }

  TextEditingController cardNameController;
  TextEditingController cardMinPriceController;

  void assignValue(dynamic assCardName, dynamic assCardMinPri) {
    cardNameController = TextEditingController(text: assCardName);
    cardMinPriceController = TextEditingController(text: assCardMinPri);
    editedCardMinPrice = assCardMinPri;
    editedCardName = assCardName;
    notifyListeners();
  }

  String editedCardName;
  String editedCardMinPrice;
  dynamic fetchedCardId;

  void assignCardId(dynamic val) {
    fetchedCardId = val;
  }

  Future<void> editMenuCard(context) async {
    String url = "${kServerUrlName}edit_card.php";
    print(fetchedCardId);
    print(editedCardMinPrice);
    print(editedCardName);
    print(resturantEmail);
    print(resturantId);
    http.Response response = await http.post(url,
        body: ({
          'card_id': fetchedCardId,
          'card_name': editedCardName,
          'min_price': editedCardMinPrice,
          'resturant_email': resturantEmail,
          'resturant_id': resturantId,
        }));
    var de = json.decode(response.body);
    print(de);
    // fetchMenuCards(context);
  }

  // delete card items

  Future<void> deleteCardItem(String itemId) async {
    String url = "${kServerUrlName}del_card_item.php";
    http.Response response = await http.post(url,body: ({
      'item_id': itemId,
    }));
    var deco = json.decode(response.body);
    print(deco);
  }

  TextEditingController itemNameController;
  TextEditingController itemPriceController;
  TextEditingController itemDesController;
  String editeditemName;
  String editeditemPrice;
  String editeditemDes;
  String itemImageController;
  File editedItemImage;
  String itemId;


  void assignItemEditVals(dynamic itemName, dynamic itemPrice,dynamic itemDes,String image,String itemID) {
    itemNameController = TextEditingController(text: itemName);
    itemPriceController = TextEditingController(text: itemPrice);
    itemDesController = TextEditingController(text: itemDes);
    editeditemName = itemName;
    editeditemPrice = itemPrice;
    editeditemDes = itemDes;
    itemImageController = image;
    itemId = itemID;
    notifyListeners();
  }
  Future pickEditItemImage() async {
    var sampleImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    editedItemImage = sampleImage;
    notifyListeners();
  }
  Widget showEditedItemImage() {
    if (editedItemImage != null) {
      return Image.file(
        editedItemImage,
        fit: BoxFit.fill,
        height: 120,
        width: 120,
      );
    } else {
      return Center(
        child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: kThemeColor, width: 5)),
            child: Image.asset(
              "images/profile.png",
              height: 120,
              width: 120,
            )),
      );
    }
  }
  Widget showPickedItemImage() {
    if (itemImageController != null) {
      return Image.network(
        itemImageController,
        fit: BoxFit.fill,
        height: 120,
        width: 120,
      );
    } else {
      return Center(
        child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: kThemeColor, width: 5)),
            child: Image.asset(
              "images/profile.png",
              height: 120,
              width: 120,
            )),
      );
    }
  }
  Future<void> editItems() async {
    String url = "${kServerUrlName}edit_item.php";
    if(editedItemImage != null){
      var request = await http.MultipartRequest('POST',Uri.parse(url));
      var imagee = await http.MultipartFile.fromPath('file', editedItemImage.path);
      request.fields['item_name'] = editeditemName;
      request.fields['item_id'] = itemId;
      request.fields['item_price'] = editeditemPrice;
      request.fields['item_description'] = editeditemDes;
      request.files.add(imagee);
      request.send();
    }else{
      http.Response response = await http.post(url,body: ({
        'item_name': editeditemName,
        'item_id': itemId,
        'item_price': editeditemPrice,
        'item_description' :editeditemDes,
      }));
      var de = json.decode(response.body);
      print(de);
    }


    notifyListeners();
  }

}
