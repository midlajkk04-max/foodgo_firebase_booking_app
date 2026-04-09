import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project_hotel_bookking/core/constants/widget_support.dart';
import 'package:firebase_project_hotel_bookking/service/database.dart';
import 'package:firebase_project_hotel_bookking/service/shared_preferncehelper.dart';
import 'package:flutter/material.dart';

class Orderscreen extends StatefulWidget {
  const Orderscreen({super.key});

  @override
  State<Orderscreen> createState() => _OrderscreenState();
}

class _OrderscreenState extends State<Orderscreen> {

 String? id;

 getthesharedpref()async{
  id =await SharedPreferncehelper().getuserId();
  setState(() {
    
  });

  getontheload()async{
    await getthesharedpref();
    orderStream =await Databasemethod().getuserorders(id!);
    setState(() {
      
    });
  }
   @override
   void initState(){
    super.initState();
    getontheload();
   }
 }


  Stream? orderStream;

   Widget allorders(){
    return StreamBuilder(stream: orderStream, builder: (context ,snapshot){
      return snapshot.hasData? ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: snapshot.data.docs.length,
      itemBuilder: (context,Index){
       DocumentSnapshot ds = snapshot.data.docs[Index];
       return Container(
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Material(
                        elevation: 3.0,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 5.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: Color(0xffef2b39),
                                  ),
                                  SizedBox(width: 10.0),
                                  Text(
                                    ds["Address"],
                                    style: Appwidgets.simpletextfeildstyle(),
                                  ),
                                ],
                              ),
                              Divider(),
                              Row(
                               
                                children: [
                                  Image.asset(
                                   ds['Foodimage'],
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(width: 20.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ds['FoodName'],
                                        style: Appwidgets.boldtextfeildstyle(),
                                      ),
                                       SizedBox(height: 5.0,),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons
                                                .production_quantity_limits_outlined,
                                            color: Color(0xffef2b39),
                                          ),
                                          SizedBox(width: 10.0),
                                          Text(
                                            ds["Quantity"],
                                            style:
                                                Appwidgets.boldtextfeildstyle(),
                                          ),
                                          SizedBox(width: 30.0),
                                          Icon(
                                            Icons.monetization_on,
                                            color: Color(0xffef2b39),
                                          ),
                                          SizedBox(width: 10.0),
                                          Text(
                                            "\$"+ds["Totel"],
                                            style:
                                                Appwidgets.boldtextfeildstyle(),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5.0,),
                                      Text(
                                        ds["Status"]+"",
                                        style: TextStyle(
                                          color: Color(0xffef2b39),
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
      }):Container();
    });
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 40.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Orders", style: Appwidgets.headlinetextfeildstyle()),
              ],
            ),
            SizedBox(height: 10.0),
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
                child: Column(
                  children: [
                    SizedBox(height: 20.0),
                    Container(
                       height: MediaQuery.of(context).size.height/1.5,
                      child: allorders()),
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
