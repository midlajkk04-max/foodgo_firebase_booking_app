import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project_hotel_bookking/controller/order_controller.dart';
import 'package:firebase_project_hotel_bookking/core/constants/widget_support.dart';
import 'package:firebase_project_hotel_bookking/screens/custom_widgets.dart/order_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Orderscreen extends StatefulWidget {
  const Orderscreen({super.key});

  @override
  State<Orderscreen> createState() => _OrderscreenState();
}

class _OrderscreenState extends State<Orderscreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      Provider.of<OrderController>(context, listen: false)
          .loadOrders();
    });
  }

  Widget allorders(Stream? orderStream) {
    return StreamBuilder(
      stream: orderStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }

        return ListView.builder(
          padding: EdgeInsets.only(top: 20),
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            return OrderTile(
              ds: snapshot.data.docs[index],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OrderController>(context);

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 40.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Orders",
                    style: Appwidgets.headlinetextfeildstyle()),
              ],
            ),

            SizedBox(height: 10.0),

            
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xffececf8),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),

                
                child: allorders(provider.orderStream),
              ),
            ),
          ],
        ),
      ),
    );
  }
}