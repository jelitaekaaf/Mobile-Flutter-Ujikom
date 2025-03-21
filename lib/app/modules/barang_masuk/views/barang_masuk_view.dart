// ignore_for_file: null_check_always_fails

import 'package:flutter/material.dart';

class BarangMasukView extends StatefulWidget {
  @override
  _BarangMasukViewState createState() => _BarangMasukViewState();
}

class _BarangMasukViewState extends State<BarangMasukView> {
  // Contoh data barang masuk
  List<Map<String, dynamic>> barangMasuk = List.generate(20, (index) => {
        'nama': 'Barang ${index + 1}',
        'kode_barang': 'BR00${index + 1}',
        'kategori': index % 2 == 0 ? 'Elektronik' : 'Peralatan',
        'pemasok': 'Pemasok ${index + 1}',
        'jumlah': (index + 1) * 2,
        'harga_beli': 50000 * (index + 1),
        'tanggal_masuk': '2025-03-${(index % 30) + 1}',
        'faktur': 'INV-${index + 1}',
        'status': 'Pending',
      });

  int _rowsPerPage = 5;

  void _ubahStatus(int index, String statusBaru) {
    setState(() {
      barangMasuk[index]['status'] = statusBaru;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barang Keluar'),
        backgroundColor: Colors.green[200],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: PaginatedDataTable(
          header: Text(
            'Daftar Barang Keluar',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          rowsPerPage: _rowsPerPage,
          availableRowsPerPage: [5, 10, 15],
          onRowsPerPageChanged: (value) {
            setState(() {
              _rowsPerPage = value!;
            });
          },
          columns: [
            DataColumn(label: Text('Nama')),
            DataColumn(label: Text('Kode Barang')),
            DataColumn(label: Text('Kategori')),
            DataColumn(label: Text('Pemasok')),
            DataColumn(label: Text('Jumlah')),
            DataColumn(label: Text('Harga Beli')),
            DataColumn(label: Text('Tanggal Masuk')),
            DataColumn(label: Text('Faktur')),
            DataColumn(label: Text('Status')),
            DataColumn(label: Text('Aksi')),
          ],
          source: _BarangMasukDataSource(barangMasuk, _ubahStatus),
        ),
      ),
    );
  }
}

class _BarangMasukDataSource extends DataTableSource {
  final List<Map<String, dynamic>> _data;
  final Function(int, String) _ubahStatus;

  _BarangMasukDataSource(this._data, this._ubahStatus);

  @override
  DataRow getRow(int index) {
    if (index >= _data.length) return null!;
    final barang = _data[index];

    return DataRow(cells: [
      DataCell(Text(barang['nama'])),
      DataCell(Text(barang['kode_barang'])),
      DataCell(Text(barang['kategori'])),
      DataCell(Text(barang['pemasok'])),
      DataCell(Text(barang['jumlah'].toString())),
      DataCell(Text('Rp${barang['harga_beli']}')),
      DataCell(Text(barang['tanggal_masuk'])),
      DataCell(Text(barang['faktur'])),
      DataCell(
        Text(
          barang['status'],
          style: TextStyle(
            color: barang['status'] == 'Disetujui'
                ? Colors.green
                : barang['status'] == 'Ditolak'
                    ? Colors.red
                    : Colors.orange,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      DataCell(
        Row(
          children: [
            ElevatedButton(
              onPressed: () => _ubahStatus(index, 'Disetujui'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text('Setujui'),
            ),
            SizedBox(width: 5),
            ElevatedButton(
              onPressed: () => _ubahStatus(index, 'Ditolak'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text('Tolak'),
            ),
          ],
        ),
      ),
    ]);
  }

  @override
  int get rowCount => _data.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}