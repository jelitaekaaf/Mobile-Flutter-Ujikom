class KategoriResponse {
  final String message;
  final List<Data> data;

  KategoriResponse({required this.message, required this.data});

  factory KategoriResponse.fromJson(Map<String, dynamic> json) {
    return KategoriResponse(
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
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Data({required this.id, required this.nama, this.createdAt, this.updatedAt});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      nama: json['nama'],
      createdAt: json['created_at'] != null ? DateTime.tryParse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.tryParse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
