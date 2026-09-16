import 'package:flutter/material.dart';

void main() {
  runApp(const AppKhamBenh());
}

class AppKhamBenh extends StatelessWidget {
  const AppKhamBenh({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Khám bệnh online',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, fontFamily: 'Roboto'),
      home: const ManHinhChinh(),
    );
  }
}

class ManHinhChinh extends StatelessWidget {
  const ManHinhChinh({super.key});

  static const Color _tim = Color(0xFF7B5EA7);
  static const Color _nenTim = Color(0xFFEDE6F5);
  static const Color _hong = Color(0xFFF3B6D0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F1FA),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const SizedBox(height: 12),

            // Lời chào, nút hồ sơ
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Hello,',
                        style: TextStyle(fontSize: 15, color: Colors.black54)),
                    Text('Mitch Koko',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2A2A2A))),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _nenTim,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.person, color: _tim),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Thẻ
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _hong,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(
                    width: 90,
                    height: 110,
                    decoration: BoxDecoration(
                      color: const Color(0xFFB89BE0),
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('How do you feel?',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF3A2A4A))),
                        const SizedBox(height: 6),
                        const Text('Fill out your medical card\nright now',
                            style: TextStyle(fontSize: 12, color: Color(0xFF5A4A6A))),
                        const SizedBox(height: 14),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _tim,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Get Started'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Thanh tìm kiếm
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: _nenTim,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: const [
                  Icon(Icons.search, color: Colors.black45),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'How can we help you?',
                        hintStyle: TextStyle(color: Colors.black45),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Nhóm chuyên khoa
            SizedBox(
              height: 64,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  _ChipChuyenKhoa(icon: Icons.medical_services_outlined, ten: 'Dentist'),
                  _ChipChuyenKhoa(icon: Icons.people_outline, ten: 'Surgeon'),
                  _ChipChuyenKhoa(icon: Icons.local_hospital_outlined, ten: 'Clinic'),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Tiêu đề
            Row(
              children: const [
                Text('Doctor list',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2A2A2A))),
                Spacer(),
                Text('See all', style: TextStyle(color: _tim, fontSize: 13)),
              ],
            ),

            const SizedBox(height: 14),

            // Hai thẻ bác sĩ
            Row(
              children: const [
                Expanded(
                  child: _TheBacSi(
                    icon: Icons.man,
                    diem: '4.4',
                    ten: 'Dr. Mitch Koko',
                    chuyenMon: 'Psychologist 7 y.e.',
                  ),
                ),
                SizedBox(width: 14),
                Expanded(
                  child: _TheBacSi(
                    icon: Icons.woman,
                    diem: '5.0',
                    ten: 'Dr. Steve Jobs',
                    chuyenMon: 'Surgeon 7 y.e.',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _ChipChuyenKhoa extends StatelessWidget {
  final IconData icon;
  final String ten;

  const _ChipChuyenKhoa({required this.icon, required this.ten});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: const Color(0xFFEDE6F5),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF7B5EA7), size: 22),
          const SizedBox(width: 8),
          Text(ten,
              style: const TextStyle(fontSize: 14, color: Color(0xFF3A2A4A))),
        ],
      ),
    );
  }
}

class _TheBacSi extends StatelessWidget {
  final IconData icon;
  final String diem;
  final String ten;
  final String chuyenMon;

  const _TheBacSi({
    required this.icon,
    required this.diem,
    required this.ten,
    required this.chuyenMon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFCDBBE6),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 34,
            backgroundColor: Colors.white,
            child: Icon(icon, size: 40, color: const Color(0xFF7B5EA7)),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 16),
              const SizedBox(width: 4),
              Text(diem,
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 6),
          Text(ten,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2A2A2A))),
          const SizedBox(height: 2),
          Text(chuyenMon,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Color(0xFF5A4A6A))),
        ],
      ),
    );
  }
}