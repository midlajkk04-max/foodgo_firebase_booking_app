import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminLoginController with ChangeNotifier {
  bool isLoading = false;

  Future<bool> loginAdmin(String username, String password) async {
    isLoading = true;
    notifyListeners();

    try {
      var snapshot =
          await FirebaseFirestore.instance.collection("Admin").get();

      for (var doc in snapshot.docs) {
        if (doc.data()["Username"] == username.trim() &&
            doc.data()["password"] == password) {
          isLoading = false;
          notifyListeners();
          return true;
        }
      }

      isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return false;
    }
  }
}