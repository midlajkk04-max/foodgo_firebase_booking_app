import 'package:firebase_project_hotel_bookking/core/constants/widget_support.dart';
import 'package:firebase_project_hotel_bookking/model/burger_model.dart';
import 'package:firebase_project_hotel_bookking/model/category_model.dart';
import 'package:firebase_project_hotel_bookking/model/pizza_model.dart';
import 'package:firebase_project_hotel_bookking/screens/view/details_page.dart';
import 'package:firebase_project_hotel_bookking/service/burger_data.dart';
import 'package:firebase_project_hotel_bookking/service/category.dart';
import 'package:firebase_project_hotel_bookking/service/pizza_data.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  List<CategoryModel> categoryes = [];
  List<PizzaModel> pizz = [];
  List<BurgerModel> burger = [];
  String track = "0";

  @override
  void initState() {
    categoryes = getcategores();
    pizz = getpizza();
    burger = getburger();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Container(
          margin: const EdgeInsets.only(left: 11.0, top: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/home.png",
                height: 50,
                width: 110,
                fit: BoxFit.contain,
              ),

              Text(
                "Order your favourite food!",
                style: Appwidgets.simpletextfeildstyle(),
              ),

              SizedBox(height: 20),

              Container(
                height: 50,
                margin: EdgeInsets.only(right: 20.0),
                decoration: BoxDecoration(
                  color: Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search food item....",
                    contentPadding: EdgeInsets.only(left: 10),
                  ),
                ),
              ),

              SizedBox(height: 20),

              Container(
                height: 70,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryes.length,
                  itemBuilder: (context, index) {
                    return Categorytile(
                      categoryes[index].name!,
                      categoryes[index].images!,
                      index.toString(),
                    );
                  },
                ),
              ),
              SizedBox(height: 10.0),

              track == "0"
                  ? Expanded(
                      child: GridView.builder(
                        padding: EdgeInsets.zero,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.69,
                          mainAxisSpacing: 20.0,
                          crossAxisSpacing: 20.0,
                        ),
                        itemCount: pizz.length,
                        itemBuilder: (context, index) {
                          return FoodTile(
                            pizz[index].name!,
                            pizz[index].image!,
                            pizz[index].prize!,
                          );
                        },
                      ),
                    )
                  : track == "1"
                  ? Expanded(
                      child: GridView.builder(
                        padding: EdgeInsets.zero,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.69,
                          mainAxisSpacing: 20.0,
                          crossAxisSpacing: 20.0,
                        ),
                        itemCount: burger.length,
                        itemBuilder: (context, index) {
                          return FoodTile(
                            burger[index].name!,
                            burger[index].image!,
                            burger[index].prize!,
                          );
                        },
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget Categorytile(String name, String images, String categeryindex) {
    return GestureDetector(
      onTap: () {
        track = categeryindex.toString();
        setState(() {});
      },
      child: track == categeryindex
          ? Container(
              margin: EdgeInsets.only(right: 20.0, bottom: 10.0),
              child: Material(
                elevation: 3.0,
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  padding: EdgeInsets.only(right: 20.0, left: 20.0),
                  decoration: BoxDecoration(
                    color: Color(0xffef2b39),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        images,
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 10),
                      Text(name, style: Appwidgets.simpletextfeildstyle()),
                    ],
                  ),
                ),
              ),
            )
          : Container(
              padding: EdgeInsets.only(right: 20.0, left: 20.0),
              margin: EdgeInsets.only(right: 20.0, bottom: 10.0),
              decoration: BoxDecoration(
                color: Color(0xFFececf8),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Image.asset(images, height: 40, width: 40, fit: BoxFit.cover),
                  SizedBox(width: 10),
                  Text(name, style: Appwidgets.simpletextfeildstyle()),
                ],
              ),
            ),
    );
  }

  Widget FoodTile(String name, String image, String price) {
    return Container(
      margin: EdgeInsets.only(right: 20.0),
      padding: EdgeInsets.only(left: 10.0, top: 10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black38),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.asset(
              image,
              height: 150,
              width: 150,
              fit: BoxFit.contain,
            ),
          ),
          Text(name, style: Appwidgets.boldtextfeildstyle()),
          Text("\$" + price, style: Appwidgets.pricetextfeildstyle()),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailsPage(image: image, name: name, price: price),
                    ),
                  );
                },
                child: Container(
                  height: 50,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Color(0xffef2b39),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 30.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
