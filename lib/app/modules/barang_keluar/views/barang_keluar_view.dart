import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/barang_keluar_controller.dart';

class BarangKeluarView extends GetView<BarangKeluarController> {
  const BarangKeluarView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BarangKeluarView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'BarangKeluarView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
