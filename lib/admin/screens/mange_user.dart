import 'package:firebase_project_hotel_bookking/admin/admincustom_widgets/manage_user_card.dart';
import 'package:firebase_project_hotel_bookking/admin/controller/manage_user_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_project_hotel_bookking/core/constants/widget_support.dart';


class ManageUsersScreen extends StatefulWidget {
  const ManageUsersScreen({super.key});

  @override
  State<ManageUsersScreen> createState() => _ManageUsersScreenState();
}

class _ManageUsersScreenState extends State<ManageUsersScreen> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<ManageUserController>(context, listen: false).fetchUsers());
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ManageUserController>(context);

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
                  SizedBox(width: MediaQuery.of(context).size.width / 6),
                  Text(
                    "Current users",
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
                child: Column(
                  children: [
                    SizedBox(height: 20.0),
                    Container(
                      height: MediaQuery.of(context).size.height / 2,
                      child: provider.userStream == null
                          ? Center(child: CircularProgressIndicator())
                          : StreamBuilder(
                              stream: provider.userStream,
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Container();
                                }

                                return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: (context, index) {
                                    var ds = snapshot.data.docs[index];

                                    return ManageUserCard(
                                      ds: ds,
                                      onDelete: () async {
                                        await provider.deleteUser(ds["Id"]);
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                    ),
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