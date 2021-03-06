import 'dart:convert';
import 'package:food_delivery_app/delivery_boy_app/views/home_page/home_page.dart';
import 'package:food_delivery_app/resturant_app/views/home/resturant_home.dart';
import 'package:food_delivery_app/routes/routes_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/common_screens/veiry_email.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/common_screens/sign_up_role.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:food_delivery_app/routes/routes_names.dart';

class SignUpModel extends ChangeNotifier {

  bool isSignUp = true;
  bool isLoading = false;
  bool isCodeSent = false;
  String email;
  String password;
  String role;
  dynamic id;
  String storedEmail;
  bool isCodeInvalid = false;
  String code;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  var _verificationId;

  void setEmail(String val){
    email = val;
  }
  void setRole(String val){
    role = val;
  }
  void setPass(String val){
    password = val;
  }

  void setCode(String val){
    code = val;
  }

  // Signup user with phone number
  void onVerifyCode(String number, BuildContext context, countryCode) async {
    isCodeSent = true;
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      _firebaseAuth
          .signInWithCredential(phoneAuthCredential)
          .then((UserCredential value) {
        if (value.user.displayName != null && value.user != null) {
          // Handle loogged in state
          print(value.user.phoneNumber);
//           Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(
//                 builder: (context) =>BottomNavBar(
// //                  user: value.user,
//                 ),
//               ),
//                   (Route<dynamic> route) => false);
        } else if (value.user != null && value.user.displayName == null) {
          MaterialPageRoute(
            builder: (context) => SignRole(),
          );
        } else {
          Text("Error validating OTP, try again");
        }
      }).catchError((error) {
        Text("Something went wrong");
      });
    };
    final PhoneVerificationFailed verificationFailed = (authException) {
      Text(authException.message);
      isCodeSent = false;
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      _verificationId = verificationId;
    };
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
    };

    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: "$countryCode$number",
        timeout: const Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  // on code submit
  void onFormSubmitted(
      TextEditingController _pinEditingController, BuildContext context) async {
    AuthCredential _authCredential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: _pinEditingController.text);

    _firebaseAuth
        .signInWithCredential(_authCredential)
        .then((UserCredential value) {
      if (value.user != null && value.user.displayName != null) {
        // Handle loogged in state
        print(value.user.phoneNumber);
//         Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute(
//               builder: (context) => BottomNavBar(
// //                user: value.user,
//               ),
//             ),
//                 (Route<dynamic> route) => false);
      } else if (value.user.displayName == null && value.user != null) {
        MaterialPageRoute(
          builder: (context) => SignRole(),
        );
      } else {
        Text("Error validating OTP, try again");
      }
    }).catchError((error) {
      Text("Something went wrong");
    });
  }
  void loading() {
    isLoading = true;
    notifyListeners();
  }
  // signup into signin by bool value
  void changeIntoSignup() {
    isSignUp = !isSignUp;
    notifyListeners();
  }
  String error;
  void emptyError(){
    error = null;
    notifyListeners();
  }

  // showing error for email sign up
  Widget showError() {
    if (error != null) {
      return Container(
        color: Colors.yellow,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.error_outline,
              color: Colors.red,
            ),
            SizedBox(
              width: 5.0,
            ),
            Expanded(
              child: Text(
                error,
                style: kEmailError,
              ),
            )
          ],
        ),
      );
    } else {
      return SizedBox(
        height: 0,
      );
    }
  }

  // signUp user with email password
  void signUpUser(BuildContext context) async {
    print(email);
    print(password);
    isLoading = true;
    notifyListeners();
    // await OneSignal.shared.sendTag(email, "yes");
    var url =
        "${kServerUrlName}signup.php";
    http.Response response = await http.post(url,
        body: ({
          'email': email,
          'pass': password,
        }),
        headers: {'Accept': 'application/json'});
    var dec = json.decode(response.body);
    if(response.statusCode == 200){
      isLoading = false;
      notifyListeners();
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          VerifyEmail()), (Route<dynamic> route) => false);
    }else{
      showError();
    }
  }

  // signin user
  void signInUser(BuildContext context) async {
    print(email);
    print(password);
    isLoading = true;
    notifyListeners();
    String url = "${kServerUrlName}login.php";
    http.Response response = await http.post(url,body: ({
      'email':email,
      'password' :password,
    }));
    var de = jsonDecode(response.body);
    if(response.statusCode == 200){
      isLoading = false;
      notifyListeners();
      switch(de['data'][0]['status']){
        case 0:
          error = "Incorrect password";
          isLoading = false;
          notifyListeners();
          break;
        case 1:
          email = de['data'][0]['email'];
          id = de['data'][0]['id'];
          storeValInSharedPref();
          saveRoleinSharedPref(de['data'][0]['role']);
          switch(de['data'][0]['role']){
            case '1':
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(navigationBar, (Route<dynamic> route) => false);
              break;
            case '2':
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(resturantHome, (Route<dynamic> route) => false);
              break;
            case '3':
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(deliHome, (Route<dynamic> route) => false);
          }
          break;
        case 2:
          isLoading = false;
          notifyListeners();
          error = "Account is Not Verified";
          break;
        case 3:
          isLoading = false;
          notifyListeners();
          error = "Account doesn't exist";
          break;
      }

      // status 0 password incorrect
      // status 1 everything is okay sucess
      // status 2 account not verified
      // staus 3 account doesnt exist
    }else{
      error = "Network Error Try Again Later";
      loading();
    }
    notifyListeners();
  }

   storeValInSharedPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('email', email);
    preferences.setString('id', id);
  }
   getStoredEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    storedEmail = preferences.getString('email');

  }
  getStoredId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    id = preferences.getString('id');
  }

  verifyEmail(BuildContext context) async {
    // getStoredEmail();
    // getStoredId();
    print(email);
    print(code);
    isLoading = true;
    notifyListeners();
    String url =
        "${kServerUrlName}verification.php";
    http.Response response = await http.post(url,body: ({
      'email' : email,
      'code' : code,
    }));
    var decode = jsonDecode(response.body);
    print(decode);
    if(decode['login'][0]['status'] == '1'){
      email = decode['login'][0]['email'];
      id = decode['login'][0]['id'];
      storeValInSharedPref();
      isLoading = false;
      notifyListeners();
      Navigator.pushReplacementNamed(context, signRole);
    }else{
      isCodeInvalid = true;
      isLoading = false;
      notifyListeners();
      print("error");
    }
  }
  void saveRoleinSharedPref(String role)async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('role', role);
  }

  void roleUpdate(int index) async {
    String url = "${kServerUrlName}role.php";
    saveRoleinSharedPref(index.toString());
    if(index == 1){
      http.Response response = await http.post(url,body: ({
        'id': id,
        'email': email,
        'role': index.toString(),

      }));
    }else if(index == 2){
      http.Response response = await http.post(url,body: ({
        'id': id,
        'email': email,
        'role': index.toString(),

      }));
    }else{
      http.Response response = await http.post(url,body: ({
        'id': id,
        'email': email,
        'role': index.toString(),
      }));
    }
  }

}
