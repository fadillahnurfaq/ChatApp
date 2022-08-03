import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ChangeProfileController extends GetxController {
  late TextEditingController emailC;
  late TextEditingController nameC;
  late TextEditingController statusC;
  late ImagePicker imagePicker;

  XFile? pickedImage = null;

  FirebaseStorage storage = FirebaseStorage.instance;

  Future<String?> selectImage(String uid) async {
    try {
      final dataImage =
          await imagePicker.pickImage(source: ImageSource.gallery);

      if (dataImage != null) {
        pickedImage = dataImage;
      }
      refresh();
      //! Kalau pakai get builder harus di update kayak setstate
      update();
    } catch (e) {
      print(e);
      pickedImage = null;
      update();
    }

    Reference storageRef = storage.ref("$uid.png");

    File file = File(pickedImage!.path);

    try {
      await storageRef.putFile(file);
      final photoUrl = await storageRef.getDownloadURL();
      resetImage();
      return photoUrl;
    } catch (e) {
      print(e);
      return null;
    }
  }

  void resetImage() {
    pickedImage = null;
    update();
  }

  @override
  void onInit() {
    emailC = TextEditingController();
    nameC = TextEditingController();
    statusC = TextEditingController();
    imagePicker = ImagePicker();
    super.onInit();
  }

  @override
  void onClose() {
    emailC.dispose();
    nameC.dispose();
    statusC.dispose();
    super.onClose();
  }
}
