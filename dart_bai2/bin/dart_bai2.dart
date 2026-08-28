import 'dart:io';
import '../lib/mon_hoc.dart';

void main() {
  List<MonHoc> danhSach = [];

  try {
    List<String> lines = File('monhoc.txt').readAsLinesSync();
    for (String line in lines) {
      if (line.trim().isEmpty) continue;
      
      List<String> parts = line.split('#');
      String loai = parts[0];
      
      if (loai == 'LT') {
        LyThuyet lt = LyThuyet();
        lt.maMH = parts[1];
        lt.tenMH = parts[2];
        lt.soTC = int.parse(parts[3]);
        lt.diemTieuLuan = double.parse(parts[4]);
        lt.diemCuoiKy = double.parse(parts[5]);
        danhSach.add(lt);
      } else if (loai == 'TH') {
        ThucHanh th = ThucHanh();
        th.maMH = parts[1];
        th.tenMH = parts[2];
        th.soTC = int.parse(parts[3]);
        th.kt1 = double.parse(parts[4]);
        th.kt2 = double.parse(parts[5]);
        th.kt3 = double.parse(parts[6]);
        danhSach.add(th);
      } else if (loai == 'DA') {
        DoAn da = DoAn();
        da.maMH = parts[1];
        da.tenMH = parts[2];
        da.soTC = int.parse(parts[3]);
        da.diemGVHD = double.parse(parts[4]);
        da.diemGVPB = double.parse(parts[5]);
        danhSach.add(da);
      }
    }
  } catch (e) {
    print(e);
    return;
  }

  print("--- DANH SÁCH MÔN HỌC ---");
  for (var mh in danhSach) {
    print(mh.toString());
  }

  bool isSortedByName = true;
  for (int i = 0; i < danhSach.length - 1; i++) {
    if (danhSach[i].tenMH.compareTo(danhSach[i + 1].tenMH) > 0) {
      isSortedByName = false;
      break;
    }
  }
  print("\nDanh sách đã sắp xếp tăng dần theo tên chưa? $isSortedByName");

  danhSach.sort((a, b) => a.soTC.compareTo(b.soTC));
  print("\n--- DANH SÁCH TĂNG DẦN THEO TÍN CHỈ ---");
  for (var mh in danhSach) {
    print(mh.toString());
  }

  print("\n--- MÔN HỌC CÓ TÍN CHỈ CAO NHẤT ---");
  if (danhSach.isNotEmpty) {
    int maxTC = danhSach.map((e) => e.soTC).reduce((a, b) => a > b ? a : b);
    for (var mh in danhSach) {
      if (mh.soTC == maxTC) {
        print(mh.toString());
      }
    }
  }

  stdout.write("\nNhập tên môn học cần tìm: ");
  String searchName = stdin.readLineSync() ?? "";
  
  bool found = false;
  for (var mh in danhSach) {
    if (mh.tenMH.toLowerCase().contains(searchName.toLowerCase())) {
      print("Đã tìm thấy: ${mh.toString()}");
      found = true;
      break;
    }
  }

  if (!found && searchName.isNotEmpty) {
    print("Không tìm thấy. Đã thêm môn '$searchName' vào cuối danh sách.");
    LyThuyet mhMoi = LyThuyet();
    mhMoi.maMH = "NEW00";
    mhMoi.tenMH = searchName;
    mhMoi.soTC = 3;
    mhMoi.diemTieuLuan = 0;
    mhMoi.diemCuoiKy = 0;
    danhSach.add(mhMoi);
  }

  if (danhSach.isNotEmpty) {
    double tongTC = danhSach.fold(0, (sum, item) => sum + item.soTC);
    double dtbTC = tongTC / danhSach.length;
    print("\n--- SỐ TÍN CHỈ TRUNG BÌNH: ${dtbTC.toStringAsFixed(2)} ---");
  }
}