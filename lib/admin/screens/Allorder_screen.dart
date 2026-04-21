import 'package:firebase_project_hotel_bookking/admin/controller/admin_order_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_project_hotel_bookking/core/constants/widget_support.dart';
import 'package:firebase_project_hotel_bookking/admin/admincustom_widgets/admin_order_card.dart';

class AllOrderscreen extends StatefulWidget {
  const AllOrderscreen({super.key});

  @override
  State<AllOrderscreen> createState() => _AllOrderscreenState();
}

class _AllOrderscreenState extends State<AllOrderscreen> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<AdminOrderController>(context, listen: false).fetchOrders());
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AdminOrderController>(context);

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 40.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Color(0xffef2b39),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 6),
                  Text("All Oreders",
                      style: Appwidgets.headlinetextfeildstyle())
                ],
              ),
            ),
            SizedBox(height: 20.0),
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
                child: Column(
                  children: [
                    SizedBox(height: 20.0),
                    Container(
                      height: MediaQuery.of(context).size.height / 1.5,
                      child: provider.orderStream == null
                          ? Center(child: CircularProgressIndicator())
                          : StreamBuilder(
                              stream: provider.orderStream,
                              builder: (context, snapshot) {

                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Center(child: CircularProgressIndicator());
                                }

                                if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
                                  return Center(child: Text("No Orders Found"));
                                }

                                return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: (context, index) {
                                    var ds = snapshot.data.docs[index];

                                    return AdminOrderCard(
                                      ds: ds,
                                      onDeliver: () async {
                                        await provider.markAsDelivered(
                                            ds.id, ds["id"]);
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}