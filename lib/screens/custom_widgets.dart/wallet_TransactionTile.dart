import 'package:firebase_project_hotel_bookking/core/constants/widget_support.dart';
import 'package:flutter/material.dart';

class WalletTransactiontile extends StatelessWidget {
  final dynamic ds;

  const WalletTransactiontile({super.key, required this.ds});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      decoration: BoxDecoration(
        color: Color(0xffececf8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Text(
            ds["Date"],
            style: Appwidgets.headlinetextfeildstyle(),
          ),
          SizedBox(width: 20.0),
          Column(
            children: [
              Text("Amount Add to wallet"),
              Text(
                "\$" + ds["Amount"],
                style: TextStyle(
                  color: Color(0xffef2b39),
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}