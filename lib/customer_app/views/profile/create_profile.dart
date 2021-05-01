import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery_app/customer_app/model/profile_provider.dart';
import 'package:food_delivery_app/routes/routes_names.dart';

GlobalKey<FormState> _key = GlobalKey<FormState>();

class CreateProfile extends StatefulWidget {

  @override
  _CreateProfileState createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {

  @override
  void initState() {
    Provider.of<ProfileProvider>(context,listen: false).getIdEmail();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return Scaffold(
        body: profileProvider.isLoading
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(kThemeColor),
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
                          profileProvider.isImage ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.info,color: Colors.red,),
                              SizedBox(width: 5,),
                              Text("Image is Required",style: TextStyle(color: Colors.red),),
                            ],
                          ): Container(),
                          SizedBox(
                            height: 40,
                          ),
                          TextFormField(
                            onChanged: (val) {
                                profileProvider.name = val;
                            },
                            decoration: InputDecoration(
                              hintText: "Name",
                            ),
                            validator: (val){
                              if(val.isEmpty){
                                return "Name is Required";
                              }else{
                                return null;
                              }
                            },
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
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                            labelText:"House No"
                                        ),
                                        onChanged: (val){
                                          profileProvider.houseNo = val;
                                        },
                                        validator: (val){
                                          if(val.isEmpty){
                                            return "House No is Required";
                                          }else{
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Expanded(
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                            labelText:"Street No"
                                        ),
                                        onChanged: (val){
                                          profileProvider.streetNo = val;
                                        },
                                        validator: (val){
                                          if(val.isEmpty){
                                            return "Street is Required";
                                          }else{
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                TextFormField(
                                  decoration: InputDecoration(
                                      labelText:"Area"
                                  ),
                                  onChanged: (val){
                                    profileProvider.area = val;
                                  },
                                  validator: (val){
                                    if(val.isEmpty){
                                      return "Area is Required";
                                    }else{
                                      return null;
                                    }
                                  },
                                ),
                                SizedBox(height: 10,),
                                TextFormField(
                                  decoration: InputDecoration(
                                      labelText:"City"
                                  ),
                                  onChanged: (val){
                                    profileProvider.city = val;
                                  },
                                  validator: (val){
                                    if(val.isEmpty){
                                      return "City is Required";
                                    }else{
                                      return null;
                                    }
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
                          TextFormField(
                                  keyboardType: TextInputType.phone,
                                  onChanged: (val) {
                                    profileProvider.phone = val;
                                  },
                                  decoration: InputDecoration(
                                    ///this is problem
                                    hintText: "Phone",
                                  ),
                            validator: (val){
                              if(val.isEmpty){
                                return "Phone is Required";
                              }else{
                                return null;
                              }
                            },
                                ),
                          SizedBox(
                            height: 20,
                          ),
                            TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: (val) {
                                    profileProvider.email = val;
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Email",
                                  ),
                              validator: (val){
                                if(val.isEmpty){
                                  return "Email is Required";
                                }else if (!RegExp(
                                    r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                    .hasMatch(val)) {
                                  return 'Please enter a valid email Address';
                                }else{
                                  return null;
                                }
                              },
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
                            onPressed: (){
                              if (_key.currentState.validate()) {
                                _key.currentState.save();
                                  profileProvider.uploadUserProfileInfo(context);
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
