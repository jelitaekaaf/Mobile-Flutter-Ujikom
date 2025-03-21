import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/barang_controller.dart';

class BarangView extends StatelessWidget {
  final BarangController controller = Get.put(BarangController());

  BarangView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Barang'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.barangList.isEmpty) {
          return const Center(child: Text('Tidak ada barang tersedia'));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: controller.barangList.length,
          itemBuilder: (context, index) {
            var barang = controller.barangList[index];
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(barang.id.toString()),
                ),
                title: Text('Nama Barang: ${barang.namaBarang}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Kategori: ${barang.kategoriNama}'),
                    Text('Harga Beli: Rp${barang.hargaBeli}'),
                    Text('Harga Jual: Rp${barang.hargaJual}'),
                    // Text('Stok: ${barang.stok}'),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        _editBarang(barang);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _confirmDelete(barang.id);
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

  void _editBarang(barang) {
    Get.defaultDialog(
      title: "Edit Barang",
      content: Column(
        children: [
          TextField(
            controller: TextEditingController(text: barang.namaBarang),
            onChanged: (value) => barang.namaBarang = value,
            decoration: const InputDecoration(labelText: "Nama Barang"),
          ),
        ],
      ),
      textConfirm: "Simpan",
      textCancel: "Batal",
      onConfirm: () {
        controller.updateBarang(barang);
        Get.back();
      },
    );
  }

  void _confirmDelete(int id) {
    Get.defaultDialog(
      title: "Hapus Barang",
      middleText: "Apakah Anda yakin ingin menghapus barang ini?",
      textConfirm: "Ya",
      textCancel: "Tidak",
      confirmTextColor: Colors.white,
      onConfirm: () {
        controller.deleteBarang(id);
        Get.back();
      },
    );
  }
}
