import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/keuangan_controller.dart';

class KeuanganView extends StatelessWidget {
  final KeuanganController keuanganController = Get.put(KeuanganController());

  KeuanganView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catatan Keuangan'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (keuanganController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (keuanganController.keuanganList.isEmpty) {
          return const Center(child: Text('Tidak ada catatan keuangan tersedia'));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: keuanganController.keuanganList.length,
          itemBuilder: (context, index) {
            var keuangan = keuanganController.keuanganList[index];
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(keuangan.id.toString()),
                ),
                title: Text(keuangan.jenis),
                subtitle: Text("Jumlah: Rp${keuangan.jumlah}\nTanggal: ${keuangan.tanggal}\nKeterangan: ${keuangan.keterangan}"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        _editKeuangan(keuangan);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _confirmDelete(keuangan.id);
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

void _editKeuangan(keuangan) {
  TextEditingController jenisController = TextEditingController(text: keuangan.jenis);
  TextEditingController jumlahController = TextEditingController(text: keuangan.jumlah.toString());
  TextEditingController keteranganController = TextEditingController(text: keuangan.keterangan);

  Get.defaultDialog(
    title: "Edit Catatan Keuangan",
    content: Column(
      children: [
        TextField(
          controller: jenisController,
          decoration: const InputDecoration(labelText: "Jenis"),
        ),
        TextField(
          controller: jumlahController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: "Jumlah"),
        ),
        TextField(
          controller: keteranganController,
          decoration: const InputDecoration(labelText: "Keterangan"),
        ),
      ],
    ),
    textConfirm: "Simpan",
    textCancel: "Batal",
    onConfirm: () {
      keuangan.jenis = jenisController.text;
      keuangan.jumlah = int.tryParse(jumlahController.text) ?? keuangan.jumlah;
      keuangan.keterangan = keteranganController.text;

      keuanganController.updateKeuangan(keuangan);
      keuanganController.keuanganList.refresh(); // Penting untuk memperbarui UI
      Get.back();
    },
  );
}


  void _confirmDelete(int id) {
    Get.defaultDialog(
      title: "Hapus Catatan Keuangan",
      middleText: "Apakah Anda yakin ingin menghapus catatan ini?",
      textConfirm: "Ya",
      textCancel: "Tidak",
      confirmTextColor: Colors.white,
      onConfirm: () {
        keuanganController.deleteKeuangan(id);
        Get.back();
      },
    );
  }
}