import 'package:flutter/material.dart';

void main() {
  runApp(const AppViDienTu());
}

class AppViDienTu extends StatelessWidget {
  const AppViDienTu({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ví điện tử',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, fontFamily: 'Roboto'),
      home: const ManHinhVi(),
    );
  }
}

//  MÀN HÌNH VÍ

class ManHinhVi extends StatelessWidget {
  const ManHinhVi({super.key});

  static const Color _tim = Color(0xFF9B6BE8);
  static const Color _hong = Color(0xFFE91E63);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: _hong,
        shape: const CircleBorder(),
        child: const Text('\$',
            style: TextStyle(
                fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const SizedBox(height: 12),

            //TIÊU ĐỀ
            Row(
              children: [
                RichText(
                  text: const TextSpan(
                    style: TextStyle(fontSize: 22, color: Color(0xFF2A2A2A)),
                    children: [
                      TextSpan(
                          text: 'My ',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: 'Cards'),
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.add, color: Colors.black54, size: 22),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Container(
              height: 180,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFA97BEE), Color(0xFF8E5BE0)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: _tim.withOpacity(0.4),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Balance',
                      style: TextStyle(color: Colors.white70, fontSize: 13)),
                  const SizedBox(height: 6),
                  const Text('\$5250.25',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Row(
                    children: const [
                      Text('12345678',
                          style: TextStyle(color: Colors.white70, fontSize: 14)),
                      Spacer(),
                      Text('10/24',
                          style: TextStyle(color: Colors.white70, fontSize: 14)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _cham(rong: true),
                _cham(),
                _cham(),
              ],
            ),

            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                _NutChucNang(icon: Icons.mark_email_read, mau: Color(0xFF22C55E), nhan: 'Send'),
                _NutChucNang(icon: Icons.credit_card, mau: Color(0xFF2F80F6), nhan: 'Pay'),
                _NutChucNang(icon: Icons.receipt_long, mau: Color(0xFFEF4444), nhan: 'Bills'),
              ],
            ),

            const SizedBox(height: 24),

            //MỤC STATISTICS
            const _MucDanhSach(
              icon: Icons.bar_chart,
              mauIcon: Color(0xFF2F80F6),
              tieuDe: 'Statistics',
              phu: 'Payment and Income',
            ),
            const SizedBox(height: 14),

            //MỤC TRANSACTIONS
            const _MucDanhSach(
              icon: Icons.account_balance_wallet,
              mauIcon: Color(0xFF22C55E),
              tieuDe: 'Transactions',
              phu: 'Transaction History',
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _cham({bool rong = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      width: rong ? 22 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: rong ? const Color(0xFF3A3A3A) : Colors.grey.shade400,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}


//Send / Pay / Bills

class _NutChucNang extends StatelessWidget {
  final IconData icon;
  final Color mau;
  final String nhan;

  const _NutChucNang({required this.icon, required this.mau, required this.nhan});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Icon(icon, color: mau, size: 28),
        ),
        const SizedBox(height: 8),
        Text(nhan,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2A2A2A))),
      ],
    );
  }
}

//(Statistics / Transactions)
class _MucDanhSach extends StatelessWidget {
  final IconData icon;
  final Color mauIcon;
  final String tieuDe;
  final String phu;

  const _MucDanhSach({
    required this.icon,
    required this.mauIcon,
    required this.tieuDe,
    required this.phu,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Ô icon
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: mauIcon.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: mauIcon, size: 24),
          ),
          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tieuDe,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2A2A2A))),
                const SizedBox(height: 3),
                Text(phu,
                    style: const TextStyle(fontSize: 13, color: Colors.grey)),
              ],
            ),
          ),

          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }
}