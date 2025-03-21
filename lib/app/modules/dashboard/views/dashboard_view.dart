import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:inventera/app/modules/barang_keluar/views/barang_keluar_view.dart';
import 'package:inventera/app/modules/barang_masuk/views/barang_masuk_view.dart';
import 'package:inventera/app/modules/dashboard/views/barang_view.dart';
import 'package:inventera/app/modules/dashboard/views/kategori_view.dart';
import 'package:inventera/app/modules/dashboard/views/stok_view.dart';
import 'package:inventera/app/modules/profile/views/profile_view.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventera', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 11, 98, 69),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileView()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue[200]!, Colors.blue[400]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _buildDrawerItem(Icons.inventory, 'Barang Masuk', () {}),
              _buildDrawerItem(Icons.outbox, 'Barang Keluar', () {}),
              _buildDrawerItem(Icons.bar_chart, 'Laporan', () {}),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selamat datang di Inventera, Admin!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: "Cari...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildDashboardCard(context, Icons.inventory, 'Pemasukan', Colors.green, BarangMasukView()),
                _buildDashboardCard(context, Icons.inventory, 'Barang', const Color.fromARGB(255, 78, 61, 203), BarangView()),
                  // _buildDashboardCard(context, Icons.outbox, 'Pengeluaran', Colors.blue, BarangKeluarView()),
                _buildDashboardCard(context, Icons.store, 'Stok', Colors.orange, StokView()),
                _buildDashboardCard(context, Icons.bar_chart, 'Kategori', Colors.red, KategoriView()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
      onTap: onTap,
    );
  }

  Widget _buildDashboardCard(BuildContext context, IconData icon, String title, Color color, Widget? page) {
    return GestureDetector(
      onTap: () {
        if (page != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        }
      },
      child: Card(
        color: Colors.grey[200],
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: 100,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              SizedBox(height: 10),
              Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
