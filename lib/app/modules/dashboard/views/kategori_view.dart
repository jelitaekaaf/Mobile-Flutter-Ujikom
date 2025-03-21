import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/kategori_controller.dart';

class KategoriView extends StatelessWidget {
  final KategoriController controller = Get.put(KategoriController());

  KategoriView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kategori'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.kategoriList.isEmpty) {
          return const Center(child: Text('Tidak ada kategori tersedia'));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: controller.kategoriList.length,
          itemBuilder: (context, index) {
            var kategori = controller.kategoriList[index];
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(kategori.id.toString()),
                ),
                title: Text(kategori.nama),
                // subtitle: Text('ID: ${kategori.id}'),
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
            );
          },
        );
      }),
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
        controller.updateKategori(kategori);
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
        controller.deleteKategori(id);
        Get.back();
      },
    );
  }
}