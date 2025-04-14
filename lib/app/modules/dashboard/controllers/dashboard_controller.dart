// ignore_for_file: unused_field, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:inventera/app/modules/dashboard/views/dashboard_view.dart';
import 'package:inventera/app/modules/dashboard/views/kategori_view.dart';
import 'package:inventera/app/modules/profile/views/profile_view.dart';

class DashboardController extends GetxController {
  //TODO: Implement DashboardController
  var selectedIndex = 0.obs;
  final _getConnect = GetConnect();
  final token = GetStorage().read('token');

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  final List<Widget> pages = [ 
    DashboardView(),
    KategoriView(),
    ProfileView(),
  ];
  
  @override
  void onInit() {  
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

}
