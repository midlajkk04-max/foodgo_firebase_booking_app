import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project_hotel_bookking/core/constants/const_keys.dart';
import 'package:firebase_project_hotel_bookking/core/constants/widget_support.dart';
import 'package:firebase_project_hotel_bookking/service/database.dart';
import 'package:firebase_project_hotel_bookking/service/shared_preferncehelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:random_string/random_string.dart';

class DetailsPage extends StatefulWidget {
  String image;
  String name;
  String price;

  DetailsPage({required this.image, required this.name, required this.price});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  TextEditingController addresscontroller = TextEditingController();
  Map<String, dynamic>? paymentIntent;
  String? name;
  String? id;
  String? email;
  String? address;
  String? wallet;

  int quantity = 1, toteprice = 0;

  getthesharedpref() async {
    name = await SharedPreferncehelper().getusername();
    id = await SharedPreferncehelper().getuserId();
    email = await SharedPreferncehelper().getuseremail();
    address = await SharedPreferncehelper().getuserAddress();
    print(name);
    print(id);
    print(email);
    setState(() {});
  }

  getuserWallet() async {
    await getthesharedpref();
    QuerySnapshot querySnapshot = await Databasemethod().getuserwalletbyemail(
      email!,
    );

    wallet = "${querySnapshot.docs[0]["wallet"]}";

    setState(() {});
  }

  @override
  void initState() {
    toteprice = int.parse(widget.price);
    getuserWallet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50.0, left: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Color(0xffef2b39),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(Icons.arrow_back, size: 30.0, color: Colors.white),
              ),
            ),

            SizedBox(height: 10.0),

            Center(
              child: Image.asset(
                widget.image,
                height: MediaQuery.of(context).size.height / 3,
                fit: BoxFit.contain,
              ),
            ),

            SizedBox(height: 20.0),

            Text(widget.name, style: Appwidgets.headlinetextfeildstyle()),

            Text("\$" + widget.price, style: Appwidgets.pricetextfeildstyle()),

            SizedBox(height: 30.0),

            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Text(
                "We've established that most cheeses will melt when baked atop pizza. But which will not only melt but stretch into those gooey strands?",
                style: Appwidgets.simpletextfeildstyle(),
              ),
            ),

            SizedBox(height: 30),

            Text("quantity", style: Appwidgets.simpletextfeildstyle()),

            SizedBox(height: 10),

            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    quantity++;
                    toteprice += int.parse(widget.price);
                    setState(() {});
                  },
                  child: Material(
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Color(0xffef2b39),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.add, color: Colors.white, size: 30.0),
                    ),
                  ),
                ),

                SizedBox(width: 20),

                Text(
                  quantity.toString(),
                  style: Appwidgets.headlinetextfeildstyle(),
                ),

                SizedBox(width: 20),

                GestureDetector(
                  onTap: () {
                    if (quantity > 1) {
                      quantity--;
                      toteprice -= int.parse(widget.price);
                      setState(() {});
                    }
                  },
                  child: Material(
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Color(0xffef2b39),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.remove,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 40),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 60,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Color(0xffef2b39),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        "\$${toteprice.toString()}",
                        style: Appwidgets.boldwhitetextfeildstyle(),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 30),

                GestureDetector(
                  onTap: () async {
                    if (address == null) {
                      openbox();
                    } else if (int.parse(wallet!) > toteprice) {
                      int updatewallet = int.parse(wallet!) - toteprice;
                      await Databasemethod().updateuserwallet(
                        updatewallet.toString(),
                        id!,
                      );
                      String orderId = randomAlphaNumeric(10);

                      Map<String, dynamic> userOrderMap = {
                        "Name": name,
                        "id": id,
                        "Quantity": quantity.toString(),
                        "Totel": toteprice.toString(),
                        "Email": email,
                        "FoodName": widget.name,
                        "Foodimage": widget.image,
                        "OredrId": orderId,
                        "Status": "pending",
                        "Address": address ?? addresscontroller.text,
                      };

                      await Databasemethod().adduserOrderdetails(
                        userOrderMap,
                        id!,
                        orderId,
                      );

                      await Databasemethod().addadminOrderdetails(
                        userOrderMap,
                        orderId,
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.green,
                          content: Text(
                            "order place successFully!",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                            "Add some money to your wallet",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  child: Material(
                    elevation: 3,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 70,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "ORDER NOW",
                          style: Appwidgets.whitetextfeildstyle(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
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
      await Stripe.instance.presentPaymentSheet();

      String orderId = randomAlphaNumeric(10);

      Map<String, dynamic> userOrderMap = {
        "Name": name,
        "id": id,
        "Quantity": quantity.toString(),
        "Totel": toteprice.toString(),
        "Email": email,
        "FoodName": widget.name,
        "Foodimage": widget.image,
        "OredrId": orderId,
        "Status": "pending",
        "Address": address ?? addresscontroller.text,
      };

      await Databasemethod().adduserOrderdetails(userOrderMap, id!, orderId);

      await Databasemethod().addadminOrderdetails(userOrderMap, orderId);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "order place successFully!",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
      );

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
                    "Add the Address",
                    style: TextStyle(
                      color: Color(0xff008080),
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Text("Add Address"),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black38, width: 20.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextField(
                  controller: addresscontroller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Address",
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              GestureDetector(
                onTap: () async {
                  address = addresscontroller.text;
                  await SharedPreferncehelper().saveuserAddress(
                    addresscontroller.text,
                  );
                  Navigator.pop(context);
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
