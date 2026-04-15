import 'package:flutter/material.dart';
import 'package:firebase_project_hotel_bookking/service/database.dart';

class AdminOrderController extends ChangeNotifier {
  Stream? orderStream;

  Future<void> fetchOrders() async {
    orderStream = await Databasemethod().getadminorders();
    notifyListeners();
  }

  Future<void> markAsDelivered(String docId, String userId) async {
    await Databasemethod().updateAdminOrder(docId);
    await Databasemethod().updateuserOrder(userId, docId);
  }
}