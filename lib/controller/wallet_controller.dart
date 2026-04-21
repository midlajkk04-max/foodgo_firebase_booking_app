import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../service/database.dart';
import '../service/shared_preferncehelper.dart';
import '../core/constants/const_keys.dart';

class WalletController extends ChangeNotifier {
  TextEditingController amountcontroller = TextEditingController();

  Map<String, dynamic>? paymentIntent;

  String? email;
  String? wallet;
  String? id;

  Stream? walletStream;

  
  Future<void> init() async {
    await getShared();
    await loadWallet();
  }

  
  Future<void> getShared() async {
    email = await SharedPreferncehelper().getuseremail();
    id = await SharedPreferncehelper().getuserId();
    notifyListeners();
  }

  
  Future<void> loadWallet() async {
    await getShared();

    walletStream = await Databasemethod().getusertransactions(id!);

    QuerySnapshot querySnapshot =
        await Databasemethod().getuserwalletbyemail(email!);

wallet = "${querySnapshot.docs[0]["wallet"]}";    notifyListeners();
  }

  
  Future<void> makePayment(String amount, BuildContext context) async {
    try {
      paymentIntent = await createPaymentIntent(amount, 'USD');

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          style: ThemeMode.dark,
          merchantDisplayName: 'Adnan',
        ),
      );

      await displayPaymentSheet(amount, context);
    } catch (e) {
      debugPrint("Payment error: $e");
    }
  }

  Future<void> displayPaymentSheet(String amount, BuildContext context) async {
    try {
      await Stripe.instance.presentPaymentSheet();

      int updatewallet = int.parse(wallet!) + int.parse(amount);

      await Databasemethod().updateuserwallet(updatewallet.toString(), id!);

      await loadWallet();

      DateTime now = DateTime.now();
      String formateDate = DateFormat("dd MMM").format(now);

      Map<String, dynamic> usertransactions = {
        "Amount": amount,
        "Date": formateDate,
      };

      await Databasemethod().addusertrasaction(usertransactions, id!);

      notifyListeners();

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Row(
            children: const [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 10),
              Text("Payment Successful"),
            ],
          ),
        ),
      );

      paymentIntent = null;
    } catch (e) {
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(content: Text("Cancelled")),
      );
    }
  }

  Future<Map<String, dynamic>?> createPaymentIntent(
      String amount, String currency) async {
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
    } catch (e) {
      debugPrint("Stripe error: $e");
      return null;
    }
  }

  String calculateAmount(String amount) {
    return (int.parse(amount) * 100).toString();
  }
}