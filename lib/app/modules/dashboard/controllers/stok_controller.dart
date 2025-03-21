import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inventera/app/data/stok_response.dart';
import 'package:inventera/app/utils/api.dart';

class StokController extends GetxController {
  var stokList = <StokData>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchStok();
  }

  Future<void> fetchStok() async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse(BaseUrl.stok));

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var stokResponse = StokResponse.fromJson(jsonData);
        stokList.assignAll(stokResponse.data);
      } else {
        Get.snackbar("Error", "Gagal mengambil data stok",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateStok(StokData stok) async {
    try {
      var response = await http.put(
        Uri.parse("${BaseUrl.stok}/${stok.id}"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "id_barang": stok.idBarang,
          "jumlah": stok.jumlah,
          "tanggal": stok.tanggal,
          "keterangan": stok.keterangan
        }),
      );

      if (response.statusCode == 200) {
        int index = stokList.indexWhere((item) => item.id == stok.id);
        if (index != -1) {
          stokList[index] = stok;
          stokList.refresh();
        }
        Get.snackbar("Sukses", "Stok berhasil diperbarui",
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        Get.snackbar("Error", "Gagal memperbarui stok",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<void> deleteStok(int id) async {
    try {
      var response = await http.delete(Uri.parse("${BaseUrl.stok}/$id"));

      if (response.statusCode == 200) {
        stokList.removeWhere((stok) => stok.id == id);
        Get.snackbar("Sukses", "Stok berhasil dihapus",
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        Get.snackbar("Error", "Gagal menghapus stok",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
