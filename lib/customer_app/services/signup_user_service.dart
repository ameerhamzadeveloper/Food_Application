import 'package:flutter/foundation.dart';
import 'package:food_delivery_app/customer_app/model/signup_user_models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class SignUpUserService extends ChangeNotifier{

  dynamic name;
  dynamic email;
  dynamic street;
  dynamic suit;
  dynamic city;
  dynamic username;
  dynamic phone;
  List<SignUpUser> user;


   Future<List<SignUpUser>>  getSignUpUsers() async {
    final url = "https://unforewarned-rolls.000webhostapp.com/trippApi/getSignUpUsers.php";
    final response = await http.get(url);
    if(response.statusCode == 200){
      List<SignUpUser> users = signUpUserFromJson(response.body);
      return users;
    }else{
      return List<SignUpUser>();
    }
  }
  void setUserToList(){
     getSignUpUsers().then((value) {
       print("get User Called");
       user = value;
     });
  }

  Future getDemoUsers() async {
     String url = "https://jsonplaceholder.typicode.com/users";
     final response = await http.get(url);
     if(response.statusCode == 200){
       final decode = json.decode(response.body);
       name = decode[1]['name'];
       email = decode[1]['email'];
       street = decode[1]['address']['street'];
       suit = decode[1]['address']['suite'];
       city = decode[1]['address']['city'];
       username = decode[1]['username'];
       phone = decode[1]['phone'];
     }else{
       print("Here's an Error");
     }
  }
  void setUserIntoVeriables(){
   getDemoUsers().then((value) {
     print(value[1]['name']);
     // email = value['email'];
     // name = value['name'];
     // username = value['username'];
   });
  }
}
