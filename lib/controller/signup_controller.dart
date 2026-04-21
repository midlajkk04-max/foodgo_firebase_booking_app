import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:random_string/random_string.dart';
import '../service/database.dart';
import '../service/shared_preferncehelper.dart';
import '../screens/view/bottomnav_screen.dart';

class SignupController extends ChangeNotifier {
  bool isLoading = false;

 Future<void> registerUser({
  required String name,
  required String email,
  required String password,
  required BuildContext context,
}) async {
  try {
    isLoading = true;
    notifyListeners();

    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    String id = FirebaseAuth.instance.currentUser!.uid;

    Map<String, dynamic> userInfo = {
      "Name": name,
      "Email": email,
      "Id": id,
      "wallet": "0",
    };

    await SharedPreferncehelper().saveuseremail(email);
    await SharedPreferncehelper().saveusername(name);
    await SharedPreferncehelper().saveuserId(id);

    await Databasemethod().adduserdetails(userInfo, id);

  
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        content: Text("Registered successfully"),
      ),
    );

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => BottomNavscreen()),
      (route) => false,
    );

  } on FirebaseAuthException catch (e) {
    String msg = "Error";

    if (e.code == "weak-password") {
      msg = "Password is too weak";
    } else if (e.code == "email-already-in-use") {
      msg = "Account already exists";
    }

    
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.orange,
        content: Text(msg),
      ),
    );

  } finally {
    isLoading = false;
    notifyListeners();
  }
}
}
