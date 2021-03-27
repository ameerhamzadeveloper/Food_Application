import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery_app/customer_app/model/profile_provider.dart';
import 'package:food_delivery_app/routes/routes_names.dart';

GlobalKey<FormState> _key = GlobalKey<FormState>();

class CreateProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return Scaffold(
        body: profileProvider.isSave
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: kThemeColor,
                ),
              )
            : Form(
                key: _key,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              Align(child: profileProvider.showImage()),
                              Positioned(
                                top: 60,
                                left: 100,
                                right: 0,
                                bottom: 0,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.add_a_photo,
                                    size: 50,
                                    color: kThemeColor,
                                  ),
                                  onPressed: () {
                                      profileProvider.pickImage();
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          TextField(
                            onChanged: (val) {
                                profileProvider.name = val;
                            },
                            decoration: InputDecoration(
                              hintText: "Name",
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          profileProvider.isAddress ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: TextField(
                                        decoration: InputDecoration(
                                            labelText:"House No"
                                        ),
                                        onChanged: (val){
                                          profileProvider.houseNo = val;
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Expanded(
                                      child: TextField(
                                        decoration: InputDecoration(
                                            labelText:"Street No"
                                        ),
                                        onChanged: (val){
                                          profileProvider.streetNo = val;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                TextField(
                                  decoration: InputDecoration(
                                      labelText:"Area"
                                  ),
                                  onChanged: (val){
                                    profileProvider.area = val;
                                  },
                                ),
                                SizedBox(height: 10,),
                                TextField(
                                  decoration: InputDecoration(
                                      labelText:"City"
                                  ),
                                  onChanged: (val){
                                    profileProvider.city = val;
                                  },
                                ),
                              ],
                            ),
                          ):
                          InkWell(
                            onTap: (){
                              profileProvider.addressEnter();
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Address",style: TextStyle(fontSize: 16,color: Colors.grey[700]),),
                                SizedBox(height: 5,),
                                Divider(
                                  color: Colors.grey,
                                  thickness: 1,
                                )
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                                  keyboardType: TextInputType.phone,
                                  onChanged: (val) {
                                    profileProvider.phone = val;
                                  },
                                  decoration: InputDecoration(
                                    ///this is problem
                                    hintText: "Phone",
                                  ),
                                ),
                          SizedBox(
                            height: 20,
                          ),
                            TextField(
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: (val) {
                                    profileProvider.email = val;
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Email",
                                  ),
                               ),
                          SizedBox(
                            height: 60,
                          ),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            height: 50,
                            color: kThemeColor,
                            onPressed: () {
                              if (_key.currentState.validate()) {
                                _key.currentState.save();
                                  profileProvider.isSaveForCircularProgressIntoTrue();
                                  profileProvider.uploadUserProfileInfo(context);
                                  Navigator.pushNamed(context, navigationBar);
                              }
                            },
                            child: Text(
                              "Continue",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
    );
  }
}
