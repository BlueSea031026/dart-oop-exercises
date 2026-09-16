import 'package:flutter/material.dart';

void main() {
  runApp(const AppTamTrang());
}

class AppTamTrang extends StatelessWidget {
  const AppTamTrang({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tình trạng người dùng',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, fontFamily: 'Roboto'),
      home: const ManHinhChinh(),
    );
  }
}


//  MÀN HÌNH CHÍNH

class ManHinhChinh extends StatelessWidget {
  const ManHinhChinh({super.key});

  static const Color _xanh = Color(0xFF2F80F6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F5),

      //THANH ĐIỀU HƯỚNG
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: _xanh,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'Tin nhắn'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Cá nhân'),
        ],
      ),

      body: ListView(
        padding: EdgeInsets.zero,
        children: [

          Container(
            decoration: const BoxDecoration(
              color: _xanh,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Hi, Jared!',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text('23 Jan, 2021',
                            style: TextStyle(color: Colors.white70, fontSize: 13)),
                      ],
                    ),
                    const Spacer(),
                    // Nút chuông
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.notifications_none, color: Colors.white),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                //Thanh tìm kiếm
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.search, color: Colors.white70),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            hintText: 'Search',
                            hintStyle: TextStyle(color: Colors.white70),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 22),

                //Tiêu đề
                Row(
                  children: const [
                    Text('How do you feel?',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                    Spacer(),
                    Icon(Icons.more_horiz, color: Colors.white70),
                  ],
                ),

                const SizedBox(height: 16),

                //emoji tâm trạng
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    _NutTamTrang(emoji: '😣', nhan: 'Bad'),
                    _NutTamTrang(emoji: '🙂', nhan: 'Fine'),
                    _NutTamTrang(emoji: '😌', nhan: 'Well'),
                    _NutTamTrang(emoji: '🤩', nhan: 'Excellent'),
                  ],
                ),
              ],
            ),
          ),

          //DANH SÁCH BÀI TẬP
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
            child: Row(
              children: const [
                Text('Exercises',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2A2A2A))),
                Spacer(),
                Icon(Icons.more_horiz, color: Colors.grey),
              ],
            ),
          ),

          //thẻ bài tập
          const _TheBaiTap(
            icon: Icons.favorite,
            mauIcon: Color(0xFFF59E0B),
            tenBai: 'Speaking Skillz',
            soLuong: '16 Exercises',
          ),
          const _TheBaiTap(
            icon: Icons.person,
            mauIcon: Color(0xFF22C55E),
            tenBai: 'Reading Skills',
            soLuong: '8 Exercises',
          ),
          const _TheBaiTap(
            icon: Icons.star,
            mauIcon: Color(0xFFE91E63),
            tenBai: 'Writing Skills',
            soLuong: '20 Exercises',
          ),

          const SizedBox(height: 12),
        ],
      ),
    );
  }
}


//Nút tâm trạng
class _NutTamTrang extends StatelessWidget {
  final String emoji;
  final String nhan;

  const _NutTamTrang({required this.emoji, required this.nhan});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
 
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.18),
            borderRadius: BorderRadius.circular(16),
          ),
          alignment: Alignment.center,
          child: Text(emoji, style: const TextStyle(fontSize: 28)),
        ),
        const SizedBox(height: 8),
        Text(nhan, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}


class _TheBaiTap extends StatelessWidget {
  final IconData icon;
  final Color mauIcon;
  final String tenBai;
  final String soLuong;

  const _TheBaiTap({
    required this.icon,
    required this.mauIcon,
    required this.tenBai,
    required this.soLuong,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 6, 20, 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: mauIcon,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 14),


          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tenBai,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2A2A2A))),
                const SizedBox(height: 4),
                Text(soLuong,
                    style: const TextStyle(fontSize: 13, color: Colors.grey)),
              ],
            ),
          ),

          const Icon(Icons.more_horiz, color: Colors.grey),
        ],
      ),
    );
  }
}