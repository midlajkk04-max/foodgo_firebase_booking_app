import 'package:firebase_project_hotel_bookking/core/constants/widget_support.dart';
import 'package:flutter/material.dart';

Widget walletCard(String wallet) {
  return Container(
    padding: const EdgeInsets.all(20),
    margin: const EdgeInsets.symmetric(horizontal: 20),
    child: Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Image.asset(
              "assets/images/download (18).png",
              height: 80,
              width: 80,
            ),
            const SizedBox(width: 50),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("your Wallet",
                    style: Appwidgets.boldtextfeildstyle()),
                Text("\$$wallet",
                    style: Appwidgets.headlinetextfeildstyle()),
              ],
            )
          ],
        ),
      ),
    ),
  );
}

Widget amountButton(String amount, Function() onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 50,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black45, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text("\$$amount",
            style: Appwidgets.pricetextfeildstyle()),
      ),
    ),
  );
}