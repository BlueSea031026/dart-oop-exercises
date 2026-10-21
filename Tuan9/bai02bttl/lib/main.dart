import 'package:flutter/material.dart';
import 'package:bai02bttl/views/sinh_vien_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bài 2 - Quản lý sinh viên',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 135, 200, 230)),
      ),
      debugShowCheckedModeBanner: false,
      home: const SinhVienScreen(),
    );
  }
}
