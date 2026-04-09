import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferncehelper {
  static String useridkey = "USERKEY";
  static String userNamekey = "USERNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";
  static String userImagekey = "USERIMAGEEY";
  static String userAddresskey = "USERADDRESSKEY";

  Future<bool> saveuserId(String getuserid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(useridkey, getuserid);
  }

  Future<bool> saveusername(String getusername) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userNamekey, getusername);
  }

  Future<bool> saveuseremail(String getuseremail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userEmailKey, getuseremail);
  }

   Future<bool> saveuserAddress(String getuserAddress) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userAddresskey, getuserAddress);
  }

  Future<bool> saveuserimage(String getuserimage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userImagekey, getuserimage);
  }

   Future<String?> getuserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(useridkey);
  }

   Future<String?> getusername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userNamekey);
  }

  Future<String?> getuserimage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userImagekey);
  }

  Future<String?> getuseremail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmailKey);
  }
  Future<String?> getuserAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userAddresskey);
  }
}
