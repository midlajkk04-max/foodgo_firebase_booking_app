import 'package:firebase_project_hotel_bookking/core/constants/widget_support.dart';
import 'package:firebase_project_hotel_bookking/service/database.dart';
import 'package:flutter/material.dart';

class AddFoodScreen extends StatefulWidget {
  const AddFoodScreen({super.key});

  @override
  State<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();

  String selectedCategory = "pizza";
  bool isLoading = false;

  String selectedImage = "assets/images/download (13).png";

  final List<String> foodImages = [
    "assets/images/download (12).png",
    "assets/images/download (13).png",
    "assets/images/download (14).png",
    
    "assets/images/download (16).png",
    "assets/images/category_1.png",
  ];

  Future<void> uploadFood() async {
    if (namecontroller.text.trim().isEmpty ||
        pricecontroller.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Please fill all fields",
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      );
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      String id = DateTime.now().millisecondsSinceEpoch.toString();

      Map<String, dynamic> foodMap = {
        "name": namecontroller.text.trim(),
        "price": pricecontroller.text.trim(),
        "category": selectedCategory,
        "Foodimage": selectedImage,
        "SearchKey":
            namecontroller.text.trim().substring(0, 1).toUpperCase(),
      };

      await Databasemethod().addFood(foodMap, id);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "Food Added Successfully",
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      );

      namecontroller.clear();
      pricecontroller.clear();
      selectedCategory = "pizza";
      selectedImage = "assets/images/download (13).png";

      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Failed to add food",
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    namecontroller.dispose();
    pricecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 40.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Color(0xffef2b39),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 5),
                  Text(
                    "Add Food",
                    style: Appwidgets.headlinetextfeildstyle(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xffececf8),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Food Name",
                        style: Appwidgets.signuptextfeildstyle(),
                      ),
                      SizedBox(height: 5.0),
                      Container(
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: namecontroller,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter Food Name",
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        "Price",
                        style: Appwidgets.signuptextfeildstyle(),
                      ),
                      SizedBox(height: 5.0),
                      Container(
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: pricecontroller,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter Price",
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),

                      Text(
                        "Select Image",
                        style: Appwidgets.signuptextfeildstyle(),
                      ),
                      SizedBox(height: 5.0),

                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedImage,
                            isExpanded: true,
                            items: foodImages.map((imagePath) {
                              return DropdownMenuItem<String>(
                                value: imagePath,
                                child: Text(imagePath),
                              );
                            }).toList(),
                            onChanged: (value) {
                              selectedImage = value!;
                              setState(() {});
                            },
                          ),
                        ),
                      ),

                      SizedBox(height: 15.0),

                      Center(
                        child: Image.asset(
                          selectedImage,
                          height: 120,
                          width: 120,
                          fit: BoxFit.cover,
                        ),
                      ),

                      SizedBox(height: 20.0),

                      Text(
                        "Category",
                        style: Appwidgets.signuptextfeildstyle(),
                      ),
                      SizedBox(height: 5.0),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedCategory,
                            isExpanded: true,
                            items: const [
                              DropdownMenuItem(
                                value: "pizza",
                                child: Text("Pizza"),
                              ),
                              DropdownMenuItem(
                                value: "burger",
                                child: Text("Burger"),
                              ),
                            ],
                            onChanged: (value) {
                              selectedCategory = value!;
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      isLoading
                          ? Center(child: CircularProgressIndicator())
                          : GestureDetector(
                              onTap: uploadFood,
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 12.0),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Color(0xffef2b39),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    "Add Food",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}