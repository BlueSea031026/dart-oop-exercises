import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bai01btvn/controllers/chi_tieu_controller.dart';
import 'package:bai01btvn/models/chi_tieu.dart';
import 'package:bai01btvn/views/chi_tieu_form_dialog.dart';

/// BÀI TẬP VỀ NHÀ 1: quản lý chi tiêu cá nhân
class ChiTieuScreen extends StatefulWidget {
  const ChiTieuScreen({super.key});

  @override
  State<ChiTieuScreen> createState() => _ChiTieuScreenState();
}

class _ChiTieuScreenState extends State<ChiTieuScreen> {
  final ChiTieuController _controller = ChiTieuController();
  final NumberFormat _vnd = NumberFormat.currency(locale: 'vi_VN', symbol: '₫', decimalDigits: 0);
  final DateFormat _dateFmt = DateFormat('dd/MM/yyyy HH:mm');

  List<ChiTieu> _list = [];
  double _tong = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final list = await _controller.getAll();
    final tong = await _controller.getTongTien();
    if (!mounted) return;
    setState(() {
      _list = list;
      _tong = tong;
    });
  }

  Future<void> _openForm([ChiTieu? ct]) async {
    final result = await showDialog<ChiTieu>(
      context: context,
      builder: (_) => ChiTieuFormDialog(chiTieu: ct),
    );
    if (result == null) return;
    if (ct == null) {
      await _controller.insert(result);
    } else {
      await _controller.update(result);
    }
    await _loadData();
  }

  Future<bool> _confirmDelete(ChiTieu ct) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Xoá chi tiêu'),
        content: Text('Xoá "${ct.noiDung}" (${_vnd.format(ct.soTien)})?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Hủy')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Xoá')),
        ],
      ),
    );
    return ok == true;
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Quản lý chi tiêu')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openForm(),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          // Thẻ tổng chi tiêu
          Card(
            margin: const EdgeInsets.all(12),
            color: scheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(Icons.account_balance_wallet, size: 36),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Tổng chi tiêu (${_list.length} mục)'),
                        Text(
                          _vnd.format(_tong),
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: _list.isEmpty
                ? const Center(child: Text('Chưa có khoản chi nào. Bấm + để thêm.'))
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 80),
                    itemCount: _list.length,
                    itemBuilder: (context, index) {
                      final ct = _list[index];
                      // Vuốt sang trái để xoá
                      return Dismissible(
                        key: ValueKey(ct.id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        confirmDismiss: (_) => _confirmDelete(ct),
                        onDismissed: (_) async {
                          // Bỏ item khỏi list ngay để Dismissible không còn trong cây widget
                          setState(() => _list.removeAt(index));
                          await _controller.delete(ct.id!);
                          await _loadData();
                        },
                        child: Card(
                          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          child: ListTile(
                            leading: const CircleAvatar(child: Icon(Icons.shopping_cart)),
                            title: Text(ct.noiDung),
                            subtitle: Text(
                              [if (ct.ghiChu.isNotEmpty) ct.ghiChu, _dateFmt.format(ct.ngayTao)]
                                  .join('\n'),
                            ),
                            isThreeLine: ct.ghiChu.isNotEmpty,
                            trailing: Text(
                              '-${_vnd.format(ct.soTien)}',
                              style: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () => _openForm(ct), // nhấn để sửa
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
