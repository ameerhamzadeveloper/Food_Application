import 'dart:convert';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/customer_app/model/resturant/resturant_card_items_model.dart';
import 'package:food_delivery_app/resturant_app/model/previous_orders.dart';
import 'package:food_delivery_app/resturant_app/model/resturant_card_items.dart';
import 'package:food_delivery_app/resturant_app/model/resturant_profile_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrdersProvider extends ChangeNotifier{
  String orderNumber;
  String orderItems;
  String itemQty;
  String itemPrice;
  String totalPrice;
  String signUpId;
  String storedEmail;

  Future<void> getIdEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    signUpId = preferences.getString('id');
    storedEmail = preferences.getString('email');
    print(signUpId);
  }

  Future<void> fetchCurrentOrders(BuildContext context) async{
    final pro = Provider.of<ResturantProfileProvider>(context,listen: false);
    String url = "${kServerUrlName}my_con_order.php";
    http.Response response = await http.post(url,body:({
      'resturant_id' : pro.resturantId,
    }));
    var decode = jsonDecode(response.body);
    orderItems = decode['data'][0]['items'];
    itemPrice = decode['data'][0]['total_price'];
    orderNumber = decode['data'][0]['order_id'];
    print(decode);
    notifyListeners();
  }
  Future<void> deliverToBoy(String orderId, String orderStatus) async {
    String url = "${kServerUrlName}order_status_update.php";
    http.Response response = await http.post(url,body: ({
      'order_id': orderId,
      'order_status' : orderStatus,
    }));
    var decode = json.decode(response.body);
    print(decode);
  }

  List<PreviousOrder> orders;

  Future<List<PreviousOrder>> myTotalOrders(BuildContext context) async {
    const String url = "${kServerUrlName}res_pre_order.php";
    final pro = Provider.of<ResturantProfileProvider>(context,listen: false);
    print("rest shared pre id  ${pro.resturantId}");
    http.Response response = await http.post(url,body: ({
      'resturant_id': pro.resturantId,
    }));
    if (200 == response.statusCode) {
      List<PreviousOrder> myOrders = previousOrderFromJson(response.body);
      return myOrders;
    }else{
      return List<PreviousOrder>();
    }

  }

  Future<void> showORders(BuildContext context)async{
    await myTotalOrders(context).then((value){
      orders = value;
    });
    notifyListeners();
  }

  dynamic earnings;
  dynamic totalORder;
  var perEarningCircle;
  var perEarningInside;

  var perOrderCircle;
  var perOrderInside;

  Future<void> fetchDashboard(BuildContext context) async{
    final pro = Provider.of<ResturantProfileProvider>(context,listen: false);
    print("pro.resturantId");
    print(pro.resturantId);
    print("pro.resturantId");
    String url = "${kServerUrlName}res_dashboard.php";
    http.Response response = await http.post(url,body: ({
      'resturant_id' : pro.resturantId
    }));
    var dec = json.decode(response.body);
    if(response.statusCode == 200){
      totalORder = dec['data'][0]['total_order'];
      earnings = (dec['data'][0]['total_earning']);
      var ePer = dec['data'][0]['total_earning'];
      perEarningInside = earnings * 100 / 10000;
      perEarningCircle = perEarningInside/100;
      print("falged pay $perEarningInside and $perOrderCircle");
      perOrderInside = int.parse(totalORder) * 100 / 20;
      perOrderCircle = perOrderInside /100;
      // earningPercentage = ePercentage.toDouble();
    }
    print(dec);
    notifyListeners();
  }
  dynamic cancelOrders;
  dynamic rating;
  Future<void> fetchDashboardCancel(BuildContext context) async{
    final pro = Provider.of<ResturantProfileProvider>(context,listen: false);
    String url = "${kServerUrlName}res_cancel.php";
    http.Response response = await http.post(url,body: ({
      'resturant_id' : pro.resturantId
    }));
    var dec = json.decode(response.body);
    if(response.statusCode == 200){
      // earningPercentage = ePercentage.toDouble();
      cancelOrders = dec['data'][0]['total_order'];
    }
    print(dec['data'][0]['total_order']);
    notifyListeners();
  }
  Future<void> fetchDashboardRating(context) async{
    final pro = Provider.of<ResturantProfileProvider>(context,listen: false);
    String url = "${kServerUrlName}res_rating.php";
    http.Response response = await http.post(url,body: ({
      'resturant_id' : pro.resturantId
    }));
    var dec = json.decode(response.body);
    if(response.statusCode == 200){
      // earningPercentage = ePercentage.toDouble();
      var ratinag = dec['data'][0]['rating'];
      rating = (int.parse(ratinag) * 5) / int.parse(totalORder);
    }
    print(dec['data'][0]['rating']);
    notifyListeners();
  }

// percentage formula
// var per = total earning x percentage / 100 = commition
// var earning = 200 - per;

  dynamic earningPercentage;
  dynamic orderPercentage = 1.1;

 // Future<void> getPercentage(){
 //   var ePercentage = (earnings * 100) / 10000;
 //   earningPercentage = ePercentage.toDouble();
 //   var percentage = (totalORder * 100) / 100;
 //   print(totalORder);
 //   orderPercentage = percentage.toDouble();
 //   print(earningPercentage);
 //   notifyListeners();
 // }
  String audioUrl = "ring.mp3";
  final audioPlayer = new AudioCache(fixedPlayer: AudioPlayer());
  void playBackgroundMusic() async {
    await audioPlayer.play(audioUrl);
  }

}