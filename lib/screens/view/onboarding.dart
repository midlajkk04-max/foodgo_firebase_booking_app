import 'package:firebase_project_hotel_bookking/core/constants/widget_support.dart';
import 'package:firebase_project_hotel_bookking/screens/view/bottomnav_screen.dart';
import 'package:firebase_project_hotel_bookking/screens/view/homeScreen.dart';
import 'package:firebase_project_hotel_bookking/screens/view/signup_screen.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(top: 50.0),
        child: Column(
          children: [
            Image.asset("assets/images/onboard_2.png"),
            SizedBox(height: 20.0),
            Text(
              "The Fastest\nFood Delivery",
              textAlign: TextAlign.center,
              style: Appwidgets.headlinetextfeildstyle(),
            ),
            SizedBox(height: 20),
            Text(
              "Craving something delicious?\norder now and get your favorites\n delivered fast",
              textAlign: TextAlign.center,
              style: Appwidgets.simpletextfeildstyle(),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Signupscreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 45, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text("Get Started"),
            ),
          ],
        ),
      ),
    );
  }
}