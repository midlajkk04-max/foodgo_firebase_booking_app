import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project_hotel_bookking/service/database.dart';
import 'package:firebase_project_hotel_bookking/service/shared_preferncehelper.dart';
import 'package:random_string/random_string.dart';

class DetailsController extends ChangeNotifier {
  TextEditingController addresscontroller = TextEditingController();

  String? name, id, email, address, wallet;

  int quantity = 1;
  int toteprice = 0;

  bool isInitialized = false;

  /// INIT
  void init(String price) {
    if (!isInitialized) {
      toteprice = int.tryParse(price) ?? 0;
      isInitialized = true;
      getuserWallet();
    }
  }

  /// GET USER DATA
  Future<void> getthesharedpref() async {
    name = await SharedPreferncehelper().getusername();
    id = await SharedPreferncehelper().getuserId();
    email = await SharedPreferncehelper().getuseremail();
    address = await SharedPreferncehelper().getuserAddress();
  }

  /// GET WALLET SAFE
  Future<void> getuserWallet() async {
    await getthesharedpref();

    /// ✅ SAFE CHECK
    if (email == null || email == "") {
      return;
    }

    QuerySnapshot qs =
        await Databasemethod().getuserwalletbyemail(email!);

    /// ✅ SAFE CHECK
    if (qs.docs.isEmpty) {
      wallet = "0";
      return;
    }

    wallet = "${qs.docs[0]["wallet"]}";
    notifyListeners();
  }

  /// QUANTITY
  void addQuantity(String price) {
    quantity++;
    toteprice += int.parse(price);
    notifyListeners();
  }

  void removeQuantity(String price) {
    if (quantity > 1) {
      quantity--;
      toteprice -= int.parse(price);
      notifyListeners();
    }
  }

  /// ORDER (LOGIC SAME)
  Future<void> placeOrder(
      BuildContext context, String foodName, String image) async {

    /// ✅ SAFE ONLY (NO LOGIC CHANGE)
    if (email == null || id == null || wallet == null) {
      return;
    }

    if (address == null) {
      openbox(context);
    } else if (int.parse(wallet!) > toteprice) {

      int updatewallet = int.parse(wallet!) - toteprice;

      await Databasemethod()
          .updateuserwallet(updatewallet.toString(), id!);

      String orderId = randomAlphaNumeric(10);

      Map<String, dynamic> userOrderMap = {
        "Name": name,
        "id": id,
        "Quantity": quantity.toString(),
        "Totel": toteprice.toString(),
        "Email": email,
        "FoodName": foodName,
        "Foodimage": image,
        "OredrId": orderId,
        "Status": "pending",
        "Address": address ?? addresscontroller.text,
      };

      await Databasemethod()
          .adduserOrderdetails(userOrderMap, id!, orderId);

      await Databasemethod()
          .addadminOrderdetails(userOrderMap, orderId);

      /// ✅ ORIGINAL SNACKBAR SAME
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
      /// ✅ ORIGINAL SNACKBAR SAME
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
  }

  /// ADDRESS BOX (UNCHANGED)
  Future openbox(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: TextField(
            controller: addresscontroller,
            decoration: InputDecoration(hintText: "Address"),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                address = addresscontroller.text;
                await SharedPreferncehelper()
                    .saveuserAddress(addresscontroller.text);
                Navigator.pop(context);
                notifyListeners();
              },
              child: Text("Add"),
            )
          ],
        ),
      );
}