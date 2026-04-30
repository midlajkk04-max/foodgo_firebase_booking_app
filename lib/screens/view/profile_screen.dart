import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project_hotel_bookking/screens/custom_widgets.dart/profile_infocard.dart';
import 'package:firebase_project_hotel_bookking/screens/view/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/profile_controller.dart';
import '../view/onboarding.dart';
import '../../core/constants/widget_support.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ProfileController>(context, listen: false).loadProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileController>(context);

    return Scaffold(
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              margin: const EdgeInsets.only(top: 40.0),
              child: Column(
                children: [
                  Text("Profile", style: Appwidgets.headlinetextfeildstyle()),

                  const SizedBox(height: 10.0),

                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Color(0xffececf8),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 30),

                         
                          Container(
                            height: 150,
                            width: 150,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(120),
                              child: Image.asset(
                                "assets/images/download (19).png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          const SizedBox(height: 40),

                          
                          infoCard(
                            icon: Icons.person,
                            title: "Name",
                            value: provider.name ?? "No Name",
                          ),

                          const SizedBox(height: 35),

                        
                          infoCard(
                            icon: Icons.mail_outline,
                            title: "Email",
                            value: provider.email ?? "No Email",
                          ),

                          const SizedBox(height: 35),

                          /// LOGOUT
                          actionCard(
                            icon: Icons.logout,
                            text: "LogOut",
                            onTap: () async {
                              await FirebaseAuth.instance.signOut();

                              final prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.clear();

                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Signupscreen(),
                                ),
                                (route) => false,
                              );
                            },
                          ),

                          const SizedBox(height: 35),

                          
                         
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}