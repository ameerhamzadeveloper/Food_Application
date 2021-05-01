import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/common_screens/sign_up_welcome_screen.dart';
import 'package:food_delivery_app/customer_app/model/my_orders_model.dart';
import 'package:food_delivery_app/customer_app/model/my_transaction.dart';
import 'package:food_delivery_app/customer_app/model/user_address_model.dart';
import 'package:food_delivery_app/routes/routes_names.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import '../../constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider extends ChangeNotifier {
  bool isSave = false;
  File image;
  String name;
  String phone;
  String address;
  String houseNo;
  String streetNo;
  String area;
  String city;
  String email;
  String userid;
  String storedEmail;
  bool isAddress = false;
  bool isCardAdded = false;
  bool isLoading = false;
  String defaultImage = "https://i.stack.imgur.com/l60Hf.png";
  bool isImage = false;


  void addressEnter(){
    isAddress = true;
    notifyListeners();
  }

  //Picking image

  Future pickImage() async {
    var sampleImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    image = sampleImage;
    notifyListeners();
  }

  //show Image for Upload

  Widget showImage() {
    if (image != null) {
      return ClipOval(
          child: Image.file(
        image,
        fit: BoxFit.fill,
        height: 120,
        width: 120,
      ));
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

  void isSaveForCircularProgressIntoTrue() {
    isSave = false;
  }

  // upload create user profile
  Future<dynamic>  uploadUserProfileInfo(BuildContext context) async {
    if(image != null){
      print(userid);
      print(name);
      print(email);
      print(phone);
      print(houseNo);
      print(streetNo);
      print(area);
      print(city);
      try{
        isLoading = true;
        notifyListeners();
        print(image.path);
        String url = "${kServerUrlName}profile.php";
        var request = await http.MultipartRequest('POST',Uri.parse(url));
        var imagee = await http.MultipartFile.fromPath('img', image.path);
        // request.fields['img'] = image.path.toString();
        request.fields['login_id'] = userid;
        request.fields['name'] = name;
        request.fields['email'] = email;
        request.fields['phone'] = phone;
        request.fields['house_no'] = houseNo;
        request.fields['street_no'] = streetNo;
        request.fields['area'] = area;
        request.fields['city'] = city;
        request.files.add(imagee);
        request.send();
        Future<void> addAddress() async {
          String url = "${kServerUrlName}add_address.php";
          http.Response response = await http.post(url,body: ({
            'house_no': houseNo,
            'area': area,
            'street_no': streetNo,
            'city': city,
            'user_signup_id': userid,
            'address_type': 'Home',
          }));
          var de = json.decode(response.body);
          print(de);
        }
        Future.delayed(Duration(seconds: 5),(){
          Navigator.of(context)
              .pushNamedAndRemoveUntil(navigationBar, (Route<dynamic> route) => false);
        });
        notifyListeners();
      }catch(e){
        isLoading = false;
        notifyListeners();
      }
    }else{
      isImage = true;
      notifyListeners();
    }
  }

  // fetching user profiles
  dynamic displayName;
  dynamic displayPhone;
  dynamic displayHouseNo;
  dynamic displayStreet;
  dynamic displayArea;
  dynamic displayCity;
  dynamic diaplayImage;

  dynamic deliveryHouse;
  dynamic deliveryStreet;
  dynamic deliveryArea;
  dynamic deliveryCity;

  void getIdEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userid = preferences.getString('id');
    storedEmail = preferences.getString('email');
    print(userid);
  }

  Future<void> fetchUserProfile() async {
    String url = "${kServerUrlName}fetch_userprofile.php";
    http.Response response = await http.post(url,body: ({
      'id': userid,
    }));
    var decode = json.decode(response.body);
    print(decode);
    if(response.statusCode == 200){
      displayName = decode['profile'][0]['name'];
      displayHouseNo = decode['profile'][0]['house_no'];
      displayStreet = decode['profile'][0]['street_no'];
      displayArea = decode['profile'][0]['area'];
      displayCity = decode['profile'][0]['city'];
      displayPhone = decode['profile'][0]['phone'];
      diaplayImage = decode['profile'][0]['profile_img'];

      deliveryHouse = decode['profile'][0]['house_no'];
      deliveryStreet = decode['profile'][0]['street_no'];
      deliveryArea = decode['profile'][0]['area'];
      deliveryCity = decode['profile'][0]['city'];
    }else{
      print("errorrrr");
    }
    notifyListeners();
  }


  static const String url = "${kServerUrlName}my_total_order.php";

  Future<List<MyTotalOrders>> myTotalOrders() async {
    http.Response response = await http.post(url,body: ({
      'customer_id': userid,
    }));
    var dec = json.decode(response.body);
    print(dec);
    if (200 == response.statusCode && dec[0]['status'] == 1) {
      List<MyTotalOrders> myOrders = myTotalOrdersFromJson(response.body);
      return myOrders;
    }else{
      return List<MyTotalOrders>();
    }

  }
  List<MyTotalOrders> orders;

  void showORders()async{
    await myTotalOrders().then((value){
      orders = value;
    });
    notifyListeners();
  }

  String addHouse;
  String addArea;
  String addStreet;
  String addCity;
  String cartAddress;

  void setHouse(String val){
    addHouse = val;
    notifyListeners();
  }
  void setStreet(String val){
    addStreet = val;
    notifyListeners();
  }
  void setArea(String val){
    addArea = val;
    notifyListeners();
  }
  void setCity(String val){
    addCity = val;
    notifyListeners();
  }

  Future<void> addAddress() async {
    String url = "${kServerUrlName}add_address.php";
    print(addHouse);
    print(addArea);
    print(addStreet);
    print(addCity);
    print(userid);
    // print(addCity);
    http.Response response = await http.post(url,body: ({
      'house_no': addHouse,
      'area': addArea,
      'street_no': addStreet,
      'city': addCity,
      'user_signup_id': userid,
      'address_type': 'Home',
    }));
    var de = json.decode(response.body);
    print(de);
  }

  List<UserAddress> userAddresses;

  Future<List<UserAddress>> fetchUserAddress() async {
    const String url = "${kServerUrlName}fetch_address.php";
    http.Response response = await http.post(url,body: ({
      'user_signup_id' : userid,
    }));
    if (200 == response.statusCode) {
      List<UserAddress> myOrders = userAddressFromJson(response.body);
      cartAddress = "${myOrders[0].houseNo} ${myOrders[0].streetNo} ${myOrders[0].area} ${myOrders[0].city}";
      return myOrders;
    }else{
      return List<UserAddress>();
    }

  }

  Future<void> showUSerAddress()async{
    await fetchUserAddress().then((value){
      userAddresses = value;
    });
    notifyListeners();
  }
  String message;
  double stars = 0.0;
  void setStars(double star){
    stars = star;
    notifyListeners();
  }
  void setMessage(String value){
    message = value;
    notifyListeners();
  }
  Future<void> postAppFeedBack() async{
    print(userid);
    print(stars);
    print(message);
    String url = "${kServerUrlName}feedback_from_app.php";
    http.Response response = await http.post(url,body: ({
      'userId': userid,
      'stars': stars.toString(),
      'message': message,
    }));
    var deco = json.decode(response.body);
    print(deco);
    print(response.statusCode);
  }

  Future<List<MyTransaction>> myTransactions() async {


    const String url = "${kServerUrlName}fetch_my_transactions.php";
    http.Response response = await http.post(url,body: ({
      'user_id':'60',
    }));
    var dec = json.decode(response.body);
    print(dec);
    if (200 == response.statusCode) {
      List<MyTransaction> myOrders = myTransactionFromJson(response.body);
      return myOrders;
    }else{
      return List<MyTransaction>();
    }

  }
  List<MyTransaction> myTransaction;

  void showTransaction()async{
    await myTransactions().then((value){
      myTransaction = value;
    });
    notifyListeners();
  }

  void logout(BuildContext context)async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('id');
    pref.remove('email');
    pref.remove('role');
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
      builder: (context) => SignUpWelcome()
    ), (route) => false);
  }
}
