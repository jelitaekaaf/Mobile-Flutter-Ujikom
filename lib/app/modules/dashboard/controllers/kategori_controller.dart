import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inventera/app/data/kategori_response.dart';
import 'package:inventera/app/utils/api.dart';

class KategoriController extends GetxController {
  var kategoriList = <Data>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchKategori();
  }

  Future<void> fetchKategori() async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse(BaseUrl.kategori));

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var kategoriResponse = KategoriResponse.fromJson(jsonData);
        kategoriList.assignAll(kategoriResponse.data);
      } else {
        Get.snackbar("Error", "Gagal mengambil data kategori",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateKategori(Data kategori) async {
    try {
      var response = await http.put(
        Uri.parse("${BaseUrl.kategori}/${kategori.id}"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"nama": kategori.nama}),
      );

      if (response.statusCode == 200) {
        int index = kategoriList.indexWhere((item) => item.id == kategori.id);
        if (index != -1) {
          kategoriList[index] = kategori;
          kategoriList.refresh();
        }
        Get.snackbar("Sukses", "Kategori berhasil diperbarui",
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        Get.snackbar("Error", "Gagal memperbarui kategori",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<void> deleteKategori(int id) async {
    try {
      var response = await http.delete(Uri.parse("${BaseUrl.kategori}/$id"));

      if (response.statusCode == 200) {
        kategoriList.removeWhere((kategori) => kategori.id == id);
        Get.snackbar("Sukses", "Kategori berhasil dihapus",
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        Get.snackbar("Error", "Gagal menghapus kategori",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
