import 'package:firebase_project_hotel_bookking/admin/screens/Allorder_screen.dart';
import 'package:firebase_project_hotel_bookking/admin/screens/admin_add_foodScreen.dart';
import 'package:firebase_project_hotel_bookking/admin/screens/mange_user.dart';
import 'package:firebase_project_hotel_bookking/admin/admincustom_widgets/admin_home_card.dart';
import 'package:firebase_project_hotel_bookking/core/constants/widget_support.dart';
import 'package:flutter/material.dart';

class HomeAdminscreen extends StatefulWidget {
  const HomeAdminscreen({super.key});

  @override
  State<HomeAdminscreen> createState() => _HomeAdminscreenState();
}

class _HomeAdminscreenState extends State<HomeAdminscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 60.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  Text(
                    "Home Admin",
                    style: Appwidgets.headlinetextfeildstyle(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.0),
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

                    AdminHomeCard(
                      image: "assets/images/download (20).png",
                      title: "Manage \norders",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AllOrderscreen(),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 50.0),

                    AdminHomeCard(
                      image: "assets/images/download (21).png",
                      title: "Manage \nUsers",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ManageUsersScreen(),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 50.0),

                    AdminHomeCard(
                      image: "assets/images/download (20).png",
                      title: "Add \nFood",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddFoodScreen(),
                          ),
                        );
                      },
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