import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/routes/routes_names.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // final AnimatedNavigator animated = AnimatedNavigator();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      // Provider.of<InfluencerProvider>(context, listen: false)
      //     .getBrandsList(context);
      // Provider.of<BrandProvider>(context, listen: false)
      //     .getInfluencerList(context);
    });

    Future.delayed(Duration(seconds: 3)).then((_) async {
      final prefs = await SharedPreferences.getInstance();

      if (prefs.getString("id") != null) {
        if(prefs.get("role") == "1") {
          Navigator.pushReplacementNamed(context, navigationBar);
        }else if(prefs.get("role") == "2"){
          Navigator.pushReplacementNamed(context, resturantHome);
        }else if(prefs.get("role") == "3"){
          Navigator.pushReplacementNamed(context, deliHome);
        }else{
          Navigator.pushReplacementNamed(context, startAppScreen);
        }
        // if (prefs.getString("type") == "Brand") {
          //  animated.pushAndRemoveUntil(context: context,duration: Duration(seconds:5),page:  HomeBrand(1),curve: Curves.elasticOut);
          // Navigator.of(context).pushAndRemoveUntil(
          //     MaterialPageRoute(builder: (context) => HomeBrand(1)),
          //         (Route<dynamic> route) => false);

      } else {
        Navigator.pushReplacementNamed(context, startAppScreen);
        // animated.pushAndRemoveUntil(
        //     context: context,
        //     duration: Duration(seconds: 3),
        //     page: UserTypePage(),
        //     curve: Curves.elasticOut);
        // Nav.brandPage(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                kThemeColor,
              ],
            ),
          ),
          child: Center(
            child: Container(
              width: width / 2,
              child: Image.asset(
                'images/deliveryBoy.png',
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
