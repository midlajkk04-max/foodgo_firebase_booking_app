import 'package:firebase_project_hotel_bookking/core/constants/widget_support.dart';
import 'package:firebase_project_hotel_bookking/service/database.dart';
import 'package:firebase_project_hotel_bookking/service/shared_preferncehelper.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatefulWidget {
  final dynamic ds;

  const OrderTile({super.key, required this.ds});

  @override
  State<OrderTile> createState() => _OrderTileState();
}

class _OrderTileState extends State<OrderTile> {
  String userId = "";

  @override
  void initState() {
    super.initState();
    loadUserId();
  }

  Future<void> loadUserId() async {
    userId = await SharedPreferncehelper().getuserId() ?? "";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var data = widget.ds.data() as Map<String, dynamic>;

    String total = (data["Total"] ?? data["Totel"] ?? "0").toString();
    String status = (data["Status"] ?? "").toString();
    String foodImage = (data["Foodimage"] ?? "").toString();

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
                  Text(
                    data["Address"] ?? "",
                    style: Appwidgets.simpletextfeildstyle(),
                  ),
                ],
              ),
              Divider(),
              Row(
                children: [
                  Image.asset(
                    foodImage,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 120,
                        height: 120,
                        color: Colors.grey.shade200,
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          color: Colors.grey,
                          size: 35,
                        ),
                      );
                    },
                  ),
                  SizedBox(width: 20.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['FoodName'],
                          style: Appwidgets.boldtextfeildstyle(),
                        ),
                        SizedBox(height: 5.0),
                        Row(
                          children: [
                            Icon(
                              Icons.production_quantity_limits_outlined,
                              color: Color(0xffef2b39),
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              data["Quantity"] ?? "0",
                              style: Appwidgets.boldtextfeildstyle(),
                            ),
                            SizedBox(width: 30.0),
                            Icon(
                              Icons.monetization_on,
                              color: Color(0xffef2b39),
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              "\$$total",
                              style: Appwidgets.boldtextfeildstyle(),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.0),
                        Row(
                          children: [
                            Text(
                              status,
                              style: TextStyle(
                                color: Color(0xffef2b39),
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),

                           
                            if (status == "Delivered")
                              IconButton(
                                onPressed: () async {
                                  await Databasemethod().deleteUserOrder(
                                    userId,
                                    widget.ds.id,
                                  );

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Order deleted"),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
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