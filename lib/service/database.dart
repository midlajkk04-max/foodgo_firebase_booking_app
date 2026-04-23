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
    final doc = FirebaseFirestore.instance.collection("users").doc(id);

    final snapshot = await doc.get();

    if (snapshot.exists) {
      await doc.update({"wallet": amount});
    } else {
      await doc.set({"wallet": amount});
    }
  }

  Future<Stream<QuerySnapshot>> getadminorders() async {
    return await FirebaseFirestore.instance
        .collection("orders")
        .where("Status", isEqualTo: "pending")
        .snapshots();
  }

  Future updateAdminOrder(String id) async {
    return await FirebaseFirestore.instance.collection("orders").doc(id).update(
      {"Status": "Delivered"},
    );
  }

  Future updateuserOrder(String userid, String docid) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(userid)
        .collection("orders")
        .doc(docid)
        .update({"Status": "Delivered"});
  }

  Future<Stream<QuerySnapshot>> getAllusers() async {
    return await FirebaseFirestore.instance.collection("users").snapshots();
  }

  Future deleteuser(String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .delete();
  }

  Future addusertrasaction(Map<String, dynamic> userordermap, String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Transactions")
        .add(userordermap);
  }

  Future<Stream<QuerySnapshot>> getusertransactions(String id) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Transactions")
        .snapshots();
  }

  Future<QuerySnapshot> search(updatedname) async {
    return await FirebaseFirestore.instance
        .collection("Food")
        .where(
          "SearchKey",
          isEqualTo: updatedname.substring(0, 1).toUpperCase(),
        )
        .get();
  }

  Future addFood(Map<String, dynamic> foodMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Food")
        .doc(id)
        .set(foodMap);
  }

  Future<Stream<QuerySnapshot>> getFoodByCategory(String category) async {
    return FirebaseFirestore.instance
        .collection("Food")
        .where("category", isEqualTo: category)
        .snapshots();
  }
}
