import 'package:chatapp/app/controllers/auth_controller.dart';
import 'package:chatapp/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final authC = Get.find<AuthController>();

  final ThemeData light = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.white,
    accentColor: Colors.black,
    buttonColor: Colors.red[900],
  );

  final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Color(0xFF686D76),
    accentColor: Colors.white,
    buttonColor: Colors.red[900],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Get.theme.primaryColor,
        body: Column(
          children: [
            Material(
              elevation: 5,
              child: Container(
                margin: EdgeInsets.only(top: context.mediaQueryPadding.top),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black38,
                    ),
                  ),
                ),
                padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Chats",
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Material(
                      color: Colors.red[900],
                      borderRadius: BorderRadius.circular(50),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () => Get.toNamed(Routes.PROFILE),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child:
                              Icon(Icons.person, size: 35, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: controller.chatsStream(authC.user.value.email!),
                builder: (context, snapshot1) {
                  if (snapshot1.connectionState == ConnectionState.active) {
                    var listDocsChat = snapshot1.data!.docs;
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: listDocsChat.length,
                      itemBuilder: (context, index) {
                        return StreamBuilder<
                            DocumentSnapshot<Map<String, dynamic>>>(
                          stream: controller
                              .friendStream(listDocsChat[index]["connection"]),
                          builder: (context, snapshot2) {
                            if (snapshot2.connectionState ==
                                ConnectionState.active) {
                              var data = snapshot2.data!.data();
                              return data!["status"] == ""
                                  ? ListTile(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      onTap: () => controller.goToChatRoom(
                                          "${listDocsChat[index].id}",
                                          authC.user.value.email!,
                                          listDocsChat[index]["connection"]),
                                      leading: CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.black26,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: data["photoUrl"] == "noimage"
                                              ? Image.asset(
                                                  "assets/logo/noimage.png",
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.network(
                                                  "${data["photoUrl"]}",
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                      ),
                                      title: Text(
                                        "${data["name"]}",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      trailing: listDocsChat[index]
                                                  ["total_unread"] ==
                                              0
                                          ? SizedBox()
                                          : Chip(
                                              backgroundColor: Colors.red[900],
                                              label: Text(
                                                "${listDocsChat[index]["total_unread"]}",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                    )
                                  : ListTile(
                                      onTap: () => controller.goToChatRoom(
                                          "${listDocsChat[index].id}",
                                          authC.user.value.email!,
                                          listDocsChat[index]["connection"]),
                                      leading: CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.black26,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: data["photoUrl"] == "noimage"
                                              ? Image.asset(
                                                  "assets/logo/noimage.png",
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.network(
                                                  "${data["photoUrl"]}",
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                      ),
                                      title: Text(
                                        "${data["name"]}",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      subtitle: Text(
                                        "${data["status"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      trailing: listDocsChat[index]
                                                  ["total_unread"] ==
                                              0
                                          ? SizedBox()
                                          : Chip(
                                              backgroundColor: Colors.red[900],
                                              label: Text(
                                                "${listDocsChat[index]["total_unread"]}",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                    );
                            }
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        );
                      },
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Get.toNamed(Routes.SEARCH),
          child: Icon(
            Icons.search,
            size: 30,
            color: Colors.white,
          ),
          backgroundColor: Colors.red[900],
        ));
  }
}
