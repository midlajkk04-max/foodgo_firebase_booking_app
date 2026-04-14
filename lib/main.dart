import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_project_hotel_bookking/admin/admin_login.dart';
import 'package:firebase_project_hotel_bookking/admin/all_order.dart';
import 'package:firebase_project_hotel_bookking/admin/home_admin.dart';
import 'package:firebase_project_hotel_bookking/admin/manage_users.dart';
import 'package:firebase_project_hotel_bookking/controller/Home_controler.dart';
import 'package:firebase_project_hotel_bookking/controller/details_controller.dart';
import 'package:firebase_project_hotel_bookking/controller/login_controller.dart';
import 'package:firebase_project_hotel_bookking/controller/order_controller.dart';
import 'package:firebase_project_hotel_bookking/controller/profile_controller.dart';
import 'package:firebase_project_hotel_bookking/controller/signup_controller.dart';
import 'package:firebase_project_hotel_bookking/controller/wallet_controller.dart';
import 'package:firebase_project_hotel_bookking/core/constants/const_keys.dart';
import 'package:firebase_project_hotel_bookking/core/untiles/splashwrapper.dart';
import 'package:firebase_project_hotel_bookking/screens/view/bottomnav_screen.dart';
import 'package:firebase_project_hotel_bookking/screens/view/login_screen.dart';
import 'package:firebase_project_hotel_bookking/screens/view/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp();
  Stripe.publishableKey = publishedkey;
  runApp(
    MultiProvider(providers:[
      ChangeNotifierProvider(create: (_)=>HomeControler()),
      ChangeNotifierProvider(create: (_)=>DetailsController()),
      ChangeNotifierProvider(create: (_)=>LoginController()),
      ChangeNotifierProvider(create: (_)=>SignupController()),
      ChangeNotifierProvider(create: (_)=>OrderController()),
      ChangeNotifierProvider(create: (_)=>WalletController()),
      ChangeNotifierProvider(create: (_)=>ProfileController())
    ],child:  MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashWrapper(),
    );
  }
}
