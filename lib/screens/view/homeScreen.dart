import 'package:cloud_firestore/cloud_firestore.dart';
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
              provider.track == "0"
                  ? Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("Food")
                            .where("category", isEqualTo: "pizza")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }

                          if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return Center(child: Text("No Food Found"));
                          }

                          final docs = snapshot.data!.docs;

                          return GridView.builder(
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.69,
                              mainAxisSpacing: 20.0,
                              crossAxisSpacing: 20.0,
                            ),
                            itemCount: docs.length,
                            itemBuilder: (context, index) {
                              final data =
                                  docs[index].data() as Map<String, dynamic>;
                              final docId = docs[index].id;
                              final firestoreName =
                                  (data["name"] ?? "").toString();
                              final firestorePrice =
                                  (data["price"] ?? "").toString();

                              return HomeFoodtile(
                                name: provider.getDisplayName(
                                  docId,
                                  firestoreName,
                                ),
                                image: (data["Foodimage"] ?? "").toString(),
                                price: provider.getDisplayPrice(
                                  docId,
                                  firestorePrice,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    )
                  : provider.track == "1"
                      ? Expanded(
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection("Food")
                                .where("category", isEqualTo: "burger")
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }

                              if (!snapshot.hasData ||
                                  snapshot.data!.docs.isEmpty) {
                                return Center(child: Text("No Food Found"));
                              }

                              final docs = snapshot.data!.docs;

                              return GridView.builder(
                                padding: EdgeInsets.zero,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.69,
                                  mainAxisSpacing: 20.0,
                                  crossAxisSpacing: 20.0,
                                ),
                                itemCount: docs.length,
                                itemBuilder: (context, index) {
                                  final data =
                                      docs[index].data() as Map<String, dynamic>;
                                  final docId = docs[index].id;
                                  final firestoreName =
                                      (data["name"] ?? "").toString();
                                  final firestorePrice =
                                      (data["price"] ?? "").toString();

                                  return HomeFoodtile(
                                    name: provider.getDisplayName(
                                      docId,
                                      firestoreName,
                                    ),
                                    image: (data["Foodimage"] ?? "").toString(),
                                    price: provider.getDisplayPrice(
                                      docId,
                                      firestorePrice,
                                    ),
                                  );
                                },
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