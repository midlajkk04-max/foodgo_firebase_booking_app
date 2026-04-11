import 'package:flutter/material.dart';
import 'package:firebase_project_hotel_bookking/core/constants/widget_support.dart';
import 'package:firebase_project_hotel_bookking/screens/view/details_page.dart';

class HomeFoodtile extends StatelessWidget {

  final String name;
  final String image;
  final String price;

  const HomeFoodtile({
    super.key,
    required this.name,
    required this.image,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {

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
            child: Image.asset(image,
                height: 150,
                width: 150),
          ),

          Text(name,
              style: Appwidgets.boldtextfeildstyle()),

          Text("\$"+price,
              style: Appwidgets.pricetextfeildstyle()),

          Spacer(),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context)=>
                          DetailsPage(
                              image: image,
                              name: name,
                              price: price),
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
                  child: Icon(Icons.arrow_forward,
                      color: Colors.white),
                ),
              )

            ],
          )

        ],
      ),
    );
  }
}