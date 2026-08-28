import 'dart:io';
import 'hoa_don.dart';

class QuanLyHoaDon {
  List<HoaDon> _danhSach = [];

  void nhapDanhSach() {
    stdout.write("Nhập số lượng hóa đơn cần thêm: ");
    int n = int.tryParse(stdin.readLineSync() ?? "") ?? 0;

    for (int i = 0; i < n; i++) {
      print("\nChọn loại khách hàng (1: Cá nhân, 2: Đại lý, 3: Công ty): ");
      String choice = stdin.readLineSync() ?? "";
      HoaDon? hd;

      switch (choice) {
        case '1':
          hd = KhachHangCaNhan();
          break;
        case '2':
          hd = DaiLyCap1();
          break;
        case '3':
          hd = KhachHangCongTy();
          break;
        default:
          print("Lựa chọn không hợp lệ!");
          i--;
          continue;
      }
      
      hd.nhap();
      _danhSach.add(hd);
    }
  }

  void xuatDanhSach() {
    for (var hd in _danhSach) {
      hd.xuat();
      print("-----------------------");
    }
  }

  double tinhTongThanhTien() {
    return _danhSach.fold(0, (sum, hd) => sum + hd.tinhThanhTien());
  }

  double tinhTongTroGia() {
    return _danhSach.fold(0, (sum, hd) => sum + hd.tinhTroGia());
  }

  void khachHangMuaNhieuNhat() {
    if (_danhSach.isEmpty) return;
    
    int maxSoLuong = _danhSach.map((e) => e.soLuong).reduce((a, b) => a > b ? a : b);
    print("\n--- KHÁCH HÀNG MUA NHIỀU NHẤT ($maxSoLuong sản phẩm) ---");
    for (var hd in _danhSach) {
      if (hd.soLuong == maxSoLuong) {
        hd.xuat();
      }
    }
  }

  double tongChietKhauCongTy() {
    return _danhSach
        .whereType<KhachHangCongTy>()
        .fold(0, (sum, hd) => sum + hd.tinhChietKhau());
  }

  void sapXepHoaDon() {
    _danhSach.sort((a, b) {
      int cmp = a.soLuong.compareTo(b.soLuong);
      if (cmp == 0) {
        return b.tinhThanhTien().compareTo(a.tinhThanhTien());
      }
      return cmp;
    });
  }

  void timKiemKhachHang(String ma) {
    bool found = false;
    for (var hd in _danhSach) {
      if (hd.maKH == ma) {
        hd.xuat();
        found = true;
      }
    }
    if (!found) {
      print("Khách hàng lạ");
    }
  }
}