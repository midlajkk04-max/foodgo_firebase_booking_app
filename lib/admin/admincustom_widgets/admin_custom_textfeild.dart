import 'package:flutter/material.dart';
import 'package:firebase_project_hotel_bookking/core/constants/widget_support.dart';

Widget admincustomTextField({
  required TextEditingController controller,
  required String hint,
  required IconData icon,
  bool obscure = false,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Color(0xffececf8),
      borderRadius: BorderRadius.circular(10),
    ),
    child: TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hint,
        prefixIcon: Icon(icon),
      ),
    ),
  );
}

Widget loginButton(VoidCallback onTap) {
  return Center(
    child: GestureDetector(
      onTap: onTap,
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
  );
}