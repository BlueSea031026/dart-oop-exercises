import 'dart:io';
import '../lib/phong_tro.dart';

void main() {
  List<PhongTro> danhSach = [];

  try {
    List<String> lines = File('phongthue.txt').readAsLinesSync();
    for (String line in lines) {
      if (line.trim().isEmpty) continue;
      
      List<String> parts = line.split('#');
      String maSo = parts[0];
      
      if (maSo.startsWith('A')) {
        PhongLoaiA pA = PhongLoaiA();
        pA.maSo = parts[0];
        pA.soNguoi = int.parse(parts[1]);
        pA.soDien = double.parse(parts[2]);
        pA.soNuoc = double.parse(parts[3]);
        pA.soNguoiThan = int.parse(parts[4]);
        danhSach.add(pA);
      } else if (maSo.startsWith('B')) {
        PhongLoaiB pB = PhongLoaiB();
        pB.maSo = parts[0];
        pB.soNguoi = int.parse(parts[1]);
        pB.soDien = double.parse(parts[2]);
        pB.soNuoc = double.parse(parts[3]);
        pB.giatUi = double.parse(parts[4]);
        pB.soMay = int.parse(parts[5]);
        danhSach.add(pB);
      }
    }
  } catch (e) {
    print(e);
    return;
  }

  print("--- DANH SÁCH TẤT CẢ PHÒNG THUÊ ---");
  for (var phong in danhSach) {
    print(phong.toString());
  }

  print("\n--- PHÒNG CÓ SỐ NGƯỜI THUÊ LỚN HƠN 2 ---");
  for (var phong in danhSach) {
    if (phong.soNguoi > 2) {
      print(phong.toString());
    }
  }

  double tongTien = 0;
  for (var phong in danhSach) {
    tongTien += phong.tinhTien();
  }
  print("\n--- TỔNG TIỀN THU ĐƯỢC: $tongTien ---");

  danhSach.sort((a, b) => b.soDien.compareTo(a.soDien));
  print("\n--- SAU KHI SẮP XẾP GIẢM DẦN THEO SỐ ĐIỆN ---");
  for (var phong in danhSach) {
    print(phong.toString());
  }

  print("\n--- DANH SÁCH PHÒNG LOẠI A ---");
  for (var phong in danhSach) {
    if (phong is PhongLoaiA) {
      print(phong.toString());
    }
  }
}