import 'package:firebase_project_hotel_bookking/admin/admincustom_widgets/admin_custom_textfeild.dart';
import 'package:firebase_project_hotel_bookking/admin/controller/admin_login_controller.dart';
import 'package:firebase_project_hotel_bookking/admin/screens/Home_admin.dart';
import 'package:firebase_project_hotel_bookking/core/constants/widget_support.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminLoginscreen extends StatefulWidget {
  const AdminLoginscreen({super.key});

  @override
  State<AdminLoginscreen> createState() => _AdminLoginscreenState();
}

class _AdminLoginscreenState extends State<AdminLoginscreen> {
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwerdcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AdminLoginController>(context);

    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2.5,
              padding: EdgeInsets.only(top: 30.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color(0xffffefbf),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/signup.png",
                    height: 180,
                    fit: BoxFit.fill,
                    width: 240,
                  ),
                  Image.asset(
                    "assets/images/home.png",
                    width: 110,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 3.2,
                left: 20.0,
                right: 20.0,
              ),
              child: Material(
                elevation: 3.0,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: MediaQuery.of(context).size.height / 2.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.0),
                      Center(
                        child: Text(
                          "Admin",
                          style: Appwidgets.headlinetextfeildstyle(),
                        ),
                      ),
                      SizedBox(height: 30.0),

                      Text("Username",
                          style: Appwidgets.signuptextfeildstyle()),
                      SizedBox(height: 5.0),

                      admincustomTextField(
                        controller: usernamecontroller,
                        hint: "Enter Username",
                        icon: Icons.person_outline,
                      ),

                      SizedBox(height: 20.0),

                      Text("Password",
                          style: Appwidgets.signuptextfeildstyle()),
                      SizedBox(height: 5.0),

                      admincustomTextField(
                        controller: passwerdcontroller,
                        hint: "Enter Password",
                        icon: Icons.password_outlined,
                        obscure: true,
                      ),

                      SizedBox(height: 30.0),

                      provider.isLoading
                          ? Center(child: CircularProgressIndicator())
                          : loginButton(() async {
                              bool success = await provider.loginAdmin(
                                usernamecontroller.text,
                                passwerdcontroller.text,
                              );

                              if (success) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          HomeAdminscreen()),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(
                                      "Invalid username or password",
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ),
                                );
                              }
                            }),

                      SizedBox(height: 30.0),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}