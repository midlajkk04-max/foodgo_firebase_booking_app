import 'package:flutter/material.dart';
import '../service/database.dart';
import '../service/shared_preferncehelper.dart';

class OrderController extends ChangeNotifier {
  String? userId;
  Stream? orderStream;

  Future<void> loadOrders() async {
    userId = await SharedPreferncehelper().getuserId();

    if (userId != null) {
      orderStream = await Databasemethod().getuserorders(userId!);
    }

    notifyListeners();
  }
}