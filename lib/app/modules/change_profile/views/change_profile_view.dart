import 'package:avatar_glow/avatar_glow.dart';
import 'package:chatapp/app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/change_profile_controller.dart';

class ChangeProfileView extends GetView<ChangeProfileController> {
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    //! pakai obx
    controller.emailC.text = authC.user.value.email!;
    controller.nameC.text = authC.user.value.name!;
    controller.statusC.text = authC.user.value.status!;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back, color: Colors.white),
          ),
          backgroundColor: Colors.red[900],
          title: Text(
            'Change Profile',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                authC.changeProfile(
                  controller.nameC.text,
                  controller.statusC.text,
                );
              },
              icon: Icon(Icons.save, color: Colors.white),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              AvatarGlow(
                endRadius: 75,
                glowColor: Colors.black,
                duration: Duration(seconds: 2),
                child: Container(
                    margin: EdgeInsets.all(15),
                    width: 120,
                    height: 120,
                    child: Obx(
                      () => ClipRRect(
                        borderRadius: BorderRadius.circular(120),
                        child: authC.user.value.photoUrl! == "noimage"
                            ? Image.asset(
                                "assets/logo/noimage.png",
                                fit: BoxFit.cover,
                              )
                            : Image.network(authC.user.value.photoUrl!,
                                fit: BoxFit.cover),
                      ),
                    )),
              ),
              SizedBox(height: 20),
              TextField(
                readOnly: true,
                textInputAction: TextInputAction.next,
                controller: controller.emailC,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(color: Get.theme.accentColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: controller.nameC,
                textInputAction: TextInputAction.next,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  labelText: "Name",
                  labelStyle: TextStyle(color: Get.theme.accentColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                textInputAction: TextInputAction.done,
                onEditingComplete: () {
                  authC.changeProfile(
                    controller.nameC.text,
                    controller.statusC.text,
                  );
                },
                controller: controller.statusC,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  labelText: "Status",
                  labelStyle: TextStyle(color: Get.theme.accentColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Pilin Gambar"),
                    GetBuilder<ChangeProfileController>(
                      builder: (c) => TextButton(
                        onPressed: () {
                          c
                              .selectImage(authC.user.value.uid!)
                              .then((hasilKembalian) {
                            if (hasilKembalian != null) {
                              authC.updatePhotoUrl(hasilKembalian);
                            }
                          });
                        },
                        child: Text(
                          "Pilih",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: Get.width,
                child: ElevatedButton(
                  onPressed: () {
                    authC.changeProfile(
                      controller.nameC.text,
                      controller.statusC.text,
                    );
                  },
                  child: Text(
                    "UPDATE",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
