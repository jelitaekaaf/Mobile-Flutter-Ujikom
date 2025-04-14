class BarangKeluarResponse {
  final String message;
  final List<Data> data;

  BarangKeluarResponse({required this.message, required this.data});

  factory BarangKeluarResponse.fromJson(Map<String, dynamic> json) {
    return BarangKeluarResponse(
      message: json['message'],
      data: (json['data'] as List).map((item) => Data.fromJson(item)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}

class Data {
  final int id;
  final String kodeBarang;
  final int idKategori;
  final String nama;
  final int jumlah;
  final String alasanPengeluaran;
  final String tujuanPemakaian;
  final String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Data({
    required this.id,
    required this.kodeBarang,
    required this.idKategori,
    required this.nama,
    required this.jumlah,
    required this.alasanPengeluaran,
    required this.tujuanPemakaian,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      kodeBarang: json['kode_barang'],
      idKategori: json['id_kategori'],
      nama: json['nama'],
      jumlah: json['jumlah'],
      alasanPengeluaran: json['alasan_pengeluaran'],
      tujuanPemakaian: json['tujuan_pemakaian'],
      status: json['status'],
      createdAt: json['created_at'] != null ? DateTime.tryParse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.tryParse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'kode_barang': kodeBarang,
      'id_kategori': idKategori,
      'nama': nama,
      'jumlah': jumlah,
      'alasan_pengeluaran': alasanPengeluaran,
      'tujuan_pemakaian': tujuanPemakaian,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
