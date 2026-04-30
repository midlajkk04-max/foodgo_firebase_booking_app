import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project_hotel_bookking/service/remote%20configure.dart';
import 'package:flutter/material.dart';
import 'package:firebase_project_hotel_bookking/model/burger_model.dart';
import 'package:firebase_project_hotel_bookking/model/category_model.dart';
import 'package:firebase_project_hotel_bookking/model/pizza_model.dart';
import 'package:firebase_project_hotel_bookking/service/burger_data.dart';
import 'package:firebase_project_hotel_bookking/service/category.dart';
import 'package:firebase_project_hotel_bookking/service/database.dart';
import 'package:firebase_project_hotel_bookking/service/pizza_data.dart';

class HomeControler extends ChangeNotifier {
  List<CategoryModel> categories = [];
  List<PizzaModel> pizz = [];
  List<BurgerModel> burger = [];

  String track = "0";
  bool search = false;

  TextEditingController searchcontroller = TextEditingController();

  var queryResultSet = [];
  var tempSearchStore = [];

  final RemoteConfigService remoteConfigService;

  HomeControler({required this.remoteConfigService});

  void initData() {
    categories = getcategores();
    pizz = getpizza(remoteConfigService);
    burger = getburger();
    notifyListeners();
  }

  void changeCategory(String index) {
    track = index;
    notifyListeners();
  }

  String getDisplayName(String docId, String firestoreName) {
    return firestoreName;
  }

  String getDisplayPrice(String docId, String firestorePrice) {
    final remoteConfig = remoteConfigService.remoteConfig;

    bool enable = remoteConfig.getBool("enable_food_override");
    String overrideId = remoteConfig.getString("override_food_id");
    String overridePrice = remoteConfig.getString("override_food_price");

    if (enable && docId == overrideId && overridePrice.isNotEmpty) {
      return overridePrice;
    }

    return firestorePrice;
  }

  void initiateSearch(String value) {
    if (value.isEmpty) {
      queryResultSet = [];
      tempSearchStore = [];
      notifyListeners();
      return;
    }

    search = true;

    String capitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);

    if (queryResultSet.isEmpty && value.length == 1) {
      Databasemethod().search(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.docs.length; ++i) {
          queryResultSet.add(docs.docs[i].data());
        }
        notifyListeners();
      });
    } else {
      tempSearchStore = [];
      for (var element in queryResultSet) {
        if (element['Name'].startsWith(capitalizedValue)) {
          tempSearchStore.add(element);
        }
      }
      notifyListeners();
    }
  }
}