import 'package:cloud_firestore/cloud_firestore.dart';

class Databasemethod {
  Future adduserdetails(Map<String, dynamic> userinfomap, String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .set(userinfomap);
  }

  Future adduserOrderdetails(
    Map<String, dynamic> userordermap,
    String id,
    String orderId,
  ) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("orders")
        .doc(orderId)
        .set(userordermap);
  }

  Future addadminOrderdetails(
    Map<String, dynamic> userordermap,

    String orderId,
  ) async {
    return await FirebaseFirestore.instance
        .collection("orders")
        .doc(orderId)
        .set(userordermap);
  }

  Future<Stream<QuerySnapshot>> getuserorders(String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("orders")
        .snapshots();
  }

  Future<QuerySnapshot> getuserwalletbyemail(String email) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("Email", isEqualTo: email)
        .get();
  }

  Future updateuserwallet(String amount, String id) async {
    return await FirebaseFirestore.instance.collection("users").doc(id).update({
      "wallet": amount,
    });
  }

  Future<Stream<QuerySnapshot>> getadminorders() async {
    return await FirebaseFirestore.instance
        .collection("orders").where("Status",isEqualTo: "pending").snapshots();
        
  }
}
