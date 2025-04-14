// ignore_for_file: unused_import

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import '../controllers/stok_controller.dart';
import '../controllers/barang_controller.dart';

class StokView extends StatelessWidget {
  final StokController stokController = Get.put(StokController());
  final BarangController barangController = Get.put(BarangController());

  StokView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stok'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () {
              _generatePDF();
            },
          ),
        ],
      ),
      body: Obx(() {
        if (stokController.isLoading.value || barangController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (stokController.stokList.isEmpty) {
          return const Center(child: Text('Tidak ada stok tersedia'));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: stokController.stokList.length,
          itemBuilder: (context, index) {
            var stok = stokController.stokList[index];
            var barang = barangController.barangList.firstWhereOrNull((b) => b.id == stok.idBarang);
            
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text('Nama Barang: ${barang?.namaBarang ?? "Tidak Ditemukan"}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Jumlah: ${stok.jumlah}'),
                    Text('Tanggal: ${stok.tanggal}'),
                    Text('Keterangan: ${stok.keterangan}'),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    _confirmDelete(stok.id);
                  },
                ),
              ),
            );
          },
        );
      }),
    );
  }

  void _confirmDelete(int id) {
    Get.defaultDialog(
      title: "Hapus Stok",
      middleText: "Apakah Anda yakin ingin menghapus stok ini?",
      textConfirm: "Ya",
      textCancel: "Tidak",
      confirmTextColor: Colors.white,
      onConfirm: () {
        stokController.deleteStok(id);
        Get.back();
      },
    );
  }

  Future<void> _generatePDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text("Laporan Stok", style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              pw.Table.fromTextArray(
                headers: ["Nama Barang", "Jumlah", "Tanggal", "Keterangan"],
                data: stokController.stokList.map((stok) {
                  var barang = barangController.barangList.firstWhereOrNull((b) => b.id == stok.idBarang);
                  return [
                    barang?.namaBarang ?? "Tidak Ditemukan",
                    stok.jumlah.toString(),
                    stok.tanggal,
                    stok.keterangan
                  ];
                }).toList(),
              ),
            ],
          );
        },
      ),
    );

    final output = await getExternalStorageDirectory();
    final file = File("${output!.path}/laporan_stok.pdf");

    await file.writeAsBytes(await pdf.save());

    Get.snackbar("Sukses", "PDF berhasil dibuat di ${file.path}");
  }
}
