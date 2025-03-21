class BarangResponse {
  final String message;
  final List<BarangData> data;

  BarangResponse({required this.message, required this.data});

  factory BarangResponse.fromJson(Map<String, dynamic> json) {
    return BarangResponse(
      message: json['message'],
      data: (json['data'] as List)
          .map((item) => BarangData.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}

class BarangData {
  final int id;
  final int idKategori;
  final String namaBarang;
  final int hargaBeli;
  final int hargaJual;
  final int stok;
  final String? kategoriNama;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  BarangData({
    required this.id,
    required this.idKategori,
    required this.namaBarang,
    required this.hargaBeli,
    required this.hargaJual,
    required this.stok,
    this.kategoriNama,
    this.createdAt,
    this.updatedAt,
  });

  factory BarangData.fromJson(Map<String, dynamic> json) {
    return BarangData(
      id: json['id'],
      idKategori: json['id_kategori'],
      namaBarang: json['nama_barang'],
      hargaBeli: json['harga_beli'],
      hargaJual: json['harga_jual'],
      stok: json['stok'],
      kategoriNama: json['kategori'] != null ? json['kategori']['nama'] : null,
      createdAt:
          json['created_at'] != null ? DateTime.tryParse(json['created_at']) : null,
      updatedAt:
          json['updated_at'] != null ? DateTime.tryParse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_kategori': idKategori,
      'nama_barang': namaBarang,
      'harga_beli': hargaBeli,
      'harga_jual': hargaJual,
      'stok': stok,
      'kategori_nama': kategoriNama,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
