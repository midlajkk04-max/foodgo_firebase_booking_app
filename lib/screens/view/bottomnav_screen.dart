import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_project_hotel_bookking/screens/view/homeScreen.dart';
import 'package:firebase_project_hotel_bookking/screens/view/orderscreen.dart';
import 'package:firebase_project_hotel_bookking/screens/view/profile_screen.dart';
import 'package:firebase_project_hotel_bookking/screens/view/wallet_screen.dart';
import 'package:flutter/material.dart';

class BottomNavscreen extends StatefulWidget {
  const BottomNavscreen({super.key});

  @override
  State<BottomNavscreen> createState() => _BottomNavscreenState();
}

class _BottomNavscreenState extends State<BottomNavscreen> {

   late List <Widget> pages;

   late HomeScreen Homepage;
   late Orderscreen order;
   late Walletscreen wallet;
   late Profilescreen profile;
   
   int currentindex = 0;
   @override
   void initState(){
    Homepage =HomeScreen();
    order =Orderscreen();
    wallet =Walletscreen();
    profile =Profilescreen();

    pages =[Homepage,order,wallet,profile];
    super.initState();
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 70,
        backgroundColor: Colors.white,
        color: Colors.black,
        animationDuration: Duration(milliseconds: 500),
        onTap: (int index) {
          setState(() {
            currentindex =index;
          });
        },
        items: [
          Icon(Icons.home,color: Colors.white,size: 30.0,),
           Icon(Icons.shopping_bag,color: Colors.white,size: 30.0,),
            Icon(Icons.wallet,color: Colors.white,size: 30.0,),
             Icon(Icons.person,color: Colors.white,size: 30.0,)
        ]),
        body: pages[currentindex],
    );
  }
}