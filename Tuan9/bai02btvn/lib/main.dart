import 'package:flutter/material.dart';
import 'package:bai02btvn/views/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Đăng nhập',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 135, 200, 230)),
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}
