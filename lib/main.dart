import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_project_hotel_bookking/admin/controller/admin_login_controller.dart';
import 'package:firebase_project_hotel_bookking/admin/controller/admin_order_controller.dart';
import 'package:firebase_project_hotel_bookking/admin/controller/manage_user_controller.dart';
import 'package:firebase_project_hotel_bookking/admin/screens/admin_loginScreen.dart';
import 'package:firebase_project_hotel_bookking/controller/Home_controler.dart';
import 'package:firebase_project_hotel_bookking/controller/details_controller.dart';
import 'package:firebase_project_hotel_bookking/controller/login_controller.dart';
import 'package:firebase_project_hotel_bookking/controller/order_controller.dart';
import 'package:firebase_project_hotel_bookking/controller/profile_controller.dart';
import 'package:firebase_project_hotel_bookking/controller/signup_controller.dart';
import 'package:firebase_project_hotel_bookking/controller/wallet_controller.dart';
import 'package:firebase_project_hotel_bookking/core/constants/const_keys.dart';
import 'package:firebase_project_hotel_bookking/core/untiles/splashwrapper.dart';
import 'package:firebase_project_hotel_bookking/firebase_options.dart';
import 'package:firebase_project_hotel_bookking/screens/view/bottomnav_screen.dart';
import 'package:firebase_project_hotel_bookking/screens/view/login_screen.dart';
import 'package:firebase_project_hotel_bookking/screens/view/onboarding.dart';
import 'package:firebase_project_hotel_bookking/service/notification_service.dart';
import 'package:firebase_project_hotel_bookking/service/remote%20configure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

@pragma('vm:entry-point')
Future<void> firebaseBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Background notification is coming: ${message.notification?.title}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging.onBackgroundMessage(firebaseBackgroundHandler);

  await NotificationService.initNotification();

  final remoteConfigService = RemoteConfigService();
  await remoteConfigService.init();
  Stripe.publishableKey = publishedkey;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              HomeControler(remoteConfigService: remoteConfigService),
        ),
        ChangeNotifierProvider(create: (_) => DetailsController()),
        ChangeNotifierProvider(create: (_) => LoginController()),
        ChangeNotifierProvider(create: (_) => SignupController()),
        ChangeNotifierProvider(create: (_) => OrderController()),
        ChangeNotifierProvider(create: (_) => WalletController()),
        ChangeNotifierProvider(create: (_) => ProfileController()),
        ChangeNotifierProvider(create: (_) => AdminLoginController()),
        ChangeNotifierProvider(create: (_) => AdminOrderController()),
        ChangeNotifierProvider(create: (_) => ManageUserController()),
      ],
      child: MyApp(),
    ),
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
