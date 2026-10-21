
class ChiTieu {
  final int? id;
  final String noiDung;
  final double soTien;
  final String ghiChu;
  final DateTime ngayTao;

  ChiTieu({
    this.id,
    required this.noiDung,
    required this.soTien,
    this.ghiChu = '',
    DateTime? ngayTao,
  }) : ngayTao = ngayTao ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'noiDung': noiDung,
      'soTien': soTien,
      'ghiChu': ghiChu,
      'ngayTao': ngayTao.toIso8601String(), 
    };
  }

  factory ChiTieu.fromMap(Map<String, dynamic> map) {
    return ChiTieu(
      id: map['id'] as int?,
      noiDung: map['noiDung'] ?? '',
      soTien: (map['soTien'] as num).toDouble(),
      ghiChu: map['ghiChu'] ?? '',
      ngayTao: DateTime.parse(map['ngayTao']),
    );
  }
}
