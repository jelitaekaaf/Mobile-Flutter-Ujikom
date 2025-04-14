// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:inventera/app/data/barangMasuk_response.dart';
// import 'package:inventera/app/utils/api.dart';

// class BarangMasukController extends GetxController {
//   var barangMasukList = <BarangMasuk>[].obs;
//   var isLoading = true.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchBarangMasuk();
//   }

//   Future<void> fetchBarangMasuk() async {
//     try {
//       isLoading(true);
//       var response = await http.get(Uri.parse(BaseUrl.barangMasuk));

//       if (response.statusCode == 200) {
//         var jsonData = json.decode(response.body);
//         var barangMasukResponse = BarangMasukResponse.fromJson(jsonData);
//         barangMasukList.assignAll(barangMasukResponse.data);
//       } else {
//         Get.snackbar("Error", "Gagal mengambil data barang masuk",
//             backgroundColor: Colors.red, colorText: Colors.white);
//       }
//     } catch (e) {
//       Get.snackbar("Error", "Terjadi kesalahan: $e",
//           backgroundColor: Colors.red, colorText: Colors.white);
//     } finally {
//       isLoading(false);
//     }
//   }

//   Future<void> approveBarangMasuk(int id) async {
//     try {
//       var response = await http.put(
//         Uri.parse("${BaseUrl.barangMasuk}/approve/$id"),
//         headers: {"Content-Type": "application/json"},
//       );

//       if (response.statusCode == 200) {
//         int index = barangMasukList.indexWhere((item) => item?.id == id);
//         if (index != -1) {
//           barangMasukList[index] = barangMasukList[index].copyWith(status: "disetujui");
//           barangMasukList.refresh();
//         }
//         Get.snackbar("Sukses", "Barang masuk berhasil disetujui",
//             backgroundColor: Colors.green, colorText: Colors.white);
//       } else {
//         Get.snackbar("Error", "Gagal menyetujui barang masuk",
//             backgroundColor: Colors.red, colorText: Colors.white);
//       }
//     } catch (e) {
//       Get.snackbar("Error", "Terjadi kesalahan: $e",
//           backgroundColor: Colors.red, colorText: Colors.white);
//     }
//   }

//   Widget buildApproveButton(int id, String status) {
//     if (status == "pending") {
//       return ElevatedButton(
//         onPressed: () => approveBarangMasuk(id),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.lightBlue.shade100,
//         ),
//         child: Text("Approve", style: TextStyle(color: Colors.black)),
//       );
//     }
//     return Text("Disetujui", style: TextStyle(color: Colors.green));
//   }
// }
