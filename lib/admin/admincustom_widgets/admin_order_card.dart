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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      child: Material(
        elevation: 3.0,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_on_outlined, color: Color(0xffef2b39)),
                  SizedBox(width: 10.0),
                  Text(ds["Address"],
                      style: Appwidgets.simpletextfeildstyle()),
                ],
              ),
              Divider(),
              Row(
                children: [
                  Image.asset(
                    ds['Foodimage'],
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 20.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(ds['FoodName'],
                          style: Appwidgets.boldtextfeildstyle()),
                      SizedBox(height: 5.0),
                      Row(
                        children: [
                          Icon(Icons.production_quantity_limits_outlined,
                              color: Color(0xffef2b39)),
                          SizedBox(width: 10.0),
                          Text(ds["Quantity"],
                              style: Appwidgets.boldtextfeildstyle()),
                          SizedBox(width: 30.0),
                          Icon(Icons.monetization_on,
                              color: Color(0xffef2b39)),
                          SizedBox(width: 10.0),
                          Text("\$" + ds["Total"],
                              style: Appwidgets.boldtextfeildstyle()),
                        ],
                      ),
                      SizedBox(height: 5.0),
                      Row(
                        children: [
                          Icon(Icons.person, color: Color(0xffef2b39)),
                          SizedBox(width: 10.0),
                          Text(ds["Name"],
                              style: Appwidgets.simpletextfeildstyle()),
                        ],
                      ),
                      SizedBox(height: 5.0),
                      Row(
                        children: [
                          Icon(Icons.mail, color: Color(0xffef2b39)),
                          SizedBox(width: 10.0),
                          Text(ds["Email"],
                              style: Appwidgets.simpletextfeildstyle()),
                        ],
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        ds["Status"] + "",
                        style: TextStyle(
                          color: Color(0xffef2b39),
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5.0),
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
                            child: Text("Delivered",
                                style: Appwidgets.whitetextfeildstyle()),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
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