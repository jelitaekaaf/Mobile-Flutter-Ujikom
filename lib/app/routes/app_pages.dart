import 'package:get/get.dart';

import '../modules/barang_keluar/bindings/barang_keluar_binding.dart';
import '../modules/barang_keluar/views/barang_keluar_view.dart';
import '../modules/barang_masuk/bindings/barang_masuk_binding.dart';
import '../modules/barang_masuk/views/barang_masuk_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';


// ignore_for_file: prefer_const_constructors

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () =>  ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.BARANG_MASUK,
      page: () =>  BarangMasukView(),
      binding: BarangMasukBinding(),
    ),
    GetPage(
      name: _Paths.BARANG_KELUAR,
      page: () => const BarangKeluarView(),
      binding: BarangKeluarBinding(),
    ),
    
  ];
}
