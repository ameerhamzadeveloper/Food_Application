import 'dart:convert';
import 'dart:io';
import 'package:food_delivery_app/common_screens/sign_up_welcome_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/resturant_app/views/signup/components/drop_down_list_values.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:food_delivery_app/routes/routes_names.dart';

class ResturantProfileProvider extends ChangeNotifier{
  File selfieImage;
  File resturantImage;
  File cnicFront;
  File cnicBack;

  String businessName;
  String city;
  String businessAddress;
  String businessDescription;
  String firstName;
  String lastName;
  String contact;
  String email;
  String commercialReg;
  String noOfBranches;

  double lat;
  double long;

  String storedEmail;
  String userid;

  void setBusinessName(String val){
    businessName = val;
  }
  void setBusinessDescription(String val){
    businessDescription = val;
  }
  void setCity(String val){
    city = val;
  }
  void setbusinessAddress(String val){
    businessAddress = val;
  }
  void setfirstName(String val){
    firstName = val;
  }
  void setLastName(String val){
    lastName = val;
  }
  void setContact(String val){
    contact = val;
  }
  void setEmail(String val){
    email = val;
  }
  void setCommReg(String val){
    commercialReg = val;
  }
  void setNoOfBran(String val){
    noOfBranches = val;
  }


  Future pickSelfieImage() async {
    var sampleImage = await ImagePicker.pickImage(source: ImageSource.gallery);
      selfieImage = sampleImage;
      notifyListeners();
  }

  Widget showSelfieImage() {
    if (selfieImage != null) {
      return Image.file(
        selfieImage,
        fit: BoxFit.fill,
        // height: 120,
        // width: 120,
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

  Future pickResturantImage() async {
    var sampleImage = await ImagePicker.pickImage(source: ImageSource.gallery);
      resturantImage = sampleImage;
    notifyListeners();
  }

  Widget showResturantImage() {
    if (resturantImage != null) {
      return Image.file(
        resturantImage,
        fit: BoxFit.fill,
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

  Future pickCnicFonrtImage() async {
    var sampleImage = await ImagePicker.pickImage(source: ImageSource.gallery);
      cnicFront = sampleImage;
    notifyListeners();
  }

  Widget showCnicFonrtImage() {
    if (cnicFront != null) {
      return Image.file(
        cnicFront,
        fit: BoxFit.fill,
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

  Future pickCnicBackImage() async {
    var sampleImage = await ImagePicker.pickImage(source: ImageSource.gallery);
      cnicBack = sampleImage;
    notifyListeners();
  }

  Widget showCnicBackImage() {
    if (cnicBack != null) {
      return Image.file(
        cnicBack,
        fit: BoxFit.fill,
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


  String providerValue = "Resturant";
  List<DropdownMenuItem> getProviderList() {
    List<DropdownMenuItem<String>> list = [];
    for (var i = 0; i < providerType.length; i++) {
      String currency = providerType[i];
      var newList = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      list.add(newList);
    }
    return list;
  }

  String segments = "Regular Resturant";
  List<DropdownMenuItem> getSegmentList() {
    List<DropdownMenuItem<String>> list = [];
    for (var i = 0; i < segmentsResturants.length; i++) {
      String currency = segmentsResturants[i];
      var newList = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      list.add(newList);
    }
    return list;
  }

  String cuisine = "Cuisine";
  List<DropdownMenuItem> getCuisineList() {
    List<DropdownMenuItem<String>> list = [];
    for (var i = 0; i < cuisineList.length; i++) {
      String currency = cuisineList[i];
      var newList = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      list.add(newList);
    }
    return list;
  }
  void setCuisine(String val){
    cuisine = val;
    notifyListeners();
  }
  void setSegments(String val){
    segments = val;
    notifyListeners();
  }
  void setproviderValue(String val){
    providerValue = val;
    notifyListeners();
  }


  int doYouHaveFranchise = 0;
  void doYouHaveFranchiseValueChange(val) {
      doYouHaveFranchise = val;
      notifyListeners();
  }

  int doYouHaveDeliveryService = 0;
  void doYouHaveDeliveryServiceValueChange(val) {
      doYouHaveDeliveryService = val;
      notifyListeners();
  }

  int doYouHaveOtherApplications = 0;
  void doYouHaveOtherApplicationsValueChange(val) {
      doYouHaveOtherApplications = val;
      notifyListeners();
  }

  int areYouTheOwner = 0;
  void areYouTheOwnerValueChange(val) {
      areYouTheOwner = val;
      notifyListeners();
  }

  Future<void> getIdEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
  
    userid = preferences.getString('id');
    storedEmail = preferences.getString('email');
      print("USERIDddddddddddddddddddddddddddddddddddd");
      print(userid);
      print(storedEmail);
      print("USERIDddddddddddddddddddddddddddddddddddd");
    
    notifyListeners();
    print(userid);
  }



  // upload resturant info

  Future<void> uploadResturantInfo(BuildContext context) async {
    String url = "${kServerUrlName}resturant_info.php";
    try{
      var request = await http.MultipartRequest('POST',Uri.parse(url));
      print("text Start");
      print(userid);
      print(businessName);
      print(businessDescription);
      print(firstName);
      print(lastName);
      print(businessAddress);
      print(email);
      print(contact);
      print(providerValue);
      print(segments);
      print(cuisine);
      print(city);
      print(commercialReg);
      print(lat.toString());
      print(long.toString());
      print(noOfBranches);
      print(doYouHaveFranchise.toString());
      print(doYouHaveDeliveryService.toString());
      print(doYouHaveOtherApplications.toString());
      print(areYouTheOwner.toString());
      print("TExt End");

      
    

      var selfie = await http.MultipartFile.fromPath('my_selfie', selfieImage.path);
      var resturantImg = await http.MultipartFile.fromPath('resutrant_selfie', resturantImage.path);
      var cardFront = await http.MultipartFile.fromPath('id_front', cnicFront.path);
      var cardBack = await http.MultipartFile.fromPath('id_back', cnicBack.path);

      print("imagesssssssss");
      print(selfie.toString());
      print(resturantImg.toString());
      print(cardFront.toString());
      print(cardBack.toString());
      print("imagesdfsddvsv");

      request.fields['login_id'] = userid??"100";
      request.fields['b_name'] = businessName;
      request.fields['b_description'] = businessDescription;
      request.fields['firstname'] = firstName;
      request.fields['lastname'] = lastName;
      request.fields['b_address'] = businessAddress;
      request.fields['email'] = email;
      request.fields['phone'] = contact;
      request.fields['vertical'] = providerValue ?? "Resturant";
      request.fields['vertical_segment'] = segments ?? "Regular Resturant";
      request.fields['cuisine'] = cuisine ?? "Other";
      request.fields['city'] = city;
      request.fields['comercial_reg'] = commercialReg;
      request.fields['lat'] = "${lat.toString()}";
      request.fields['long'] = "$long";
      request.fields['no_of_branches'] = noOfBranches;
      request.fields['franchise'] = doYouHaveFranchise == 0 ? "Yes":"No";
      request.fields['delivery'] = doYouHaveDeliveryService == 0 ? "Yes":"No";
      request.fields['deli_application'] = doYouHaveOtherApplications == 0 ? "Yes":"No";
      request.fields['owner'] = areYouTheOwner == 0 ? "Yes":"No";

      request.files.add(selfie);
      request.files.add(resturantImg);
      request.files.add(cardFront);
      request.files.add(cardBack);
      http.StreamedResponse response = await request.send();
      response.stream.transform(utf8.decoder).listen(( value) {
        // if(value == "You must chose image")
          Navigator.pushNamed(context, resturantHome);
        print("valulkdnsbvlfnkjfnvfkjdnvfkjvnkjvn ckvn kvj nkcvn kjcn ljkvn ;vjc jnvkn cvkj ncve");
        print(value);
        print(value);
        print("kznvlnvjlkncvlkcnvlkcbnlkvnb lkcvn blkcn lknvl ncvkn vcn lcn lcn lkcn /lkcn v/lkcnv/lkcxbn/lxkcbn");
      });
    }catch(e){
       print(e);
       print(e.message);
    }
  }
  String resturantId;
  void saveSharedPreference(String id) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('resturantId', id);
  }

  // fetching resturant profiles

  dynamic profileName;
  dynamic profileImage;
  dynamic rating;
  Future<void> fetchResturantProfile() async {
    String url = "${kServerUrlName}fetch_resturant_profile.php";
    print("userid");
    print(userid);
    print("userid");
    http.Response response = await http.post(url,body: ({
      'resturant_id': "60",
    }));
    print(response.body.toString());
    var decode = jsonDecode(response.body);
    print(response.statusCode);
    if(response.statusCode == 200){
      saveSharedPreference(decode['data'][0]['id']);
      resturantId = decode['data'][0]['id'];
      profileName = decode['data'][0]['b_name'];
      profileImage = decode['data'][0]['resutrant_selfie'];
      rating = decode['data'][0]['rating'];
      print(decode['data'][0]['id']);
    }
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

  // function for raiting

   avaluateRating(){
    if(rating == '1'){
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
    }if(rating == '0'){
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
    }else if(rating == '2'){
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
    }else if(rating == '3'){
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
    }else if(rating == '4'){
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