import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/delivery_boy_app/models/deli_recent_order.dart';
import 'package:food_delivery_app/resturant_app/model/resturant_profile_provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class DashOrders extends ChangeNotifier{

  dynamic rating;
  dynamic earning;
  dynamic totalOrders;
  dynamic cancelOrders;
  String userid;
  String storedEmail;

  void getIdEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userid = preferences.getString('id');
    storedEmail = preferences.getString('email');
    print(userid);
  }

  Future<void> fetchCancelOrders() async {
    String url = "${kServerUrlName}deliver_cancel.php";
    http.Response response = await http.post(url,body: ({
      'deli_boy_id' : userid
    }));
    var decode = json.decode(response.body);
    cancelOrders = decode['data'][0]['cancel_order'];
    print("fromCAncelOrser ${decode['data'][0]['cancel_order']}");
    notifyListeners();
  }
  Future<void> fetchEaringTotalOrder() async {
    String url = "${kServerUrlName}deli_comp_order.php";
    http.Response response = await http.post(url,body: ({
      'deli_boy_id' : userid
    }));
    var decode = json.decode(response.body);
    earning = decode['data'][0]['total_earning'];
    totalOrders = decode['data'][0]['total_order'];
    print("From Earning ${decode['data'][0]['total_earning']}");
    print("From Earning ${decode['data'][0]['total_order']}");
    notifyListeners();
  }
  Future<void> fetchRating() async {
    String url = "${kServerUrlName}fetch_deli_rating.php";
    http.Response response = await http.post(url,body: ({
      'deli_boy_id' : userid
    }));
    var decode = json.decode(response.body);
    rating = decode['data'][0]['rating'];
    print("from rating ${decode['data'][0]['rating']}");
    notifyListeners();
  }

  List<DeliRecentOrder> orders;

  Future<List<DeliRecentOrder>> fetchRecentOrder() async {
    const String url = "${kServerUrlName}deli_total_order.php";
    http.Response response = await http.post(url,body: ({
      'deli_boy_id': userid,
    }));
    if (200 == response.statusCode) {
      List<DeliRecentOrder> myOrders = deliRecentOrderFromJson(response.body);
      return myOrders;
    }else{
      return List<DeliRecentOrder>();
    }

  }
  Future<void> showRecentOrders()async{
    await fetchRecentOrder().then((value){
      orders = value;
    });
    notifyListeners();
  }

}