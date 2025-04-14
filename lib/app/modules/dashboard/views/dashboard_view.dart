// ignore_for_file: unused_import, override_on_non_overriding_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventera/app/modules/dashboard/views/barang_view.dart';
import 'package:inventera/app/modules/dashboard/views/kategori_view.dart';
import 'package:inventera/app/modules/dashboard/views/keuangan_view.dart';
import 'package:inventera/app/modules/dashboard/views/stok_view.dart';
import 'package:inventera/app/modules/profile/views/profile_view.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});
  
  @override
  Widget _buildTransactionShortcut({
  required IconData icon,
  required String label,
  required Color color,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 140,
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: color.withOpacity(0.15),
            child: Icon(icon, color: color, size: 28),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    ),
  );
}

  Widget build(BuildContext context) {
    DashboardController controller = Get.put(DashboardController());
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Hello, Admin!',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      actions: [
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileView()),
          );
        },
        child: _buildIconButton(Icons.person),
      ),
      SizedBox(width: 12),
      _buildIconButton(Icons.notifications),
      SizedBox(width: 12),
    ],

      ),
      body:  SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Quick Access',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildQuickAction(context, Icons.bar_chart, 'Kategori', Colors.red, KategoriView()),
                _buildQuickAction(context, Icons.inventory, 'Barang', Colors.blue, BarangView()),
                _buildQuickAction(context, Icons.money, 'Keuangan', Colors.green, KeuanganView()),
                _buildQuickAction(context, Icons.store, 'Stok', Colors.purple, StokView()),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Upcoming Tasks',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            _buildTaskCard('Check Inventory', 'Today, 10:00 AM', Colors.green),
            _buildTaskCard('Restock Items', 'Tomorrow, 2:00 PM', Colors.red),
                        SizedBox(height: 20),
            Text(
              'Manajemen Barang',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTransactionShortcut(
                  icon: Icons.download_rounded,
                  label: 'Barang Masuk',
                  color: Colors.purple,
                  onTap: () {
                    // TODO: Ganti dengan navigasi ke halaman Barang Masuk
                    Get.snackbar("Aksi", "Navigasi ke Barang Masuk");
                  },
                ),
                _buildTransactionShortcut(
                  icon: Icons.upload_rounded,
                  label: 'Barang Keluar',
                  color: Colors.purple,
                  onTap: () {
                    // TODO: Ganti dengan navigasi ke halaman Barang Keluar
                    Get.snackbar("Aksi", "Navigasi ke Barang Keluar");
                  },
                ),
              ],
            ),

          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) {
          controller.changeIndex(index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Reports'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  /// Widget untuk ikon Person dan Notifikasi
  Widget _buildIconButton(IconData icon) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.purple.shade100, // Background ungu muda
      ),
      padding: EdgeInsets.all(8),
      child: Icon(icon, color: Colors.purple, size: 24),
    );
  }

  /// Widget untuk Quick Access dengan desain seperti Search Box
  Widget _buildQuickAction(BuildContext context, IconData icon, String title, Color color, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Container(
        width: 100, // Ukuran tetap agar sejajar
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: const Color.fromARGB(188, 255, 255, 255), // Fill color seperti Search box
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2), // Efek bayangan lembut
            ),
          ],
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: color.withOpacity(0.2), // Warna lebih soft
              child: Icon(icon, size: 28, color: color),
            ),
            SizedBox(height: 6), // Mengurangi jarak
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  /// Widget untuk Task Card
  Widget _buildTaskCard(String title, String time, Color color) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(Icons.task, color: color),
        title: Text(
          title,
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(time, style: GoogleFonts.poppins(fontSize: 14)),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}
