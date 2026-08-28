import 'dart:io';

abstract class HoaDon {
  String _maKH = '';
  String _tenKH = '';
  int _soLuong = 0;
  double _giaBan = 0;

  HoaDon();

  HoaDon.full(this._maKH, this._tenKH, this._soLuong, this._giaBan);

  String get maKH => _maKH;
  set maKH(String value) {
    if (RegExp(r'^KH\d{4}$').hasMatch(value)) {
      _maKH = value;
    } else {
      print("Lỗi: Mã khách hàng phải có định dạng KHXXXX.");
    }
  }

  String get tenKH => _tenKH;
  set tenKH(String value) {
    if (value.trim().isNotEmpty) {
      _tenKH = value;
    } else {
      print("Lỗi: Tên khách hàng không được để trống.");
    }
  }

  int get soLuong => _soLuong;
  set soLuong(int value) {
    if (value > 0) {
      _soLuong = value;
    } else {
      print("Lỗi: Số lượng phải > 0.");
    }
  }

  double get giaBan => _giaBan;
  set giaBan(double value) {
    if (value > 0) {
      _giaBan = value;
    } else {
      print("Lỗi: Giá bán phải > 0.");
    }
  }

  double tinhChietKhau();
  double tinhTroGia();

  double tinhVAT() {
    return 0.1 * _soLuong * _giaBan;
  }

  double tinhThanhTien() {
    return (_soLuong * _giaBan) - tinhChietKhau() + tinhVAT();
  }

  void nhap() {
    do {
      stdout.write("Nhập mã KH (KHXXXX): ");
      maKH = stdin.readLineSync() ?? "";
    } while (_maKH.isEmpty);

    do {
      stdout.write("Nhập tên KH: ");
      tenKH = stdin.readLineSync() ?? "";
    } while (_tenKH.isEmpty);

    do {
      stdout.write("Nhập số lượng: ");
      soLuong = int.tryParse(stdin.readLineSync() ?? "") ?? 0;
    } while (_soLuong <= 0);

    do {
      stdout.write("Nhập giá bán: ");
      giaBan = double.tryParse(stdin.readLineSync() ?? "") ?? 0;
    } while (_giaBan <= 0);
  }

  void xuat() {
    print("Mã KH: $_maKH | Tên KH: $_tenKH | Số lượng: $_soLuong | Giá bán: $_giaBan");
    print("Chiết khấu: ${tinhChietKhau()} | Trợ giá: ${tinhTroGia()} | Thành tiền: ${tinhThanhTien()}");
  }
}

class KhachHangCaNhan extends HoaDon {
  double _khoangCach = 0;

  KhachHangCaNhan() : super();

  KhachHangCaNhan.full(String maKH, String tenKH, int soLuong, double giaBan, this._khoangCach)
      : super.full(maKH, tenKH, soLuong, giaBan);

  double get khoangCach => _khoangCach;
  set khoangCach(double value) => _khoangCach = value >= 0 ? value : 0;

  @override
  void nhap() {
    super.nhap();
    stdout.write("Nhập khoảng cách giao hàng (km): ");
    khoangCach = double.tryParse(stdin.readLineSync() ?? "") ?? 0;
  }

  @override
  double tinhChietKhau() {
    double ck = 0;
    if (_soLuong >= 3) {
      ck += 0.05 * _giaBan * _soLuong;
    }
    if (_khoangCach < 10) {
      ck += 50000 * _soLuong;
    }
    return ck;
  }

  @override
  double tinhTroGia() {
    double troGia = 0.02 * _giaBan * _soLuong;
    if (_soLuong > 2) {
      troGia += 100000;
    }
    return troGia;
  }

  @override
  void xuat() {
    print("--- HÓA ĐƠN CÁ NHÂN ---");
    super.xuat();
    print("Khoảng cách: $_khoangCach km");
  }
}

class DaiLyCap1 extends HoaDon {
  int _thoiGianHopTac = 0;

  DaiLyCap1() : super();

  DaiLyCap1.full(String maKH, String tenKH, int soLuong, double giaBan, this._thoiGianHopTac)
      : super.full(maKH, tenKH, soLuong, giaBan);

  int get thoiGianHopTac => _thoiGianHopTac;
  set thoiGianHopTac(int value) => _thoiGianHopTac = value >= 0 ? value : 0;

  @override
  void nhap() {
    super.nhap();
    stdout.write("Nhập thời gian hợp tác (năm): ");
    thoiGianHopTac = int.tryParse(stdin.readLineSync() ?? "") ?? 0;
  }

  @override
  double tinhChietKhau() {
    double tyLe = 0.30;
    if (_thoiGianHopTac > 5) {
      tyLe += (_thoiGianHopTac - 5) * 0.01;
    }
    if (tyLe > 0.35) tyLe = 0.35;
    return tyLe * _giaBan * _soLuong;
  }

  @override
  double tinhTroGia() {
    return 0;
  }

  @override
  void xuat() {
    print("--- HÓA ĐƠN ĐẠI LÝ CẤP 1 ---");
    super.xuat();
    print("Thời gian hợp tác: $_thoiGianHopTac năm");
  }
}

class KhachHangCongTy extends HoaDon {
  int _soNhanVien = 0;

  KhachHangCongTy() : super();

  KhachHangCongTy.full(String maKH, String tenKH, int soLuong, double giaBan, this._soNhanVien)
      : super.full(maKH, tenKH, soLuong, giaBan);

  int get soNhanVien => _soNhanVien;
  set soNhanVien(int value) => _soNhanVien = value > 0 ? value : 0;

  @override
  void nhap() {
    super.nhap();
    stdout.write("Nhập số lượng nhân viên: ");
    soNhanVien = int.tryParse(stdin.readLineSync() ?? "") ?? 0;
  }

  @override
  double tinhChietKhau() {
    if (_soNhanVien > 5000) {
      return 0.07 * _giaBan * _soLuong;
    } else if (_soNhanVien > 1000) {
      return 0.05 * _giaBan * _soLuong;
    }
    return 0;
  }

  @override
  double tinhTroGia() {
    return 120000.0 * _soLuong;
  }

  @override
  void xuat() {
    print("--- HÓA ĐƠN CÔNG TY ---");
    super.xuat();
    print("Số nhân viên: $_soNhanVien");
  }
}