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
      margin: EdgeInsets.only(right: 20),
      padding: EdgeInsets.only(left: 10, top: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black38),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: image.isEmpty
                  ? Container(
                      height: 110,
                      width: 110,
                      color: Colors.grey.shade200,
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        size: 35,
                        color: Colors.grey,
                      ),
                    )
                  : Image.asset(
                      image,
                      height: 110,
                      width: 110,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 110,
                          width: 110,
                          color: Colors.grey.shade200,
                          child: Icon(
                            Icons.image_not_supported_outlined,
                            size: 35,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Appwidgets.boldtextfeildstyle(),
          ),
          SizedBox(height: 5),
          Text(
            "\$$price",
            style: Appwidgets.pricetextfeildstyle(),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailsPage(
                        image: image,
                        name: name,
                        price: price,
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 45,
                  width: 70,
                  decoration: BoxDecoration(
                    color: Color(0xffef2b39),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Icon(Icons.arrow_forward, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}