import 'package:flutter/material.dart';

class app extends StatelessWidget {
  const app({super.key});

  Widget _neumorphicIcon(
    IconData icon, {
    double size = 28,
    Color color = const Color(0xFF4A5568),
    Offset highlightOffset = const Offset(-1, -1),
  }) {
    return Stack(
      children: [
        Positioned(
          left: highlightOffset.dx,
          top: highlightOffset.dy,
          child: Icon(icon, size: size, color: Colors.white.withOpacity(0.85)),
        ),
        Icon(icon, size: size, color: color),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Color bg = const Color(0xFFE8ECEF);
    Color lightShadow = Colors.white.withOpacity(0.9);
    Color darkShadow = const Color(0xFFA6B4C9).withOpacity(0.7);

    return SafeArea(
      child: Scaffold(
        backgroundColor: bg,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Center(
            child: Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: lightShadow,
                    offset: const Offset(-4, -4),
                    blurRadius: 8,
                  ),
                  BoxShadow(
                    color: darkShadow,
                    offset: const Offset(4, 4),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Color(0xFF5E6E82),
                size: 22,
              ),
            ),
          ),
          title: const Text(
            'P L A Y L I S T',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Color(0xFF63738A),
            ),
          ),
          centerTitle: true,
          actions: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(right: 16),
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: lightShadow,
                      offset: const Offset(-4, -4),
                      blurRadius: 8,
                    ),
                    BoxShadow(
                      color: darkShadow,
                      offset: const Offset(4, 4),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.menu,
                  color: Color(0xFF5E6E82),
                  size: 22,
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: lightShadow,
                      offset: const Offset(-10, -10),
                      blurRadius: 18,
                    ),
                    BoxShadow(
                      color: darkShadow,
                      offset: const Offset(10, 10),
                      blurRadius: 18,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(22),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Image.asset(
                          'assets/images/album.jpg',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: const Color(0xFFDDE3EA),
                              child: const Icon(
                                Icons.music_note,
                                size: 48,
                                color: Color(0xFF8A98A8),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Kota The Friend',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF8A98A8),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Birdie',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF2C353F),
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.favorite,
                          color: Color(0xFFE64234),
                          size: 30,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // ===== Từ đây trở xuống là phần chỉnh theo ảnh mẫu =====
              const SizedBox(height: 26),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '0:00',
                      style: TextStyle(
                        color: Color(0xFF7A8797),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    _neumorphicIcon(
                      Icons.shuffle,
                      size: 20,
                      color: const Color(0xFF5E6E82),
                    ),
                    _neumorphicIcon(
                      Icons.repeat,
                      size: 20,
                      color: const Color(0xFF5E6E82),
                    ),
                    const Text(
                      '4:22',
                      style: TextStyle(
                        color: Color(0xFF7A8797),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              Container(
                height: 14,
                width: double.infinity,
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: lightShadow,
                      offset: const Offset(-5, -5),
                      blurRadius: 10,
                    ),
                    BoxShadow(
                      color: darkShadow,
                      offset: const Offset(5, 5),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: FractionallySizedBox(
                    widthFactor: 0.62,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF4CAF50),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: bg,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: lightShadow,
                          offset: const Offset(-6, -6),
                          blurRadius: 12,
                        ),
                        BoxShadow(
                          color: darkShadow,
                          offset: const Offset(6, 6),
                          blurRadius: 12,
                        ),
                      ],
                    ),
                    child: _neumorphicIcon(
                      Icons.skip_previous_rounded,
                      size: 30,
                    ),
                  ),
                  Container(
                    width: 96,
                    height: 80,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: bg,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: lightShadow,
                          offset: const Offset(-6, -6),
                          blurRadius: 12,
                        ),
                        BoxShadow(
                          color: darkShadow,
                          offset: const Offset(6, 6),
                          blurRadius: 12,
                        ),
                      ],
                    ),
                    child: _neumorphicIcon(
                      Icons.play_arrow_rounded,
                      size: 40,
                      color: const Color(0xFF2C353F),
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 80,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: bg,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: lightShadow,
                          offset: const Offset(-6, -6),
                          blurRadius: 12,
                        ),
                        BoxShadow(
                          color: darkShadow,
                          offset: const Offset(6, 6),
                          blurRadius: 12,
                        ),
                      ],
                    ),
                    child: _neumorphicIcon(
                      Icons.skip_next_rounded,
                      size: 30,
                      highlightOffset: const Offset(2, 2),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
