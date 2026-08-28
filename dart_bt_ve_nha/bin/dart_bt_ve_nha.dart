import 'dart:io';
import '../lib/quan_ly_hoa_don.dart';

void main() {
  QuanLyHoaDon qlhd = QuanLyHoaDon();
  bool isRunning = true;

  while (isRunning) {
    print("\n========== QUẢN LÝ HÓA ĐƠN ==========");
    print("1. Nhập danh sách hóa đơn");
    print("2. Xuất danh sách hóa đơn");
    print("3. Tính tổng thành tiền tất cả hóa đơn");
    print("4. Tính tổng tiền trợ giá");
    print("5. Khách hàng mua nhiều nhất");
    print("6. Tổng tiền chiết khấu của khách hàng công ty");
    print("7. Sắp xếp danh sách (SL tăng dần, Thành tiền giảm dần)");
    print("8. Tìm kiếm hóa đơn theo Mã KH");
    print("0. Thoát");
    stdout.write("Chọn chức năng: ");
    
    String choice = stdin.readLineSync() ?? "";

    switch (choice) {
      case '1':
        qlhd.nhapDanhSach();
        break;
      case '2':
        qlhd.xuatDanhSach();
        break;
      case '3':
        print("Tổng thành tiền: ${qlhd.tinhTongThanhTien()}");
        break;
      case '4':
        print("Tổng trợ giá: ${qlhd.tinhTongTroGia()}");
        break;
      case '5':
        qlhd.khachHangMuaNhieuNhat();
        break;
      case '6':
        print("Tổng chiết khấu cho Cty: ${qlhd.tongChietKhauCongTy()}");
        break;
      case '7':
        qlhd.sapXepHoaDon();
        print("Đã sắp xếp xong! Chọn 2 để xem.");
        break;
      case '8':
        stdout.write("Nhập mã khách hàng cần tìm: ");
        String ma = stdin.readLineSync() ?? "";
        qlhd.timKiemKhachHang(ma);
        break;
      case '0':
        isRunning = false;
        break;
      default:
        print("Chức năng không hợp lệ!");
    }
  }
}