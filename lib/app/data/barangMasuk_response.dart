class BarangMasukResponse {
  final String message;
  final List<Data> data;

  BarangMasukResponse({required this.message, required this.data});

  factory BarangMasukResponse.fromJson(Map<String, dynamic> json) {
    return BarangMasukResponse(
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
  final String nama;
  final String kodeBarang;
  final int idKategori;
  final String pemasok;
  final int jumlah;
  final String hargaBeli;
  final String tanggalMasuk;
  final String? faktur;
  final String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Kategori kategori;

  Data({
    required this.id,
    required this.nama,
    required this.kodeBarang,
    required this.idKategori,
    required this.pemasok,
    required this.jumlah,
    required this.hargaBeli,
    required this.tanggalMasuk,
    this.faktur,
    required this.status,
    this.createdAt,
    this.updatedAt,
    required this.kategori,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      nama: json['nama'],
      kodeBarang: json['kode_barang'],
      idKategori: json['id_kategori'],
      pemasok: json['pemasok'],
      jumlah: json['jumlah'],
      hargaBeli: json['harga_beli'],
      tanggalMasuk: json['tanggal_masuk'],
      faktur: json['faktur'],
      status: json['status'],
      createdAt: json['created_at'] != null ? DateTime.tryParse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.tryParse(json['updated_at']) : null,
      kategori: Kategori.fromJson(json['kategori']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'kode_barang': kodeBarang,
      'id_kategori': idKategori,
      'pemasok': pemasok,
      'jumlah': jumlah,
      'harga_beli': hargaBeli,
      'tanggal_masuk': tanggalMasuk,
      'faktur': faktur,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'kategori': kategori.toJson(),
    };
  }
}

class Kategori {
  final int id;
  final String nama;

  Kategori({required this.id, required this.nama});

  factory Kategori.fromJson(Map<String, dynamic> json) {
    return Kategori(
      id: json['id'],
      nama: json['nama'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
    };
  }
}
