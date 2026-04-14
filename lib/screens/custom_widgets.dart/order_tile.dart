import 'package:firebase_project_hotel_bookking/core/constants/widget_support.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  final dynamic ds;

  const OrderTile({super.key, required this.ds});

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
                  Icon(Icons.location_on_outlined,
                      color: Color(0xffef2b39)),
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
                          Text("\$" + ds["Totel"],
                              style: Appwidgets.boldtextfeildstyle()),
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