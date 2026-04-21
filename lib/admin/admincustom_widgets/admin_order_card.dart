import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project_hotel_bookking/core/constants/widget_support.dart';

class AdminOrderCard extends StatelessWidget {
  final DocumentSnapshot ds;
  final VoidCallback onDeliver;

  const AdminOrderCard({
    super.key,
    required this.ds,
    required this.onDeliver,
  });

  String safeGet(String key, {String fallback = "N/A"}) {
    try {
      if (ds.data() != null &&
          (ds.data() as Map<String, dynamic>).containsKey(key)) {
        return ds[key].toString();
      }
      return fallback;
    } catch (e) {
      return fallback;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      child: Material(
        elevation: 3.0,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 5.0),

          
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.location_on_outlined,
                      color: Color(0xffef2b39)),
                  const SizedBox(width: 10.0),
                  Text(
                    safeGet("Address"),
                    style: Appwidgets.simpletextfeildstyle(),
                  ),
                ],
              ),

              const Divider(),

              Row(
                children: [
          
                  Image.asset(
                    safeGet("Foodimage"),
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),

                  const SizedBox(width: 20.0),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              
                      Text(
                        safeGet("FoodName"),
                        style: Appwidgets.boldtextfeildstyle(),
                      ),

                      const SizedBox(height: 5.0),

                      
                      Row(
                        children: [
                          const Icon(Icons.production_quantity_limits_outlined,
                              color: Color(0xffef2b39)),
                          const SizedBox(width: 10.0),
                          Text(
                            safeGet("Quantity"),
                            style: Appwidgets.boldtextfeildstyle(),
                          ),
                          const SizedBox(width: 30.0),
                          const Icon(Icons.monetization_on,
                              color: Color(0xffef2b39)),
                          const SizedBox(width: 10.0),
                          Text(
                            "\$${safeGet("Total", fallback: "0")}",
                            style: Appwidgets.boldtextfeildstyle(),
                          ),
                        ],
                      ),

                      const SizedBox(height: 5.0),

                    
                      Row(
                        children: [
                          const Icon(Icons.person,
                              color: Color(0xffef2b39)),
                          const SizedBox(width: 10.0),
                          Text(
                            safeGet("Name"),
                            style: Appwidgets.simpletextfeildstyle(),
                          ),
                        ],
                      ),

                      const SizedBox(height: 5.0),

                      
                      Row(
                        children: [
                          const Icon(Icons.mail,
                              color: Color(0xffef2b39)),
                          
                          Text(
                            safeGet("Email"),
                            style: Appwidgets.simpletextfeildstyle(),
                          ),
                        ],
                      ),

                      const SizedBox(height: 5.0),

                      
                      Text(
                        safeGet("Status"),
                        style: const TextStyle(
                          color: Color(0xffef2b39),
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 5.0),

                    
                      GestureDetector(
                        onTap: onDeliver,
                        child: Container(
                          width: 100,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "Delivered",
                              style: Appwidgets.whitetextfeildstyle(),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10.0),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}