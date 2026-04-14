import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project_hotel_bookking/service/shared_preferncehelper.dart';
import 'package:firebase_project_hotel_bookking/screens/view/bottomnav_screen.dart';

class LoginController extends ChangeNotifier {

  String email = "";
  String password = "";

  TextEditingController mailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  Future<void> login(BuildContext context) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      /// ✅ SAME FIX
      await SharedPreferncehelper()
          .saveuserId(userCredential.user!.uid);
      await SharedPreferncehelper()
          .saveuseremail(userCredential.user!.email!);

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
      } 
      else if (e.code == "wrong password") {
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
}