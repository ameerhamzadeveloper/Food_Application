import 'package:flutter/material.dart';
import 'package:food_delivery_app/localization/demo_localization.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

const String kServerUrlName = "https://tripps.live/tripp_food/API/";
const String kImageUrlEnd = "https://tripps.live/tripp_food/";

String kGetTranslated(BuildContext context, String key){
    return DemoLocalization.of(context).getTranslatedValue(key);
}

const TextStyle kWhiteTextColor = TextStyle(color: Colors.white, fontSize: 18);
const TextStyle kLogoTextColor = TextStyle(color: Colors.white, fontSize: 22);
const Color kThemeColor = Color(0xff148287);
const Color kWhiteColor = Color(0xffffffff);

//resturant page constants

const TextStyle kResturantTitleStyle =
    TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
const TextStyle kLastResturantTextStyle =
    TextStyle(fontWeight: FontWeight.w600);
const TextStyle kAllResturantTitleStyle =
TextStyle(fontSize: 15, fontWeight: FontWeight.w600);
const TextStyle kAllLastResturantTextStyle =
TextStyle(fontWeight: FontWeight.w600);
// resturant app constants;
const kTopLebelStyle = TextStyle(fontSize: 25, fontWeight: FontWeight.w500);
const kLebelStyle = TextStyle(fontSize: 14);
const kBtnStyle = TextStyle(color: Colors.white, fontSize: 20);
const kAppBarTitle = TextStyle(color: Colors.black);
const textstyl = TextStyle(fontSize: 18.0, color: Color(0xff000000));

const TextStyle kEmailError = TextStyle(color: Colors.red);
PinDecoration kPinDecoration = UnderlineDecoration( hintText: '000000',colorBuilder: PinListenColorBuilder(Colors.cyan, Colors.green));