import 'package:firebase_project_hotel_bookking/controller/signup_controller.dart';
import 'package:firebase_project_hotel_bookking/core/constants/widget_support.dart';
import 'package:firebase_project_hotel_bookking/screens/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController mailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<SignupController>(context);

    return Scaffold(
      body: Container(
        child: Stack(
          children: [

            // ================= TOP SECTION (NO CHANGE) =================
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

            // ================= FORM SECTION (NO CHANGE) =================
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
                  height: MediaQuery.of(context).size.height / 1.65,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(height: 20.0),

                      Center(
                        child: Text(
                          "SignUp",
                          style: Appwidgets.headlinetextfeildstyle(),
                        ),
                      ),

                      SizedBox(height: 30.0),

                      Text("Name",
                          style: Appwidgets.signuptextfeildstyle()),
                      SizedBox(height: 5.0),

                      // ===== NAME FIELD (EXACT YOUR DECORATION) =====
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xffececf8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: namecontroller,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter Name",
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                        ),
                      ),

                      SizedBox(height: 20.0),

                      Text("Email",
                          style: Appwidgets.signuptextfeildstyle()),
                      SizedBox(height: 5.0),

                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xffececf8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: mailcontroller,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter Email",
                            prefixIcon: Icon(Icons.mail),
                          ),
                        ),
                      ),

                      SizedBox(height: 20.0),

                      Text("Password",
                          style: Appwidgets.signuptextfeildstyle()),
                      SizedBox(height: 5.0),

                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xffececf8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: passwordcontroller,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter Password",
                            prefixIcon: Icon(Icons.password_outlined),
                          ),
                        ),
                      ),

                      SizedBox(height: 30.0),

                      GestureDetector(
                        onTap: () {
                          if (namecontroller.text.isNotEmpty &&
                              mailcontroller.text.isNotEmpty &&
                              passwordcontroller.text.isNotEmpty) {
                            authProvider.registerUser(
                              name: namecontroller.text,
                              email: mailcontroller.text,
                              password: passwordcontroller.text,
                              context: context,
                            );
                          }
                          
                        },
                        child: Center(
                          child: Container(
                            width: 180,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color(0xffef2b39),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: authProvider.isLoading
                                  ? CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      "Sign up",
                                      style: Appwidgets.boldwhitetextfeildstyle(),
                                    ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 30.0),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: Appwidgets.simpletextfeildstyle(),
                          ),
                          SizedBox(width: 10.0),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Loginscreen(),
                                ),
                              );
                            },
                            child: Text(
                              "Login",
                              style: Appwidgets.boldtextfeildstyle(),
                            ),
                          ),
                        ],
                      ),
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