import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/customer_app/model/profile_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class WalletProvider extends ChangeNotifier{
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool isCardAdded = false;

  void cardAdded(){
    isCardAdded = true;
    notifyListeners();
  }

  Future<void> fetchCardWallet(context) async {
    final pro = Provider.of<ProfileProvider>(context,listen: false);
    String url = "${kServerUrlName}fetch_payment_card.php";
    http.Response response = await http.post(url,body: ({
      'user_id': pro.userid,
    }));
    var decode = json.decode(response.body);
    // print(decode);
    print(decode["data"][0].toString());
    if(decode['data'][0]['status'] == "1"){

      cardNumber = decode['data'][0]['card_no'];
      cardHolderName = decode['data'][0]['holder_name'];
      cvvCode = decode['data'][0]['cvc'];
      expiryDate = decode['data'][0]['expiry_date'];
      // print(cardHolderName = decode['data'][0]['holder_name']);
      isCardAdded = true;
      notifyListeners();
    }
    notifyListeners();
  }

  Future<void> addCardIntoWallet(context) async {
    final pro = Provider.of<ProfileProvider>(context,listen: false);
    String url = "${kServerUrlName}add_card.php";
    http.Response response = await http.post(url,body: ({
      'user_id': pro.userid,
      'hodler_name': cardHolderName.toString(),
      'card_no': cardNumber.toString(),
      'cvc': cvvCode.toString(),
      'expiry_date': expiryDate.toString(),
    }));
    var decode = json.decode(response.body);
    print(decode);
    if(decode['status'] == 1){
      cardAdded();
    }else{
      print("error");
    }
    notifyListeners();
  }
}