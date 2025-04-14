import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/kategori_controller.dart';
import '../controllers/barang_controller.dart';

class KategoriView extends StatelessWidget {
  final KategoriController kategoriController = Get.put(KategoriController());
  final BarangController barangController = Get.put(BarangController());

  KategoriView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kategori'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (kategoriController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (kategoriController.kategoriList.isEmpty) {
          return const Center(child: Text('Tidak ada kategori tersedia'));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: kategoriController.kategoriList.length,
          itemBuilder: (context, index) {
            var kategori = kategoriController.kategoriList[index];
            return GestureDetector(
              onTap: () {
                _showBarangModal(context, kategori.id, kategori.nama);
              },
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(kategori.id.toString()),
                  ),
                  title: Text(kategori.nama),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          _editKategori(kategori);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _confirmDelete(kategori.id);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  void _showBarangModal(BuildContext context, int kategoriId, String kategoriNama) {
  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width * 0.8, // Lebar 80% layar
        constraints: const BoxConstraints(maxHeight: 400), // Maksimal tinggi modal
        child: Obx(() {
          var barangList = barangController.barangList.where((b) => b.idKategori == kategoriId).toList();

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Barang dalam Kategori: $kategoriNama",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              const SizedBox(height: 10),
              if (barangList.isEmpty) 
                const Center(child: Text("Tidak ada barang dalam kategori ini"))
              else
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: barangList.length,
                    itemBuilder: (context, index) {
                      var barang = barangList[index];
                      return ListTile(
                        leading: const Icon(Icons.shopping_bag),
                        title: Text(barang.namaBarang),
                        subtitle: Text("Harga: Rp${barang.hargaJual}"),
                      );
                    },
                  ),
                ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => Get.back(),
                child: const Text("Tutup"),
              ),
            ],
          );
        }),
      ),
    ),
  );
}


  void _editKategori(kategori) {
    Get.defaultDialog(
      title: "Edit Kategori",
      content: Column(
        children: [
          TextField(
            controller: TextEditingController(text: kategori.nama),
            onChanged: (value) => kategori.nama = value,
            decoration: const InputDecoration(labelText: "Nama Kategori"),
          ),
        ],
      ),
      textConfirm: "Simpan",
      textCancel: "Batal",
      onConfirm: () {
        kategoriController.updateKategori(kategori);
        Get.back();
      },
    );
  }

  void _confirmDelete(int id) {
    Get.defaultDialog(
      title: "Hapus Kategori",
      middleText: "Apakah Anda yakin ingin menghapus kategori ini?",
      textConfirm: "Ya",
      textCancel: "Tidak",
      confirmTextColor: Colors.white,
      onConfirm: () {
        kategoriController.deleteKategori(id);
        Get.back();
      },
    );
  }
}
