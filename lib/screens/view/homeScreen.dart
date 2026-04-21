import 'package:firebase_project_hotel_bookking/controller/Home_controler.dart';
import 'package:firebase_project_hotel_bookking/screens/custom_widgets.dart/Home_category_tile.dart';
import 'package:firebase_project_hotel_bookking/screens/custom_widgets.dart/home_foodTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_project_hotel_bookking/core/constants/widget_support.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeControler>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (provider.categories.isEmpty) {
        provider.initData();
      }
    });

    return Scaffold(
      body: SafeArea(
        top: false,
        child: Container(
          margin: const EdgeInsets.only(left: 11.0, top: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// 🔴 IMAGE (same)
              Image.asset(
                "assets/images/home.png",
                height: 50,
                width: 110,
                fit: BoxFit.contain,
              ),

              /// 🔴 TEXT (same)
              Text(
                "Order your favourite food!",
                style: Appwidgets.simpletextfeildstyle(),
              ),

              SizedBox(height: 20),

              /// 🔴 SEARCH FIELD (same UI)
              Container(
                height: 50,
                margin: EdgeInsets.only(right: 20.0),
                decoration: BoxDecoration(
                  color: Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: provider.searchcontroller,
                  onChanged: (value) {
                    provider.initiateSearch(value);
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search food item....",
                    contentPadding: EdgeInsets.only(left: 10),
                  ),
                ),
              ),

              SizedBox(height: 20),

              /// 🔴 CATEGORY LIST (same)
              Container(
                height: 70,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: provider.categories.length,
                  itemBuilder: (context, index) {
                    return HomeCategoryTile(
                      name: provider.categories[index].name!,
                      image: provider.categories[index].images!,
                      index: index.toString(),
                    );
                  },
                ),
              ),

              SizedBox(height: 10.0),

              /// 🔴 GRID VIEW (same)
              provider.track == "0"
                  ? Expanded(
                      child: GridView.builder(
                        padding: EdgeInsets.zero,
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.69,
                          mainAxisSpacing: 20.0,
                          crossAxisSpacing: 20.0,
                        ),
                        itemCount: provider.pizz.length,
                        itemBuilder: (context, index) {
                          return HomeFoodtile(
                            name: provider.pizz[index].name!,
                            image: provider.pizz[index].image!,
                            price: provider.pizz[index].prize!,
                          );
                        },
                      ),
                    )
                  : provider.track == "1"
                      ? Expanded(
                          child: GridView.builder(
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.69,
                              mainAxisSpacing: 20.0,
                              crossAxisSpacing: 20.0,
                            ),
                            itemCount: provider.burger.length,
                            itemBuilder: (context, index) {
                              return HomeFoodtile(
                                name: provider.burger[index].name!,
                                image: provider.burger[index].image!,
                                price: provider.burger[index].prize!,
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
}

