import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thông tin sản phẩm',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ProductInfoScreen(),
    );
  }
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

//  MÀN HÌNH THÔNG TIN SẢN PHẨM 
class ProductInfoScreen extends StatefulWidget {
  const ProductInfoScreen({super.key});

  @override
  State<ProductInfoScreen> createState() => _ProductInfoScreenState();
}

class _ProductInfoScreenState extends State<ProductInfoScreen> {
  final PageController _pageController = PageController();
  int _currentImage = 0;

  
  final List<String> _images = const [
    'assets/images/sanpham_1.jpg',
    'assets/images/sanpham_2.jpg',
    'assets/images/sanpham_3.jpg',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.home),
        title: const Text('Thông tin sản phẩm'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            SizedBox(
              height: 260,
              child: PageView.builder(
                controller: _pageController,
                itemCount: _images.length,
                onPageChanged: (index) {
                  setState(() => _currentImage = index);
                },
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        _images[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(
                              Icons.image,
                              size: 80,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_images.length, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentImage == index ? 20 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentImage == index
                          ? Colors.blue
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Bàn phím cơ AKKO 3068B Plus',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Divider(indent: 24, endIndent: 24),
            const InfoLine(label: 'Mã sản phẩm', value: 'SP2026-045'),
            const InfoLine(
              label: 'Nhà sản xuất',
              value: 'AKKO',
              color: Colors.blue,
            ),
            const InfoLine(
              label: 'Giá bán',
              value: '1.290.000 đ',
              color: Colors.deepOrange,
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
                    color: Colors.green,
                  ),
                  children: [
                    TextSpan(text: 'Mô tả sản phẩm: \n'),
                    TextSpan(
                      text:
                          'Bàn phím cơ 68 phím, hotswap switch, kết nối '
                          '3 chế độ (có dây, Bluetooth, 2.4GHz), đèn LED '
                          'RGB, phù hợp cho văn phòng và chơi game.',
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