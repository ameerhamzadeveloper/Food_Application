import 'dart:io';
import 'package:food_delivery_app/delivery_boy_app/views/signup/components/drop_down_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:hijri_picker/hijri_picker.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:food_delivery_app/models/sign_up_model.dart';

class DeliSignUpModel extends ChangeNotifier{

  String firstName;
  String familyName;
  String phone;
  String buildNo;
  String unit;
  String streetAdd;
  String city;
  String zipCode;
  String iqamaNo;



  DateTime dateTime = DateTime.now();
  Future<void> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != dateTime){
      dateTime = picked;
    }
    notifyListeners();
  }

  var selectedDate = HijriCalendar.now();
  Future<Null> selectIslamicDate(BuildContext context) async {
    final local = Locale('ar', 'SA');
    HijriCalendar.setLocal(Localizations.localeOf(context).languageCode);
    final HijriCalendar picked = await showHijriDatePicker(
      context: context,
      initialDate: selectedDate,
      lastDate:  HijriCalendar()
        ..hYear = 1445
        ..hMonth = 9
        ..hDay = 25,
      firstDate:  HijriCalendar()
        ..hYear = 1438
        ..hMonth = 12
        ..hDay = 25,
      initialDatePickerMode: DatePickerMode.day,
    );
    if (picked != null) {
      selectedDate = picked;
    }
    notifyListeners();
  }

  File mySelfie;
  File idFront;
  File idBack;
  File licence;
  File vahicleDocom;

  Future pickSelfieImage() async {
    var sampleImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    mySelfie = sampleImage;
    notifyListeners();
  }

  Widget showSelfieImage() {
    if (mySelfie != null) {
      return Image.file(
        mySelfie,
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

  Future pickIdFront() async {
    var sampleImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    idFront = sampleImage;
    notifyListeners();
  }

  Widget showIDFrontImage() {
    if (idFront != null) {
      return Image.file(
        idFront,
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

  Future pickIdBack() async {
    var sampleImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    idBack = sampleImage;
    notifyListeners();
  }

  Widget showIdBackImage() {
    if (idBack != null) {
      return Image.file(
        idBack,
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

  Future pickLicence() async {
    var sampleImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    licence = sampleImage;
    notifyListeners();
  }

  Widget showLicenceImage() {
    if (licence != null) {
      return Image.file(
        licence,
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

  Future pickVahicleDoc() async {
    var sampleImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    vahicleDocom = sampleImage;
    notifyListeners();
  }

  Widget showVahicleImage() {
    if (vahicleDocom != null) {
      return Image.file(
        vahicleDocom,
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

  String countryVal = 'Saudi Arabia';
  List<DropdownMenuItem> getCountryList() {
    List<DropdownMenuItem<String>> list = [];
    for (var i = 0; i < dropDownCountry.length; i++) {
      String country = dropDownCountry[i];
      var newList = DropdownMenuItem(
        child: Text(country),
        value: country,
      );
      list.add(newList);
    }
    return list;
  }

  void setCountryVal(String val){
    countryVal = val;
    notifyListeners();
  }


  void uploadDeliBoyInfo(context) async {
    final prov = Provider.of<SignUpModel>(context,listen: false);
    String url = '${kServerUrlName}delivery_boy_info.php';
    var request = http.MultipartRequest('POST',Uri.parse(url));

    var selfie = await http.MultipartFile.fromPath('my_selfie', mySelfie.path);
    var drivingLic = await http.MultipartFile.fromPath('driving_license_img', licence.path);
    var idFrontt = await http.MultipartFile.fromPath('id_front', idFront.path);
    var idBackk = await http.MultipartFile.fromPath('id_back', idBack.path);
    var vahicleDoc = await http.MultipartFile.fromPath('vehicle_doc', vahicleDocom.path);

    request.fields['login_id'] = prov.id;
    request.fields['first_name'] = firstName;
    request.fields['family_name'] = familyName;
    request.fields['phone_number'] = phone;
    request.fields['bulding_no'] = buildNo;
    request.fields['unit'] = unit;
    request.fields['street_address'] = streetAdd;
    request.fields['city'] = city;
    request.fields['zipcode'] = zipCode;
    request.fields['country'] = countryVal ?? 'Saudi Arabia';
    request.fields['id_iqama_no'] = iqamaNo;
    request.fields['iqama_ex_date_en'] = "${dateTime.toLocal()}".split(' ')[0];
    request.fields['iqama_ex_date_ar'] = selectedDate.toString();

    request.files.add(selfie);
    request.files.add(drivingLic);
    request.files.add(idFrontt);
    request.files.add(idBackk);
    request.files.add(vahicleDoc);
    http.StreamedResponse response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }
}