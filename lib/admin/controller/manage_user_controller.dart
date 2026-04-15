import 'package:flutter/material.dart';
import 'package:firebase_project_hotel_bookking/service/database.dart';

class ManageUserController extends ChangeNotifier {
  Stream? userStream;

  Future<void> fetchUsers() async {
    userStream = await Databasemethod().getAllusers();
    notifyListeners();
  }

  Future<void> deleteUser(String id) async {
    await Databasemethod().deleteuser(id);
  }
}