import 'package:flutter/material.dart';
import 'package:firebase_project_hotel_bookking/core/constants/widget_support.dart';

class HomeCategoryTile extends StatelessWidget {

  final String name;
  final String image;
  final bool isSelected;
  final VoidCallback onTap;

  const HomeCategoryTile({
    super.key,
    required this.name,
    required this.image,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      child: isSelected
          ? Container(
              margin: EdgeInsets.only(right: 20.0, bottom: 10.0),
              child: Material(
                elevation: 3.0,
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Color(0xffef2b39),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      Image.asset(image, height: 40, width: 40),
                      SizedBox(width: 10),
                      Text(name,
                          style: Appwidgets.simpletextfeildstyle()),
                    ],
                  ),
                ),
              ),
            )
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              margin: EdgeInsets.only(right: 20.0, bottom: 10.0),
              decoration: BoxDecoration(
                color: Color(0xFFececf8),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Image.asset(image, height: 40, width: 40),
                  SizedBox(width: 10),
                  Text(name,
                      style: Appwidgets.simpletextfeildstyle()),
                ],
              ),
            ),
    );
  }
}