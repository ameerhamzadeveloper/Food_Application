import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/customer_app/model/navigation_bar_provider.dart';
import 'package:food_delivery_app/customer_app/model/profile_provider.dart';
import 'package:food_delivery_app/customer_app/model/resturant/cart_map_model.dart';
import 'package:food_delivery_app/customer_app/model/resturant/cart_model.dart';
import 'package:food_delivery_app/customer_app/model/resturant/resturant_card_items_model.dart';
import 'package:food_delivery_app/customer_app/model/resturant/resturant_info.dart';
import 'package:food_delivery_app/customer_app/model/resturant/searched_resturant_model.dart';
import 'package:food_delivery_app/resturant_app/model/menu_card_item_model.dart';
import 'package:food_delivery_app/resturant_app/model/menu_card_model.dart';
import 'package:food_delivery_app/resturant_app/model/menu_list.dart';
import 'package:food_delivery_app/routes/routes_names.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:food_delivery_app/customer_app/model/resturant/resturant_list.dart';
import 'package:food_delivery_app/customer_app/model/resturant/resturants_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NearResturantsProvider extends ChangeNotifier{
  double lat;
  double lon;
  dynamic cardID;
  dynamic resturantId;
  dynamic getedResturantId;

  dynamic resturantName;
  dynamic resturantImage;
  dynamic resturantDeliPrice;
  dynamic resturantEmail;
  dynamic userId;
  dynamic storedEmail;
  dynamic resurantLat;
  dynamic resturantLong;
  dynamic deliveryBoyId;
  dynamic deliveryBoyEmail;
  dynamic deliveryBoyLat;
  dynamic deliveryBoyLon;
  int totalPrice = 0;
  int subtotal = 0;
  String otherInstruction = '';
  bool isCurrentOrder = false;




  void setOtherInst(String val){
    otherInstruction = val;
    notifyListeners();
  }

  CartModel cartModel = CartModel();

  void getUserIdEmail()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString('id');
    storedEmail = preferences.getString('email');
    print(userId);
  }

  Future<void> fetchAllResturants(context) async {
    String url = "${kServerUrlName}all_resturant.php";
    http.Response response = await http.post(url,body: ({
      'lat': lat.toString(),
      'long': lon.toString(),
    }));
    var decode = jsonDecode(response.body);
    print(" allllll ressssssss $decode");
    final pro = Provider.of<ResturantList>(context,listen: false);
    pro.allResturants.clear();
    for(var dec in decode['data']){
      resurantLat = dec['lat'];
      resturantLong = dec['long'];
      pro.allResturants.add(
          ResturantsModel(
            bName: dec['b_name'],
            description: 'Pixxa smalll large burger etc popkomn',
            id: dec['id'],
            resturantSelfie: dec['resutrant_selfie'],
            minimum: dec['delivery_fee'].toString(),
            rating: dec['rating'].toString() ?? "0",
            ratingLength: dec['lenght'].toString() ?? "0",
            deliFee: dec['minval'].toString(),
          )
      );
    }
    // print(decode);
    notifyListeners();
    // print(decode);
  }

  List<MenuCardItemsModel> lstItems;
  Future<void> fetchNearbyResturants(context) async {
    print(lat);
    String url = "${kServerUrlName}fetch_all_resturant.php";
    http.Response response = await http.post(url, body: ({
      'lat': lat.toString(),
      'long': lon.toString(),
    }));
    var decode = json.decode(response.body);
    final pro = Provider.of<ResturantList>(context, listen: false);
    pro.resturantList.clear();
    print(decode['data'][0]['status']);
    if(decode['data'][0]['status'] == 0){

    }else{
      for (var dec in decode['data']) {
        resurantLat = dec['lat'];
        resturantLong = dec['long'];
        print("near ressssssss ${decode['data']}");
        pro.resturantList.add(
          ResturantsModel(
            bName: dec['b_name'],
            description: dec['description'],
            id: dec['id'],
            resturantSelfie: dec['resutrant_selfie'],
            minimum: dec['delivery_fee'].toString(),
            rating: dec['rating'].toString() ?? "0",
            ratingLength: dec['length'].toString(),
            deliFee: dec['minval'].toString(),
          ),
        );
      }
    }
    print("datum flag$decode");
    notifyListeners();
  }

  Future<void> fetchMenuCards(context) async {
    String url = "${kServerUrlName}fetch_resturant_card.php";
    http.Response response = await http.post(url,
        body: ({
          'resturant_id': resturantId,
        }));
    var decodee = jsonDecode(response.body);
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
    // print(decodee);
    print(resturantId);
  }
  List<ResturantInfo> resturantInfos;

  Future<List<ResturantInfo>> fetchresturantInfo() async {
    const String url = "${kServerUrlName}fetch_res_info.php";
    http.Response response = await http.post(url,body: ({
      'resturant_id' : resturantId,
      'lat': lat.toString(),
      'long':lon.toString()
    }));
    if (200 == response.statusCode) {
      var de = json.decode(response.body);
      print(de);
      List<ResturantInfo> myOrders = resturantInfoFromJson(response.body);
      return myOrders;
    }else{
      return List<ResturantInfo>();
    }

  }

  Future<void> showResturantInfo()async{
    await fetchresturantInfo().then((value){
      resturantInfos = value;
      print(resturantInfos[0].card[1].cardName);
    });
    notifyListeners();
  }

  List<ResturantInfo> shopInfo;

  Future<List<ResturantInfo>> fetchShopInfo() async {
    const String url = "${kServerUrlName}fetch_shop_info.php";
    http.Response response = await http.post(url,body: ({
      'resturant_id' : resturantId,
      'lat': lat.toString(),
      'long':lon.toString()
    }));
    if (200 == response.statusCode) {
      var de = json.decode(response.body);
      print(de);
      List<ResturantInfo> myOrders = resturantInfoFromJson(response.body);
      return myOrders;
    }else{
      return List<ResturantInfo>();
    }

  }

  Future<void> showShopInfo()async{
    await fetchShopInfo().then((value){
      shopInfo = value;
      print(shopInfo[0].card[0].cardName);
    });
    notifyListeners();
  }

  List<ResturantCardAndItems> resCardItem;
  Future<List<ResturantCardAndItems>> fetchresCardItem() async {
    const String url = "${kServerUrlName}fetch_res_info.php";
    http.Response response = await http.post(url,body: ({
      'resturant_id' : resturantId,
      'lat': lat.toString(),
      'long':lon.toString()
    }));
    if (200 == response.statusCode) {
      List<ResturantCardAndItems> myOrders = resturantCardAndItemsFromJson(response.body);
      return myOrders;
    }else{
      return List<ResturantCardAndItems>();
    }

  }

  String search;
  List<SearchedResturantModel> searchedRes;
  Future<List<SearchedResturantModel>> searchResturants(BuildContext context) async {
    const String url = "${kServerUrlName}search.php";
    http.Response response = await http.post(url,body: ({
      'lat':lat.toString(),
      'long':lon.toString(),
      'resturantName': search,
    }));
    if (200 == response.statusCode) {
      List<SearchedResturantModel> myOrders = searchedResturantModelFromJson(response.body);
      return myOrders;
    }else{
      return List<SearchedResturantModel>();
    }
  }

  Future<void> addSearchedReas(BuildContext context)async{
    await searchResturants(context).then((value){
      searchedRes = value;
    });
    notifyListeners();
  }


  void assignsearchVal(String val){
    search = val;
    notifyListeners();
  }

  Future<void> showResCardItem()async{
    await fetchresCardItem().then((value){
      resCardItem = value;
      print(resturantInfos[0].card[0]);
    });
    notifyListeners();
  }

  List<MenuCardItemsModel> cartItems = [];

  List<CartMapModel> cartOrderList = [];
  List<APIOrder> apiOrder = [];

  List itemPrice = [];
  var cartMap;

  void minusItem(int index){
    cartItems[index].itemQty = (int.parse(cartItems[index].itemQty)-1).toString();
    cartOrderList[index].itemQty = (int.parse(cartOrderList[index].itemQty)-1).toString();
    notifyListeners();
  }
  void plusItem(int index){
    cartItems[index].itemQty = (int.parse(cartItems[index].itemQty)+1).toString();
    cartOrderList[index].itemQty = (int.parse(cartOrderList[index].itemQty)+1).toString();
    notifyListeners();
  }
  void removeItem(int index){
    cartItems.removeAt(index);
    cartOrderList.removeAt(index);
    notifyListeners();
  }

  void addToCart(dynamic itmName, dynamic itmDesc, String itmPrice,dynamic itmImage,restID,itmId,
      {itemQty}){
    //   cartItems.add(
    cartOrderList.add(
        CartMapModel(
            itemPrice: itmPrice.toString(),
            itemName: itmName,
            itemDescription: itmDesc,
            itemQty: itemQty.toString()
        )
    );
    print("beforeitemQty");
    print("$itemQty");
    print("bdforeitemQty");
    cartItems.add(
        MenuCardItemsModel(
            itemPrice: itmPrice,
            itemName: itmName,
            itemImage: itmImage,
            itemDescription: itmDesc,
            resturantId: restID,
            itemQty: itemQty.toString()
        )
    );
    print("itemQty");
    print("$itemQty");
    print("itemQty");
    print("cartORderLsit ${cartOrderList.length}");
    print("cartItems ${cartItems.length}");
    notifyListeners();
  }
  void clearAllCart(){
    cartItems.clear();
    cartOrderList.clear();
    notifyListeners();
  }

  Future<void> clearRestInfo(){
    resturantDeliPrice = null;
    resturantName = null;
    resturantImage = null;
    notifyListeners();
  }
  Future<void> clearAllCardNItm(){
    cartItems.clear();
    cartOrderList.clear();
    notifyListeners();
  }

  String baseOrderId;
  String secndOrderNum;

  void generateRandomString(int len) {
    var r = Random();
    const _chars = 'BCDEFGHIJKLMNOPQRSTUVWXYZ';
    baseOrderId = List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
  }
  void generateRandomNumber(int len) {
    var r = Random();
    const _chars = '1234567890';
    secndOrderNum = List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
  }

  int userFiveOrder = 1;

  Future<void> checkUserFiveOrder()async{
    String url = "${kServerUrlName}check_user_5_payment_orders.php";
    http.Response response = await http.post(url,body: ({
      'customer_id':userId,
    }));
    var de = json.decode(response.body);
    userFiveOrder = de['data'][0]['status'];
    print(de);
  }

  cartInitFunctions(){
    subtotal = 0;
    totalPrice = 0;
    generateRandomString(4);
    generateRandomNumber(6);
    print("flag ${resturantInfos[0].deliPrice}");
    cartItems.forEach((element) {
      subtotal = subtotal + int.parse(element.itemPrice) * int.parse(element.itemQty);
      totalPrice = subtotal + resturantInfos[0].deliPrice;
    });
    print(totalPrice);
    // notifyListeners();
  }
  nagitiveSubtotal(int itemPrice){
    print("flag ${resturantInfos[0].deliPrice}");
    cartItems.forEach((element) {
      subtotal = subtotal - itemPrice;
      totalPrice = subtotal + resturantInfos[0].deliPrice;
    });
    print(totalPrice);
    notifyListeners();
  }

  positiveSubtotal(int itemPrice){
    print("flag ${resturantInfos[0].deliPrice}");
    cartItems.forEach((element) {
      subtotal = subtotal + itemPrice;
      totalPrice = subtotal + resturantInfos[0].deliPrice;
    });
    print(totalPrice);
    notifyListeners();
  }

  Future<void> payWithCard(token,BuildContext context) async {
    print(totalPrice);
    print(userId);
    print(resturantId);
    print(token);

    String url = "https://tripps.live/tripp_food/pay/pay/charge.php";
    http.Response response = await http.post(url,
        body: ({
          'method': 'charge',
          'amount': totalPrice.toString(), //1000 is the $10
          'currency': 'SAR',
          'customer_id': userId.toString(), //1000 is the $10
          'currency': 'USD',
          'source': token,
          'resturant': resturantId.toString(),
          'description': 'testing pay....',
        }));
    var dec = json.decode(response.body);
    print(dec['response']);
    if(dec['response'] == 'Success'){
      sendOrderToAPI(context,'1');
    }
  }

  void sendOrderToAPI(context,String paymentStatus) async {
    var resComm = totalPrice * 10 / 100;
    var deliComm = (resturantInfos[0].deliPrice * 3) / 100;
    String commison = (resComm + deliComm).floor().toString();
    print(deliComm);
    print(resComm);
    print(commison);
    final prov = Provider.of<ProfileProvider>(context,listen: false);
    String url = "${kServerUrlName}order.php";
    http.Client client = http.Client();
    Map<String, String> data = {
      'customer_id' : userId,
      'resturant_id': resturantId,
      'lat': resurantLat.toString(),
      'long': resturantLong.toString(),
      'total_price' : totalPrice.toString(),
      'delivery_fee': resturantInfos[0].deliPrice.toString(),
      'customerAddress': "${prov.deliveryHouse} ${prov.deliveryStreet} ${prov.deliveryArea} ${prov.deliveryCity}",
      'orderStatus': "Preparing",
      'deliveryBoyStatus': "Active",
      'orderId' : '$baseOrderId$secndOrderNum',
      'other_instruction' :otherInstruction,
      'payment_status': paymentStatus,
      'comission' : commison,
      'sub_total': subtotal.toString(),
    };
    int i = 0;
    cartOrderList.forEach((element) {
      String itemName = "${element.itemName.toString()}";
      String itemPrice = "${element.itemPrice.toString()}";
      String itemDesc = "${element.itemDescription.toString()}";
      String itemQty = "${element.itemQty.toString()}";
      data['total_items[$i]'] = itemName.toString();
      data['item_price[$i]'] = itemPrice.toString();
      data['item_description[$i]'] = itemDesc.toString();
      data['item_qty[$i]'] = itemQty.toString();
      i++;
    });
    print("flageeeeeeed $data");
    http.Response response = await client.post(url, body: data);
    var decode = json.decode(response.body);
    print(decode);
    deliveryBoyEmail = decode['delivery_boy_email'];
    deliveryBoyId = decode['delivery_boy_id'];
    deliveryBoyLat = decode['delivery_boy_lat'];
    deliveryBoyLon = decode['delivery_boy_long'];
    print(deliveryBoyEmail);
    if(response.statusCode == 200){
      final navPro = Provider.of<NavigationProvider>(context);
      navPro.index = 1;
      sendNotification();
      Navigator.pushReplacementNamed(context, navigationBar);
      sendOrderToFirebase(context);
    }
    print(decode['delivery_boy_id']);
    print(response.statusCode);
    notifyListeners();
  }
  void sendOrderToFirebase(context){
    Map<String, dynamic> map = {
      'items': cartOrderList.map((items) => items.toJson()).toList()
    };
    final prov = Provider.of<ProfileProvider>(context,listen: false);
    FirebaseFirestore.instance.collection('orders').doc("$baseOrderId$secndOrderNum").set({
      'customerId': userId,
      'orderId' : '$baseOrderId$secndOrderNum',
      'deliveryBoyStatus': "Active",
      'customerLat': lat,
      'customerLong': lon,
      'deliveryBoyId':deliveryBoyId,
      'customerName': prov.displayName,
      'customerPhone': prov.displayPhone,
      'customerAddress': "${prov.displayHouseNo} ${prov.displayStreet} ${prov.displayArea} ${prov.displayCity}",
      'deliveryFee': resturantInfos[0].deliPrice.toString(),
      'resturantId': resturantId,
      'totalItems': map,
      'subtotal':subtotal,
      'totalPrice': totalPrice,
      'orderStatus': "Preparing",
      'resturantName': resturantInfos[0].bName,
      'resturantImage':resturantInfos[0].resutrantSelfie,
      'resturantEmail' : resturantInfos[0].bName,
      'resturantLat': resturantInfos[0].lat,
      'resturantLong': resturantInfos[0].long,
      'deliLat': deliveryBoyLat,
      'deliLong': deliveryBoyLon,
    });
  }

  void sendNotification()async{
    var res = await http.post(
      'https://onesignal.com/api/v1/notifications',
      headers: {
        "Content-Type": "application/json; charset=utf-8",
        "Authorization":
        "Basic MTFhZGJjMzAtNTcxYi00NTc0LTkwMzYtZjZhMDYyYmNhNGI0"
      },
      body: json.encode({
        'app_id': "3d385690-40a4-4a57-b1db-6b60b7698daf",
        'headings': {"en": "You Recieved New Order!"},
        'contents': {
          "en":
          'you recieved an food order'
        },
        'included_segments': ["Subscribed Users"],
        "filters": [
          {"field": "tag", "key": resturantEmail, "relation": "=", "value": "yes"}
        ],
      }),
    );
  }
}