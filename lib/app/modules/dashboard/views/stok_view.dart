import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                leading: CircleAvatar(
                  child: Text(stok.id.toString()),
                ),
                title: Text('Nama Barang: ${barang?.namaBarang ?? "Tidak Ditemukan"}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Jumlah: ${stok.jumlah}'),
                    Text('Tanggal: ${stok.tanggal}'),
                    Text('Keterangan: ${stok.keterangan}'),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        _editStok(stok);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _confirmDelete(stok.id);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }

  void _editStok(stok) {
    Get.defaultDialog(
      title: "Edit Stok",
      content: Column(
        children: [
          TextField(
            controller: TextEditingController(text: stok.jumlah.toString()),
            keyboardType: TextInputType.number,
            onChanged: (value) => stok.jumlah = int.tryParse(value) ?? stok.jumlah,
            decoration: const InputDecoration(labelText: "Jumlah Stok"),
          ),
        ],
      ),
      textConfirm: "Simpan",
      textCancel: "Batal",
      onConfirm: () {
        stokController.updateStok(stok);
        Get.back();
      },
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
}