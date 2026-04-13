import 'package:firebase_auth/firebase_auth.dart';

class ProfileAuth {
  final FirebaseAuth auth =FirebaseAuth.instance;

  getcurrentUser()async{
    return await auth.currentUser;
  }

  Future Signout()async{
    await FirebaseAuth.instance.signOut();
  }
  Future deleteuser()async{
    User? user =await FirebaseAuth.instance.currentUser;
    user?.delete();
  }
}