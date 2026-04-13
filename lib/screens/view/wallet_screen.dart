import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project_hotel_bookking/core/constants/const_keys.dart';
import 'package:firebase_project_hotel_bookking/core/constants/widget_support.dart';
import 'package:firebase_project_hotel_bookking/service/database.dart';
import 'package:firebase_project_hotel_bookking/service/shared_preferncehelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Walletscreen extends StatefulWidget {
  const Walletscreen({super.key});

  @override
  State<Walletscreen> createState() => _WalletscreenState();
}

class _WalletscreenState extends State<Walletscreen> {
  TextEditingController amountcontroller = TextEditingController();
  Map<String, dynamic>? paymentIntent;

  String? email;
  String? wallet;
  String? id;

  getthesharedpref() async {
    email = await SharedPreferncehelper().getuseremail();
    id = await SharedPreferncehelper().getuserId();

    setState(() {});
  }

  getuserWallet() async {
    await getthesharedpref();
    walletStream =await Databasemethod().getusertransactions(id!);
    QuerySnapshot querySnapshot = await Databasemethod().getuserwalletbyemail(
      email!,
    );

    wallet = "${querySnapshot.docs[0]["Wallet"]}";
    print(wallet);
    setState(() {});
  }

  @override
  void initState() {
    getuserWallet();
    super.initState();
  }

  
  Stream? walletStream;

  Widget allTransactions() {
    return StreamBuilder(
      stream: walletStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, Index) {
                  DocumentSnapshot ds = snapshot.data.docs[Index];
                  return Container(
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.only(left: 20.0,right: 20.0,bottom: 20.0),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: Color(0xffececf8),borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Row(
                                      children: [
                                        Text(ds["Date"],style: Appwidgets.headlinetextfeildstyle(),),
                                        SizedBox(width: 20.0,),
                                        Column(
                                          children: [
                                            Text("Amount Add to wallet"),
                                            Text("\$"+ds["Amount"],style: TextStyle(color: Color(0xffef2b39),fontSize: 25,fontWeight: FontWeight.bold),)
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                },
              )
            : Container();
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: wallet == null
          ? Center(child: CircularProgressIndicator())
          : Container(
              margin: EdgeInsets.only(top: 40.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Wallet",
                        style: Appwidgets.headlinetextfeildstyle(),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color(0xffececf8),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 20.0),

                          /// wallet card
                          Container(
                            padding: EdgeInsets.all(20),
                            margin: EdgeInsets.only(left: 20.0, right: 20.0),
                            child: Material(
                              elevation: 3.0,
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/download (18).png",
                                      height: 80,
                                      width: 80,
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(width: 50.0),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "your Wallet",
                                          style:
                                              Appwidgets.boldtextfeildstyle(),
                                        ),
                                        Text(
                                          "\$${wallet ?? "0"}",
                                          style:
                                              Appwidgets.headlinetextfeildstyle(),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 40.0),

                          /// amount buttons
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    makePayment("100");
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.black45,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "\$100",
                                        style: Appwidgets.pricetextfeildstyle(),
                                      ),
                                    ),
                                  ),
                                ),

                                GestureDetector(
                                  onTap: () {
                                    makePayment("50");
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.black45,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "\$50",
                                        style: Appwidgets.pricetextfeildstyle(),
                                      ),
                                    ),
                                  ),
                                ),

                                GestureDetector(
                                  onTap: () {
                                    makePayment("200");
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.black45,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "\$200",
                                        style: Appwidgets.pricetextfeildstyle(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 30.0),

                          /// add money button
                          GestureDetector(
                            onTap: () {
                              openbox();
                            },
                            child: Container(
                              height: 50,
                              margin: EdgeInsets.only(left: 20.0, right: 20.0),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Color(0xffef2b39),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "Add Money",
                                  style: Appwidgets.boldwhitetextfeildstyle(),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Expanded(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: 10),
                                  Text(
                                    "Your Transactions",
                                    style: Appwidgets.boldtextfeildstyle(),
                                  ),
                                  SizedBox(height: 20.0,),
                                  Container(
                                    height: MediaQuery.of(context).size.height/2.5,
                                    child: allTransactions()),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> makePayment(String amount) async {
    try {
      paymentIntent = await createPaymentIntent(amount, 'USD');

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          style: ThemeMode.dark,
          merchantDisplayName: 'Adnan',
        ),
      );

      displayPaymentSheet(amount);
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet(String amount) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        int updatewallet = int.parse(wallet!) + int.parse(amount);
        await Databasemethod().updateuserwallet(updatewallet.toString(), id!);
        await getuserWallet();
        setState(() {});
        DateTime now = DateTime.now();
        String formateDate = DateFormat("dd MMM").format(now);

        Map<String, dynamic> usertransactions = {
          "Amount": amount,
          "Date": formateDate,
        };
        await Databasemethod().addusertrasaction(usertransactions, id!);
      });

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green),
                  SizedBox(width: 10),
                  Text("Payment Successful"),
                ],
              ),
            ],
          ),
        ),
      );

      paymentIntent = null;
    } on StripeException catch (e) {
      print("Error: $e");

      showDialog(
        context: context,
        builder: (_) => AlertDialog(content: Text("Cancelled")),
      );
    } catch (e) {
      print('$e');
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        "amount": calculateAmount(amount),
        "currency": currency,
        "payment_method_types[]": "card",
      };

      var response = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        headers: {
          "Authorization": "Bearer $secrtkey",
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: body,
      );

      return jsonDecode(response.body);
    } catch (err) {
      print("Err charging user :${err.toString()}");
    }
  }

  String calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount)) * 100;

    return calculatedAmount.toString();
  }

  Future openbox() => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.cancel),
                  ),
                  SizedBox(width: 30.0),
                  Text(
                    "Add amount",
                    style: TextStyle(
                      color: Color(0xff008080),
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Text("Enter amount"),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black38, width: 20.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextField(
                  controller: amountcontroller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "amount",
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              GestureDetector(
                onTap: () async {
                  makePayment(amountcontroller.text);
                },
                child: Center(
                  child: Container(
                    width: 100,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Color(0xff008080),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Add",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
