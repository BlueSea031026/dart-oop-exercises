import 'package:flutter/material.dart';
import 'package:bai01btvn/views/chi_tieu_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quản lý chi tiêu',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 135, 200, 230)),
      ),
      debugShowCheckedModeBanner: false,
      home: const ChiTieuScreen(),
    );
  }
}
