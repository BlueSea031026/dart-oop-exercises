abstract class PhongTro {
  String _maSo = '';
  int _soNguoi = 0;
  double _soDien = 0;
  double _soNuoc = 0;

  PhongTro() {
    _maSo = "PT000";
    _soNguoi = 0;
    _soDien = 0;
    _soNuoc = 0;
  }

  String get maSo => _maSo;
  set maSo(String value) => _maSo = value;

  int get soNguoi => _soNguoi;
  set soNguoi(int value) => _soNguoi = value;

  double get soDien => _soDien;
  set soDien(double value) => _soDien = value;

  double get soNuoc => _soNuoc;
  set soNuoc(double value) => _soNuoc = value;

  double tinhTien();

  @override
  String toString() {
    return "$_maSo | $_soNguoi | $_soDien | $_soNuoc";
  }
}

class PhongLoaiA extends PhongTro {
  int _soNguoiThan = 0;

  PhongLoaiA() : super() {
    _soNguoiThan = 0;
  }

  int get soNguoiThan => _soNguoiThan;
  set soNguoiThan(int value) => _soNguoiThan = value;

  @override
  double tinhTien() {
    return 1400 + (2 * _soDien) + (8 * _soNuoc) + (50 * _soNguoiThan);
  }

  @override
  String toString() {
    return super.toString() + " | $_soNguoiThan | ${tinhTien()}";
  }
}

class PhongLoaiB extends PhongTro {
  double _giatUi = 0;
  int _soMay = 0;

  PhongLoaiB() : super() {
    _giatUi = 0;
    _soMay = 0;
  }

  double get giatUi => _giatUi;
  set giatUi(double value) => _giatUi = value;

  int get soMay => _soMay;
  set soMay(int value) => _soMay = value;

  @override
  double tinhTien() {
    return 2000 + (2 * _soDien) + (8 * _soNuoc) + (_giatUi * 5) + (_soMay * 100);
  }

  @override
  String toString() {
    return super.toString() + " | $_giatUi | $_soMay | ${tinhTien()}";
  }
}