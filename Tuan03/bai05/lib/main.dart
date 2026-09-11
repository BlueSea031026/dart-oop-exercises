import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Giới thiệu ngành học',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MajorInfoScreen(),
    );
  }
}

//  WIDGET DÙNG CHUNG: MỤC THÔNG TIN CÓ TIÊU ĐỀ 
class SectionBlock extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final List<String> items;

  const SectionBlock({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 22),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...items.map(
            (text) => Padding(
              padding: const EdgeInsets.only(left: 30, bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('•  ', style: TextStyle(fontSize: 15)),
                  Expanded(
                    child: Text(
                      text,
                      style: const TextStyle(fontSize: 14.5, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//  NỘI DUNG GIỚI THIỆU 1 NGÀNH 
class MajorTab extends StatelessWidget {
  final String name;
  final String shortName;
  final Color themeColor;
  final IconData icon;
  final String intro;
  final List<String> knowledge;
  final List<String> skills;
  final List<String> careers;

  const MajorTab({
    super.key,
    required this.name,
    required this.shortName,
    required this.themeColor,
    required this.icon,
    required this.intro,
    required this.knowledge,
    required this.skills,
    required this.careers,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //  BANNER ĐẦU TRANG 
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [themeColor, themeColor.withValues(alpha: 0.7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Icon(icon, size: 42, color: themeColor),
                ),
                const SizedBox(height: 12),
                Text(
                  shortName,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 15, color: Colors.white70),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          //  GIỚI THIỆU CHUNG 
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              intro,
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 14.5, height: 1.5),
            ),
          ),
          const Divider(height: 32, indent: 20, endIndent: 20),
          //  KIẾN THỨC ĐÀO TẠO 
          SectionBlock(
            title: 'Kiến thức đào tạo',
            icon: Icons.school,
            color: themeColor,
            items: knowledge,
          ),
          // KỸ NĂNG 
          SectionBlock(
            title: 'Kỹ năng trang bị',
            icon: Icons.build_circle,
            color: themeColor,
            items: skills,
          ),
          //  CƠ HỘI NGHỀ NGHIỆP 
          SectionBlock(
            title: 'Cơ hội nghề nghiệp',
            icon: Icons.work,
            color: themeColor,
            items: careers,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// MÀN HÌNH CHÍNH: 2 TAB CNTT / ATTT 
class MajorInfoScreen extends StatelessWidget {
  const MajorInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.home),
          title: const Text('Khoa Công nghệ Thông tin'),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            tabs: [
              Tab(text: 'CNTT'),
              Tab(text: 'ATTT'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // NGÀNH CÔNG NGHỆ THÔNG TIN 
            MajorTab(
              name: 'Công nghệ thông tin',
              shortName: 'CNTT',
              themeColor: Colors.blue,
              icon: Icons.computer,
              intro:
                  'Ngành Công nghệ thông tin đào tạo kỹ sư có khả năng '
                  'thiết kế, xây dựng, vận hành và phát triển các hệ thống '
                  'phần mềm, ứng dụng web, ứng dụng di động và hệ thống '
                  'thông tin phục vụ nhu cầu quản lý, sản xuất, kinh doanh '
                  'của doanh nghiệp trong thời đại số.',
              knowledge: const [
                'Lập trình cơ bản và hướng đối tượng (C/C++, Java, C#)',
                'Cấu trúc dữ liệu và giải thuật',
                'Cơ sở dữ liệu và hệ quản trị CSDL',
                'Lập trình web, lập trình di động (Flutter, Android)',
                'Phân tích thiết kế hệ thống thông tin',
              ],
              skills: const [
                'Tư duy logic, giải quyết vấn đề',
                'Làm việc nhóm, quản lý dự án phần mềm',
                'Tự học công nghệ mới, đọc tài liệu tiếng Anh chuyên ngành',
              ],
              careers: const [
                'Lập trình viên (Developer) Web/Mobile/Desktop',
                'Kỹ sư kiểm thử phần mềm (Tester/QA)',
                'Quản trị cơ sở dữ liệu, quản trị hệ thống',
                'Phân tích nghiệp vụ, thiết kế hệ thống (BA/System Analyst)',
              ],
            ),
            // NGÀNH AN TOÀN THÔNG TIN 
            MajorTab(
              name: 'An toàn thông tin',
              shortName: 'ATTT',
              themeColor: Colors.red,
              icon: Icons.security,
              intro:
                  'Ngành An toàn thông tin đào tạo chuyên gia có khả năng '
                  'bảo vệ hệ thống mạng, dữ liệu và ứng dụng trước các '
                  'nguy cơ tấn công mạng, đảm bảo an toàn, bảo mật thông '
                  'tin cho tổ chức, doanh nghiệp trong bối cảnh chuyển '
                  'đổi số và tội phạm mạng ngày càng gia tăng.',
              knowledge: const [
                'Mạng máy tính và bảo mật mạng',
                'Mật mã học và an toàn dữ liệu',
                'Kiểm thử xâm nhập (Penetration Testing)',
                'Điều tra số (Digital Forensics)',
                'Quản lý rủi ro và an toàn thông tin doanh nghiệp',
              ],
              skills: const [
                'Phân tích, phát hiện lỗ hổng bảo mật',
                'Xử lý sự cố an ninh mạng (Incident Response)',
                'Sử dụng công cụ bảo mật, giám sát hệ thống (SIEM, IDS/IPS)',
              ],
              careers: const [
                'Chuyên viên an ninh mạng (Security Analyst)',
                'Kiểm thử xâm nhập (Pentester)',
                'Chuyên viên điều tra số, ứng cứu sự cố (SOC/CERT)',
                'Quản trị bảo mật hệ thống, tư vấn an toàn thông tin',
              ],
            ),
          ],
        ),
      ),
    );
  }
}