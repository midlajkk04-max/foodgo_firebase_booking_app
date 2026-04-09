import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project_hotel_bookking/admin/home_admin.dart';
import 'package:firebase_project_hotel_bookking/core/constants/widget_support.dart';
import 'package:flutter/material.dart';

class AdminLoginscreen extends StatefulWidget {
  const AdminLoginscreen({super.key});

  @override
  State<AdminLoginscreen> createState() => _AdminLoginscreenState();
}

class _AdminLoginscreenState extends State<AdminLoginscreen> {
  TextEditingController usernamecontroller =TextEditingController();
  TextEditingController passwerdcontroller =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                      Text("Username", style: Appwidgets.signuptextfeildstyle()),
                      SizedBox(height: 5.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xffececf8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: usernamecontroller,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter Username",
                            prefixIcon: Icon(Icons.person_outline),
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
                          controller: passwerdcontroller,
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
                         loginAdmin();
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
                                "LogIn",
                                style: Appwidgets.boldwhitetextfeildstyle(),
                              ),
                            ),
                          ),
                        ),
                      ),
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
  loginAdmin(){
    FirebaseFirestore.instance.collection("Admin").get().then((snapshot){
      snapshot.docs.forEach((result){
        if(result.data()["Username"]!=usernamecontroller.text.trim()){
                    ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                "Yor username is not correct",
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          );
        }else if(result.data()['password']!=passwerdcontroller.text){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                "Yor password is not correct",
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          );
        }else{
          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeAdminscreen()));
        }
      });
    });
  }
}
