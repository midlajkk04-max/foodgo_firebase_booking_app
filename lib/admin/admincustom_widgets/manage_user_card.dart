import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project_hotel_bookking/core/constants/widget_support.dart';

class ManageUserCard extends StatelessWidget {
  final DocumentSnapshot ds;
  final VoidCallback onDelete;

  const ManageUserCard({super.key, required this.ds, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      child: Material(
        elevation: 3.0,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image.asset(
                  "assets/images/download (19).png",
                  height: 90,
                  width: 90,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.person, color: Color(0xffef2b39)),
                      SizedBox(width: 10.0),
                      Text(ds["Name"],
                          style: Appwidgets.boldtextfeildstyle()),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.mail, color: Color(0xffef2b39)),
                      SizedBox(width: 10.0),
                      Text(ds["Email"],
                          style: Appwidgets.simpletextfeildstyle()),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  GestureDetector(
                    onTap: onDelete,
                    child: Container(
                      height: 30,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text("Remove",
                            style: Appwidgets.whitetextfeildstyle()),
                      ),
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