import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thông tin nhóm',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const GroupInfoScreen(),
    );
  }
}

//  MODEL THÀNH VIÊN 
class Member {
  final String mssv;
  final String name;
  final String role; // 'Nhóm trưởng' hoặc 'Thành viên'

  const Member({required this.mssv, required this.name, required this.role});
}

//  WIDGET DÙNG CHUNG: DÒNG THÔNG TIN 
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

//  THẺ HIỂN THỊ 1 THÀNH VIÊN 
class MemberCard extends StatelessWidget {
  final Member member;

  const MemberCard({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    final bool isLeader = member.role == 'Nhóm trưởng';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: isLeader ? Colors.orange[100] : Colors.blue[50],
              child: Icon(
                isLeader ? Icons.star : Icons.person,
                color: isLeader ? Colors.orange : Colors.blue,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    member.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'MSSV: ${member.mssv}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: isLeader ? Colors.orange[100] : Colors.blue[100],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                member.role,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isLeader ? Colors.orange[900] : Colors.blue[900],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//  MÀN HÌNH THÔNG TIN NHÓM 
class GroupInfoScreen extends StatelessWidget {
  const GroupInfoScreen({super.key});

  // Dữ liệu mẫu - thay bằng thông tin nhóm thật
  final List<Member> members = const [
    Member(mssv: '2001221234', name: 'Nguyễn Văn A', role: 'Nhóm trưởng'),
    Member(mssv: '2001221235', name: 'Trần Thị B', role: 'Thành viên'),
    Member(mssv: '2001221236', name: 'Lê Văn C', role: 'Thành viên'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.home),
        title: const Text('Thông tin nhóm'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Center(
              child: CircleAvatar(
                radius: 55,
                backgroundColor: Colors.purple[50],
                child: const Icon(
                  Icons.groups,
                  size: 55,
                  color: Colors.purple,
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Nhóm 7',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
            ),
            const SizedBox(height: 4),
            const InfoLine(label: 'Mã nhóm', value: 'N07-CNTT2026'),
            InfoLine(
              label: 'Số lượng thành viên',
              value: '${members.length} thành viên',
              color: Colors.orange,
            ),
            const SizedBox(height: 8),
            const Divider(indent: 24, endIndent: 24),
            const Padding(
              padding: EdgeInsets.only(left: 24, top: 8, bottom: 4),
              child: Text(
                'Danh sách thành viên',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
            // DANH SÁCH 3 THÀNH VIÊN 
            ...members.map((m) => MemberCard(member: m)),
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
                onPressed: () {},
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