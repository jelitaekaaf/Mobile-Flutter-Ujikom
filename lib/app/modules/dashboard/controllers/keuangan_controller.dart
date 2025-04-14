import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inventera/app/data/keuangan_response.dart';
import 'package:inventera/app/utils/api.dart';

class KeuanganController extends GetxController {
  var keuanganList = <KeuanganData>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchKeuangan();
  }

  Future<void> fetchKeuangan() async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse(BaseUrl.keuangan));

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var keuanganResponse = KeuanganResponse.fromJson(jsonData);
        keuanganList.assignAll(keuanganResponse.data);
      } else {
        Get.snackbar("Error", "Gagal mengambil data keuangan",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateKeuangan(KeuanganData keuangan) async {
    try {
      var response = await http.put(
        Uri.parse("${BaseUrl.keuangan}/${keuangan.id}"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "jenis": keuangan.jenis,
          "jumlah": keuangan.jumlah,
          "tanggal": keuangan.tanggal.toIso8601String(),
          "keterangan": keuangan.keterangan,
        }),
      );

      if (response.statusCode == 200) {
        int index = keuanganList.indexWhere((item) => item.id == keuangan.id);
        if (index != -1) {
          keuanganList[index] = KeuanganData(
            id: keuangan.id,
            jenis: keuangan.jenis,
            jumlah: keuangan.jumlah,
            tanggal: keuangan.tanggal,
            keterangan: keuangan.keterangan,
          );
          keuanganList.refresh();
        }
        Get.snackbar("Sukses", "Catatan keuangan berhasil diperbarui",
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        Get.snackbar("Error", "Gagal memperbarui catatan keuangan",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<void> deleteKeuangan(int id) async {
    try {
      var response = await http.delete(Uri.parse("${BaseUrl.keuangan}/$id"));

      if (response.statusCode == 200) {
        keuanganList.removeWhere((keuangan) => keuangan.id == id);
        Get.snackbar("Sukses", "Catatan keuangan berhasil dihapus",
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        Get.snackbar("Error", "Gagal menghapus catatan keuangan",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
