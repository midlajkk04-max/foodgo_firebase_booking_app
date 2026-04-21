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

  
  void init(String price) {
    toteprice = int.tryParse(price) ?? 0;
    quantity = 1;
    getuserWallet();
    notifyListeners();
  }

  
  Future<void> getthesharedpref() async {
    name = await SharedPreferncehelper().getusername();
    id = await SharedPreferncehelper().getuserId();
    email = await SharedPreferncehelper().getuseremail();
    address = await SharedPreferncehelper().getuserAddress();
  }

 
  Future<void> getuserWallet() async {
    await getthesharedpref();

    if (email == null || email == "") return;

    QuerySnapshot qs =
        await Databasemethod().getuserwalletbyemail(email!);

    if (qs.docs.isEmpty) {
      wallet = "0";
      notifyListeners();
      return;
    }

    wallet = "${qs.docs[0]["wallet"]}";
    notifyListeners();
  }

  
  void addQuantity(String price) {
    quantity++;
    toteprice += int.tryParse(price) ?? 0;
    notifyListeners();
  }

  void removeQuantity(String price) {
    if (quantity > 1) {
      quantity--;
      toteprice -= int.tryParse(price) ?? 0;
      notifyListeners();
    }
  }

  
  Future<void> placeOrder(
      BuildContext context, String foodName, String image) async {

    if (email == null || id == null || wallet == null) return;

    int walletAmount = int.tryParse(wallet!) ?? 0;

    if (address == null || address == "") {
      openbox(context);
      return;
    }

    if (walletAmount >= toteprice) {
      int updatewallet = walletAmount - toteprice;

      await Databasemethod()
          .updateuserwallet(updatewallet.toString(), id!);

      String orderId = randomAlphaNumeric(10);

      Map<String, dynamic> userOrderMap = {
        "Name": name,
        "id": id,
        "Quantity": quantity.toString(),
        "Total": toteprice.toString(), 
        "Email": email,
        "FoodName": foodName,
        "Foodimage": image,
        "OrderId": orderId, // ✅ fixed
        "Status": "pending",
        "Address": address ?? addresscontroller.text,
      };

      await Databasemethod()
          .adduserOrderdetails(userOrderMap, id!, orderId);

      await Databasemethod()
          .addadminOrderdetails(userOrderMap, orderId);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "Order placed successfully!",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Add some money to your wallet",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
  }

  /// ADDRESS BOX (same)
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