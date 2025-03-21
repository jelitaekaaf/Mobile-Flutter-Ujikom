class StokResponse {
  final String message;
  final List<StokData> data;

  StokResponse({required this.message, required this.data});

  factory StokResponse.fromJson(Map<String, dynamic> json) {
    return StokResponse(
      message: json['message'],
      data: (json['data'] as List).map((item) => StokData.fromJson(item)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}

class StokData {
  final int id;
  final int idBarang;
  final int jumlah;
  final String keterangan;
  final DateTime tanggal;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  StokData({
    required this.id,
    required this.idBarang,
    required this.jumlah,
    required this.keterangan,
    required this.tanggal,
    this.createdAt,
    this.updatedAt,
  });

  factory StokData.fromJson(Map<String, dynamic> json) {
    return StokData(
      id: json['id'],
      idBarang: json['id_barang'],
      jumlah: json['jumlah'],
      keterangan: json['keterangan'],
      tanggal: DateTime.parse(json['tanggal']),
      createdAt: json['created_at'] != null ? DateTime.tryParse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.tryParse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_barang': idBarang,
      'jumlah': jumlah,
      'keterangan': keterangan,
      'tanggal': tanggal.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
