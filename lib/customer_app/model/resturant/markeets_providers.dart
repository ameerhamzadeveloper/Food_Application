import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/customer_app/model/resturant/markeets_model.dart';
import 'package:food_delivery_app/customer_app/model/resturant/resturant_list.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class MarkeetsProviders with ChangeNotifier{

  double lat;
  double lon;
  String resturantId;
  dynamic resturantName;
  dynamic resturantImage;
  dynamic resturantDeliPrice;
  dynamic resturantEmail;
  dynamic getedResturantId;
  dynamic resurantLat;
  dynamic resturantLong;

  Future<void> fetchNearbyMarkeets(context) async {
    String url = "${kServerUrlName}fetch_near_shops.php";
    http.Response response = await http.post(url,body: ({
      'lat': lat.toString(),
      'long': lon.toString(),
    }));
    var decode = json.decode(response.body);
    if(decode['data'][0]['status'] == 0){
      print(decode);
    }else{
      final pro = Provider.of<ResturantList>(context,listen: false);
      for(var dec in decode['data']){
        pro.markeets.add(
            MarkeetsModel(
                bName: dec['b_name'],
                deliFee: dec['delivery_fee'].toString(),
                description: dec['description'],
                id: dec['id'],
                markeetSelfie: dec['resutrant_selfie'],
                minimum: dec['minval'].toString(),
                rating: dec['rating'],
                ratingLength: dec['length'].toString()
            )
        );
    }

      notifyListeners();
      print(decode);
    }
    notifyListeners();
  }
  Future<void> fetchMarkeetInfo()async {
    String url = "${kServerUrlName}fetch_res_info.php";
    http.Response response = await http.post(url,body: ({
      'resturant_id' : resturantId,
    }));
    var decode = jsonDecode(response.body);
    if(response.statusCode == 200){
      resturantEmail = decode['email'];
      resturantName = decode['data'][0]['b_name'];
      resturantImage = decode['data'][0]['resutrant_selfie'];
      resturantDeliPrice = decode['data'][0]['deli_price'];
      getedResturantId = decode['data'][0]['id'];
      resturantEmail = decode['data'][0]['email'];
      resurantLat = decode['data'][0]['lat'];
      resturantLong = decode['data'][0]['lon'];
    }
    print("flag lat ${decode['data'][0]['lat']}");
    print(resturantEmail);
    print(getedResturantId);
    notifyListeners();
  }


}