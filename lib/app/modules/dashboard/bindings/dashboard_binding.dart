import 'package:get/get.dart';

import 'package:inventera/app/modules/dashboard/controllers/kategori_controller.dart';

import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KategoriController>(
      () => KategoriController(),
    );
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );
  }
}
