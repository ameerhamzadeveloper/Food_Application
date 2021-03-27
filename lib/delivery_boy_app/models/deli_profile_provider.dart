import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DeliProfileProvider extends ChangeNotifier{
  String userId;
  String storedEmail;

  Future<void> getIdEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString('id');
    storedEmail = preferences.getString('email');
    print(userId);
  }
  dynamic profileName;
  dynamic profileImage;
  dynamic rating;

  Future<void> fetchBoyProfile() async {
    print("this is from profile $userId");
    String url = "${kServerUrlName}deli_profile.php";
    http.Response response = await http.post(url,body: ({
      'login_id': userId,
    }));
    var decode = jsonDecode(response.body);
    print(response.statusCode);
    if(response.statusCode == 200){
      profileName = decode['data'][0]['profile_name'];
      profileImage = decode['data'][0]['my_selfie'];
      rating = decode['data'][0]['rating'];
      print(decode);
    }
    notifyListeners();
  }
  avaluateRating(){
    if(rating == 1){
      return Row(
        children: [
          Icon(
            Icons.star,
            color: Colors.green,
          ),
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
        ],
      );
    }if(rating == 0){
      return Row(
        children: [
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
        ],
      );
    }else if(rating == 2){
      return Row(
        children: [
          Icon(
            Icons.star,
            color: Colors.green,
          ),
          Icon(
            Icons.star,
            color: Colors.green,
          ),
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
        ],
      );
    }else if(rating == 3){
      return Row(
        children: [
          Icon(
            Icons.star,
            color: Colors.green,
          ),
          Icon(
            Icons.star,
            color: Colors.green,
          ),
          Icon(
            Icons.star,
            color: Colors.green,
          ),
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
        ],
      );
    }else if(rating == 4){
      return Row(
        children: [
          Icon(
            Icons.star,
            color: Colors.green,
          ),
          Icon(
            Icons.star,
            color: Colors.green,
          ),
          Icon(
            Icons.star,
            color: Colors.green,
          ),
          Icon(
            Icons.star,
            color: Colors.green,
          ),
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
        ],
      );
    }else{
      return Row(
        children: [
          Icon(
            Icons.star,
            color: Colors.green,
          ),
          Icon(
            Icons.star,
            color: Colors.green,
          ),
          Icon(
            Icons.star,
            color: Colors.green,
          ),
          Icon(
            Icons.star,
            color: Colors.green,
          ),
          Icon(
            Icons.star,
            color: Colors.green,
          ),
        ],
      );
    }
  }
}