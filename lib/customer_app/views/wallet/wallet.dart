import 'package:credit_card/credit_card_form.dart';
import 'package:credit_card/credit_card_model.dart';
import 'package:credit_card/credit_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/customer_app/model/profile_provider.dart';
import 'package:food_delivery_app/customer_app/model/wallet_provider.dart';
import 'package:food_delivery_app/customer_app/views/wallet/all_transactions.dart';
import 'package:food_delivery_app/routes/routes_names.dart';
import 'package:provider/provider.dart';

class Wallet extends StatefulWidget {
  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<WalletProvider>(context);
    final profPro = Provider.of<ProfileProvider>(context);
    return Scaffold(
        appBar: AppBar(
          leading: Container(),
          title: Text(
            kGetTranslated(context, 'wallet')
          ),
        ),
        body: SingleChildScrollView(
          child:

          Column(
            children: [
              pro.isCardAdded ?
              CreditCardWidget(
                cardNumber: pro.cardNumber,
                expiryDate: pro.expiryDate,
                cardHolderName: pro.cardHolderName,
                cvvCode: pro.cvvCode,
                showBackView: pro.isCvvFocused,
                //true when you want to show cvv(back) view
              )
                  :
              Column(
                children: [

                  CreditCardWidget(
                    cardNumber: pro.cardNumber,
                    expiryDate: pro.expiryDate,
                    cardHolderName: pro.cardHolderName,
                    cvvCode: pro.cvvCode,
                    showBackView: pro.isCvvFocused,
                    //true when you want to show cvv(back) view
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        CreditCardForm(
                          themeColor: Colors.red,
                          onCreditCardModelChange: (CreditCardModel data) {
                            setState(() {
                              pro.cardNumber = data.cardNumber;
                              pro.expiryDate = data.expiryDate;
                              pro.cardHolderName = data.cardHolderName;
                              pro.cvvCode = data.cvvCode;
                              pro.isCvvFocused = data.isCvvFocused;
                            });
                          },
                        ),
                        SizedBox(height: 20,),
                        FlatButton(
                          shape: StadiumBorder(),
                          height: 50,
                          minWidth: double.infinity,
                          color: kThemeColor,
                          onPressed: ()async{
                            await pro.addCardIntoWallet(context);
                            if(pro.isCardAdded == true){
                              Scaffold.of(context).showSnackBar(SnackBar(content: Text("Card Added Successfully!")));
                            }
                          },
                          child: Text("Add Card",style: TextStyle(color: Colors.white),),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(kGetTranslated(context, 'recent_transactions')),
                        FlatButton(
                          onPressed: (){
                            Navigator.pushNamed(context, allTransactions);
                          },
                          child: Text("See all"),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}
