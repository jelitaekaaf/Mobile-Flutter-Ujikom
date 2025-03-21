// ignore_for_file: unused_import

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:inventera/app/routes/app_pages.dart'; // Sesuaikan dengan struktur project

class ProfileController extends GetxController {
  var userName = "Admin Inventera".obs;
  var email = "admin@inventera.com".obs;
  var profileImage = "https://i.pravatar.cc/150?img=3".obs; // Placeholder foto profil

  void logout() {
    Get.offAllNamed(Routes.LOGIN); // Arahkan ke halaman login setelah logout
  }

  // Simulasi perubahan nama (misalnya dari API atau input user)
  void updateProfile(String newName, String newEmail) {
    userName.value = newName;
    email.value = newEmail;
  }

  // Simulasi update foto profil
  void updateProfileImage(String newImageUrl) {
    profileImage.value = newImageUrl;
  }
}
