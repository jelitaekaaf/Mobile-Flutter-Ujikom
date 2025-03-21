import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inventera/app/data/barang_response.dart';
import 'package:inventera/app/utils/api.dart';

class BarangController extends GetxController {
  var barangList = <BarangData>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBarang();
  }

  Future<void> fetchBarang() async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse(BaseUrl.barang));

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var barangResponse = BarangResponse.fromJson(jsonData);
        barangList.assignAll(barangResponse.data);
      } else {
        Get.snackbar("Error", "Gagal mengambil data barang",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateBarang(BarangData barang) async {
    try {
      var response = await http.put(
        Uri.parse("${BaseUrl.barang}/${barang.id}"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "id_kategori": barang.idKategori,
          "nama_barang": barang.namaBarang,
          "harga_beli": barang.hargaBeli,
          "harga_jual": barang.hargaJual,
          "stok": barang.stok,
        }),
      );

      if (response.statusCode == 200) {
        int index = barangList.indexWhere((item) => item.id == barang.id);
        if (index != -1) {
          barangList[index] = barang;
          barangList.refresh();
        }
        Get.snackbar("Sukses", "Barang berhasil diperbarui",
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        Get.snackbar("Error", "Gagal memperbarui barang",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<void> deleteBarang(int id) async {
    try {
      var response = await http.delete(Uri.parse("${BaseUrl.barang}/$id"));

      if (response.statusCode == 200) {
        barangList.removeWhere((barang) => barang.id == id);
        Get.snackbar("Sukses", "Barang berhasil dihapus",
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        Get.snackbar("Error", "Gagal menghapus barang",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
