abstract class MonHoc {
  String _maMH = '';
  String _tenMH = '';
  int _soTC = 0;

  MonHoc() {
    _maMH = '';
    _tenMH = '';
    _soTC = 0;
  }

  String get maMH => _maMH;
  set maMH(String value) => _maMH = value;

  String get tenMH => _tenMH;
  set tenMH(String value) => _tenMH = value;

  int get soTC => _soTC;
  set soTC(int value) => _soTC = value;

  double tinhDTB();

  String quyDoiDiemChu() {
    double dtb = tinhDTB();
    if (dtb >= 8.5) return 'A';
    if (dtb >= 7.0) return 'B';
    if (dtb >= 5.5) return 'C';
    if (dtb >= 4.0) return 'D';
    return 'F';
  }

  @override
  String toString() {
    return "$_maMH | $_tenMH | $_soTC TC | ĐTB: ${tinhDTB().toStringAsFixed(2)} | Chữ: ${quyDoiDiemChu()}";
  }
}

class LyThuyet extends MonHoc {
  double _diemTieuLuan = 0;
  double _diemCuoiKy = 0;

  LyThuyet() : super() {
    _diemTieuLuan = 0;
    _diemCuoiKy = 0;
  }

  double get diemTieuLuan => _diemTieuLuan;
  set diemTieuLuan(double value) => _diemTieuLuan = value;

  double get diemCuoiKy => _diemCuoiKy;
  set diemCuoiKy(double value) => _diemCuoiKy = value;

  @override
  double tinhDTB() {
    return (_diemTieuLuan * 0.3) + (_diemCuoiKy * 0.7);
  }
}

class ThucHanh extends MonHoc {
  double _kt1 = 0;
  double _kt2 = 0;
  double _kt3 = 0;

  ThucHanh() : super() {
    _kt1 = 0;
    _kt2 = 0;
    _kt3 = 0;
  }

  double get kt1 => _kt1;
  set kt1(double value) => _kt1 = value;

  double get kt2 => _kt2;
  set kt2(double value) => _kt2 = value;

  double get kt3 => _kt3;
  set kt3(double value) => _kt3 = value;

  @override
  double tinhDTB() {
    return (_kt1 + _kt2 + _kt3) / 3;
  }
}

class DoAn extends MonHoc {
  double _diemGVHD = 0;
  double _diemGVPB = 0;

  DoAn() : super() {
    _diemGVHD = 0;
    _diemGVPB = 0;
  }

  double get diemGVHD => _diemGVHD;
  set diemGVHD(double value) => _diemGVHD = value;

  double get diemGVPB => _diemGVPB;
  set diemGVPB(double value) => _diemGVPB = value;

  @override
  double tinhDTB() {
    return (_diemGVHD + _diemGVPB) / 2;
  }
}