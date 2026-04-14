import 'package:firebase_project_hotel_bookking/controller/Home_controler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_project_hotel_bookking/core/constants/widget_support.dart';

class HomeCategoryTile extends StatelessWidget {
  final String name;
  final String image;
  final String index;

  const HomeCategoryTile({
    super.key,
    required this.name,
    required this.image,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeControler>(context);

    bool isSelected = provider.track == index;

    return GestureDetector(
      onTap: () {
        provider.changeCategory(index);
      },
      child: isSelected
          ? Container(
              margin: EdgeInsets.only(right: 20, bottom: 10),
              child: Material(
                elevation: 3,
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
                      Text(name, style: Appwidgets.simpletextfeildstyle()),
                    ],
                  ),
                ),
              ),
            )
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              margin: EdgeInsets.only(right: 20, bottom: 10),
              decoration: BoxDecoration(
                color: Color(0xFFececf8),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Image.asset(image, height: 40, width: 40),
                  SizedBox(width: 10),
                  Text(name, style: Appwidgets.simpletextfeildstyle()),
                ],
              ),
            ),
    );
  }
}