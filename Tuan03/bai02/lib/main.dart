import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thông tin đề tài đồ án',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ProjectTopicInfoScreen(),
    );
  }
}

//WIDGET DÙNG CHUNG: DÒNG THÔNG TIN 
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

//  MÀN HÌNH THÔNG TIN ĐỀ TÀI ĐỒ ÁN/KHÓA LUẬN 
class ProjectTopicInfoScreen extends StatelessWidget {
  const ProjectTopicInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.home),
        title: const Text('Thông tin đề tài'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.blue[100],
                child: const Icon(
                  Icons.assignment,
                  size: 60,
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Xây dựng ứng dụng quản lý cửa hàng điện máy',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Divider(indent: 24, endIndent: 24),
            const InfoLine(label: 'Mã đề tài', value: 'DT2026-001'),
            const InfoLine(
              label: 'Số lượng SV tối đa',
              value: '3 sinh viên',
              color: Colors.orange,
            ),
            const InfoLine(
              label: 'Chuyên ngành',
              value: 'Công nghệ thông tin',
              color: Colors.green,
            ),
            const InfoLine(
              label: 'Giảng viên hướng dẫn',
              value: 'ThS. Trần Thị A',
              color: Colors.blue,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 6,
                horizontal: 24,
              ),
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                  children: [
                    TextSpan(text: 'Yêu cầu đề tài: \n'),
                    TextSpan(
                      text:
                          'Sinh viên nắm vững kiến thức lập trình di động '
                          '(Flutter), cơ sở dữ liệu, có khả năng phân tích '
                          'thiết kế hệ thống thông tin và làm việc nhóm tốt.',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  
                },
                child: const Text('Trở về'),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}