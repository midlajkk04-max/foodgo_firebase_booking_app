import 'package:flutter/material.dart';
import 'package:firebase_project_hotel_bookking/model/burger_model.dart';
import 'package:firebase_project_hotel_bookking/model/category_model.dart';
import 'package:firebase_project_hotel_bookking/model/pizza_model.dart';
import 'package:firebase_project_hotel_bookking/service/burger_data.dart';
import 'package:firebase_project_hotel_bookking/service/category.dart';
import 'package:firebase_project_hotel_bookking/service/pizza_data.dart';

class HomeController extends ChangeNotifier {

  List<CategoryModel> categoryes = [];
  List<PizzaModel> pizz = [];
  List<BurgerModel> burger = [];

  String track = "0";

  HomeProvider(){
    loadData();
  }

  void loadData(){
    categoryes = getcategores();
    pizz = getpizza();
    burger = getburger();
    notifyListeners();
  }

  void changeCategory(String index){
    track = index;
    notifyListeners();
  }
}