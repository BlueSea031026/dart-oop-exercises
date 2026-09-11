import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thông tin Khoa CNTT',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: const HomeScreen(),
    );
  }
}

// MÀN HÌNH CHÍNH
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trang chủ'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.person),
              label: const Text('Xem thông tin Sinh viên'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const StudentInfoScreen()),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.school),
              label: const Text('Xem thông tin Giảng viên'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LecturerInfoScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// WIDGET DÙNG CHUNG: DÒNG THÔNG TIN 
class InfoLine extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final bool bold;

  const InfoLine({
    super.key,
    required this.label,
    required this.value,
    this.color = Colors.red,
    this.bold = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 24),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: 16,
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            color: color,
          ),
          children: [
            TextSpan(text: '$label: '),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}

//  MÀN HÌNH SINH VIÊN 
class StudentInfoScreen extends StatelessWidget {
  const StudentInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () => Navigator.popUntil(context, (r) => r.isFirst),
        ),
        title: const Text('Thông tin sinh viên'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            
            CircleAvatar(
              radius: 70,
              backgroundColor: Colors.grey[300],
              backgroundImage: const AssetImage('assets/images/sinhvien.jpg'),
              onBackgroundImageError: (_, __) {},
              child: const Icon(Icons.person, size: 70, color: Colors.white),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Họ và tên: Nguyễn Chí Hải',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
            ),
            const SizedBox(height: 6),
            const InfoLine(label: 'MSSV', value: '2001240118'),
            const InfoLine(label: 'Lớp', value: '15DHTH04'),
            const InfoLine(label: 'Khóa', value: '15 Đại học'),
            const InfoLine(label: 'Ngành', value: 'Công nghệ thông tin'),
            const InfoLine(
              label: 'Trường',
              value: 'Đại học Công Thương Thành phố Hồ Chí Minh',
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text('Trở về'),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

//  MÀN HÌNH GIẢNG VIÊN 
class LecturerInfoScreen extends StatelessWidget {
  const LecturerInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () => Navigator.popUntil(context, (r) => r.isFirst),
        ),
        title: const Text('Thông tin sinh viên'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            
            CircleAvatar(
              radius: 70,
              backgroundColor: Colors.grey[300],
              backgroundImage: const AssetImage('assets/images/giangvien.jpg'),
              onBackgroundImageError: (_, __) {},
              child: const Icon(Icons.person, size: 70, color: Colors.white),
            ),
            const SizedBox(height: 20),
            const Text(
              'Giảng viên Trần Thị A',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 6),
            const InfoLine(label: 'Khoa', value: 'Công nghệ thông tin'),
            const InfoLine(label: 'Học hàm', value: 'Thạc sỹ'),
            const InfoLine(
              label: 'Chuyên ngành',
              value: 'CNPM',
              color: Colors.green,
            ),
            const InfoLine(
              label: 'Giảng dạy',
              value: 'Nhập môn lập trình, Lập trình windows, Lập trình web...',
              color: Colors.blue,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text('Trở về'),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}