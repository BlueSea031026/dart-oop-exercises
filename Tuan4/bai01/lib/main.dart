import 'package:flutter/material.dart';

void main() {
  runApp(const MayTinhApp());
}

class MayTinhApp extends StatelessWidget {
  const MayTinhApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Máy tính',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, useMaterial3: true),
      home: const ManHinhMayTinh(),
    );
  }
}

//  MÀN HÌNH GIAO DIỆN MÁY TÍNH

class ManHinhMayTinh extends StatelessWidget {
  const ManHinhMayTinh({super.key});

  static const List<List<String>> _banPhim = [
    ['%', 'CE', 'C', '⌫'],
    ['¹/x', 'x²', '²√x', '÷'],
    ['7', '8', '9', '×'],
    ['4', '5', '6', '−'],
    ['1', '2', '3', '+'],
    ['+/−', '0', '.', '='],
  ];

  static const _phepToanVaChucNang = {
    '%',
    'CE',
    'C',
    '⌫',
    '¹/x',
    'x²',
    '²√x',
    '÷',
    '×',
    '−',
    '+',
    '+/−',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF202020),
      //MENU ĐIỀU HƯỚNG
      drawer: const MenuDieuHuong(),
      body: SafeArea(

        child: Builder(
          builder: (context) => Column(
            children: [
              //THANH TIÊU ĐỀ
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.menu, color: Colors.white),
                      onPressed: () =>
                          Scaffold.of(context).openDrawer(),
                    ),
                    const Text(
                      'Standard',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.history, color: Colors.white),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),

              //MÀN HÌNH HIỂN THỊ 
              Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.bottomRight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text(
                        '',
                        style: TextStyle(fontSize: 20, color: Colors.white54),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '0',
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 12),
                    ],
                  ),
                ),
              ),

              //HÀNG NÚT BỘ NHỚ 
              Row(
                children: ['MC', 'MR', 'M+', 'M−', 'MS'].map((nhan) {
                  return Expanded(
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        nhan,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white38,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              //BÀN PHÍM
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Column(
                    children: _banPhim
                        .map((hang) => _taoHangNut(hang))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _taoHangNut(List<String> hang) {
    return Expanded(
      child: Row(children: hang.map((nhan) => _taoNut(nhan)).toList()),
    );
  }

  Widget _taoNut(String nhan) {
    Color mauNen;
    Color mauChu = Colors.white;
    if (nhan == '=') {
      mauNen = const Color(0xFF4CC2FF);
      mauChu = Colors.black;
    } else if (_phepToanVaChucNang.contains(nhan)) {
      mauNen = const Color(0xFF323232);
    } else {
      mauNen = const Color(0xFF3B3B3B);
    }

    final bool laSo = !_phepToanVaChucNang.contains(nhan) && nhan != '=';
    final double coChu = laSo ? 24 : 20;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: Material(
          color: mauNen,
          borderRadius: BorderRadius.circular(8),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {},
            child: Center(
              child: Text(
                nhan,
                style: TextStyle(
                  fontSize: coChu,
                  fontWeight: FontWeight.w500,
                  color: mauChu,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//  MENU ĐIỀU HƯỚNG
class MenuDieuHuong extends StatelessWidget {
  const MenuDieuHuong({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF2A2A2A),
      width: 280,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [

            Padding(
              padding: const EdgeInsets.all(8),
              child: IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),

            //NHÓM CALCULATOR
            _tieuDeNhom('Calculator'),
            _mucMenu(Icons.calculate_outlined, 'Standard', chonSan: true),
            _mucMenu(Icons.science_outlined, 'Scientific'),
            _mucMenu(Icons.show_chart, 'Graphing'),
            _mucMenu(Icons.code, 'Programmer'),
            _mucMenu(Icons.calendar_today_outlined, 'Date calculation'),

            const SizedBox(height: 8),

            //NHÓM CONVERTER
            _tieuDeNhom('Converter'),
            _mucMenu(Icons.currency_exchange, 'Currency'),
            _mucMenu(Icons.science, 'Volume'),
            _mucMenu(Icons.straighten, 'Length'),
            _mucMenu(Icons.monitor_weight_outlined, 'Weight and mass'),
            _mucMenu(Icons.thermostat, 'Temperature'),
            _mucMenu(Icons.bolt_outlined, 'Energy'),
            _mucMenu(Icons.crop_square, 'Area'),
            _mucMenu(Icons.speed, 'Speed'),

            const Divider(color: Colors.white12),

            //SETTINGS
            _mucMenu(Icons.settings_outlined, 'Settings'),
          ],
        ),
      ),
    );
  }

  // Tiêu đề nhóm
  Widget _tieuDeNhom(String ten) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 16, 6),
      child: Text(
        ten,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // Một mục trong menu
  Widget _mucMenu(IconData icon, String ten, {bool chonSan = false}) {
    return Container(

      color: chonSan ? const Color(0xFF3A3A3A) : Colors.transparent,
      child: Row(
        children: [
          Container(
            width: 3,
            height: 44,
            color: chonSan ? const Color(0xFF4CC2FF) : Colors.transparent,
          ),
          Expanded(
            child: ListTile(
              leading: Icon(icon, color: Colors.white, size: 22),
              title: Text(
                ten,
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
              dense: true,
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
