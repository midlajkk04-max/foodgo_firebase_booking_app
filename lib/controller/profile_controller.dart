import 'package:flutter/material.dart';
import '../service/shared_preferncehelper.dart';

class ProfileController extends ChangeNotifier {
  String? name;
  String? email;

  bool isLoading = true;

  Future<void> loadProfile() async {
    isLoading = true;
    notifyListeners();

    name = await SharedPreferncehelper().getusername();
    email = await SharedPreferncehelper().getuseremail();

    isLoading = false;
    notifyListeners();
  }
}