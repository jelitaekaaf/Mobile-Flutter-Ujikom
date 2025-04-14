class KeuanganResponse {
  final String message;
  final List<KeuanganData> data;

  KeuanganResponse({required this.message, required this.data});

  factory KeuanganResponse.fromJson(Map<String, dynamic> json) {
    return KeuanganResponse(
      message: json['message'],
      data: (json['data'] as List)
          .map((item) => KeuanganData.fromJson(item))
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

class KeuanganData {
  final int id;
  final String jenis;
  final int jumlah;
  final DateTime tanggal;
  final String keterangan;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  KeuanganData({
    required this.id,
    required this.jenis,
    required this.jumlah,
    required this.tanggal,
    required this.keterangan,
    this.createdAt,
    this.updatedAt,
  });

  factory KeuanganData.fromJson(Map<String, dynamic> json) {
    return KeuanganData(
      id: json['id'],
      jenis: json['jenis'],
      jumlah: json['jumlah'],
      tanggal: DateTime.parse(json['tanggal']),
      keterangan: json['keterangan'],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'jenis': jenis,
      'jumlah': jumlah,
      'tanggal': tanggal.toIso8601String(),
      'keterangan': keterangan,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
