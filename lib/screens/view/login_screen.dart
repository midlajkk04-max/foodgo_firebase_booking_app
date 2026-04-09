import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project_hotel_bookking/core/constants/widget_support.dart';
import 'package:firebase_project_hotel_bookking/screens/view/bottomnav_screen.dart';
import 'package:firebase_project_hotel_bookking/screens/view/signup_screen.dart';
import 'package:flutter/material.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  String email = "";
  String passwerd = "";
  String name = "";

  TextEditingController namecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController mailcontroller = TextEditingController();

  userlogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: passwerd,
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BottomNavscreen()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "no user found for that email",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
          ),
        );
      } else if (e.code == "wrong password") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "wrong password provided by user",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  height: MediaQuery.of(context).size.height / 1.65,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.0),
                      Center(
                        child: Text(
                          "LogIn",
                          style: Appwidgets.headlinetextfeildstyle(),
                        ),
                      ),
                      SizedBox(height: 10.0),

                      SizedBox(height: 20.0),
                      Text("Email", style: Appwidgets.signuptextfeildstyle()),
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
                      Text(
                        "Password",
                        style: Appwidgets.signuptextfeildstyle(),
                      ),
                      SizedBox(height: 5.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xffececf8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          obscureText: true,
                          controller: passwordcontroller,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter Password",
                            prefixIcon: Icon(Icons.password_outlined),
                          ),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Forgot Password?",
                            style: Appwidgets.simpletextfeildstyle(),
                          ),
                        ],
                      ),
                      SizedBox(height: 40.0),
                      GestureDetector(
                        onTap: () {
                          if(mailcontroller.text!= ""&& passwordcontroller.text!=""){
                            setState(() {
                              email =mailcontroller.text;
                              passwerd =passwordcontroller.text;
                            });
                            userlogin();
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
                              child: Text(
                                "Log In",
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
                            "Don't have account?",
                            style: Appwidgets.simpletextfeildstyle(),
                          ),
                          SizedBox(width: 10.0),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Signupscreen(),
                                ),
                              );
                            },
                            child: Text(
                              "Signup",
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
