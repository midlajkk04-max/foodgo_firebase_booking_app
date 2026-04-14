import 'package:firebase_project_hotel_bookking/screens/custom_widgets.dart/login_textFeild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_project_hotel_bookking/controller/login_controller.dart';
import 'package:firebase_project_hotel_bookking/core/constants/widget_support.dart';
import 'package:firebase_project_hotel_bookking/screens/view/signup_screen.dart';

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<LoginController>(context);

    return Scaffold(
      body: Stack(
        children: [

          /// TOP UI (UNCHANGED)
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
                Image.asset("assets/images/signup.png", height: 180),
                Image.asset("assets/images/home.png", width: 110),
              ],
            ),
          ),

          /// FORM
          Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 3.2,
              left: 20,
              right: 20,
            ),
            child: Material(
              elevation: 3,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: MediaQuery.of(context).size.height / 1.65,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SizedBox(height: 20),
                    Center(child: Text("LogIn", style: Appwidgets.headlinetextfeildstyle())),

                    SizedBox(height: 20),

                    Text("Email", style: Appwidgets.signuptextfeildstyle()),
                    SizedBox(height: 5),

                    /// ✅ CUSTOM WIDGET
                    LoginTextField(
                      controller: controller.mailcontroller,
                      hint: "Enter Email",
                      icon: Icons.mail,
                    ),

                    SizedBox(height: 20),

                    Text("Password", style: Appwidgets.signuptextfeildstyle()),
                    SizedBox(height: 5),

                    LoginTextField(
                      controller: controller.passwordcontroller,
                      hint: "Enter Password",
                      icon: Icons.password_outlined,
                      obscure: true,
                    ),

                    SizedBox(height: 40),

                    GestureDetector(
                      onTap: () {
                        if (controller.mailcontroller.text != "" &&
                            controller.passwordcontroller.text != "") {

                          controller.email = controller.mailcontroller.text;
                          controller.password = controller.passwordcontroller.text;

                          controller.login(context);
                          
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

                    SizedBox(height: 30),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have account?",
                            style: Appwidgets.simpletextfeildstyle()),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Signupscreen(),
                              ),
                            );
                          },
                          child: Text("Signup",
                              style: Appwidgets.boldtextfeildstyle()),
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
    );
  }
}