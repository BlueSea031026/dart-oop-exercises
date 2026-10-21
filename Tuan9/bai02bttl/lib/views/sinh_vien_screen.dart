import 'package:flutter/material.dart';
import 'package:bai02bttl/controllers/sinh_vien_controller.dart';
import 'package:bai02bttl/models/sinh_vien.dart';
import 'package:bai02bttl/views/sinh_vien_form_dialog.dart';

/// BÀI TẬP 2 (trên lớp): quản lý sinh viên
class SinhVienScreen extends StatefulWidget {
  const SinhVienScreen({super.key});

  @override
  State<SinhVienScreen> createState() => _SinhVienScreenState();
}

class _SinhVienScreenState extends State<SinhVienScreen> {
  final SinhVienController _controller = SinhVienController();
  final TextEditingController _searchCtrl = TextEditingController();
  List<SinhVien> _list = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  // Tải danh sách; nếu ô tìm kiếm có chữ thì lọc theo từ khoá
  Future<void> _loadData() async {
    final keyword = _searchCtrl.text.trim();
    final data = keyword.isEmpty ? await _controller.getAll() : await _controller.search(keyword);
    if (!mounted) return;
    setState(() => _list = data);
  }

  void _toast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  // Nút '+': mở dialog thêm sinh viên
  Future<void> _addSinhVien() async {
    final sv = await showDialog<SinhVien>(
      context: context,
      builder: (_) => const SinhVienFormDialog(),
    );
    if (sv == null) return; // bấm Hủy
    await _controller.insert(sv);
    await _loadData();
    _toast('Đã thêm ${sv.name}');
  }

  // Nhấn vào sinh viên: mở dialog chi tiết, cho phép cập nhật
  Future<void> _showDetail(SinhVien sv) async {
    final updated = await showDialog<SinhVien>(
      context: context,
      builder: (_) => SinhVienFormDialog(sinhVien: sv),
    );
    if (updated == null) return;
    await _controller.update(updated);
    await _loadData();
    _toast('Đã cập nhật ${updated.name}');
  }

  Future<void> _deleteSinhVien(SinhVien sv) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Xoá sinh viên'),
        content: Text('Bạn có chắc muốn xoá "${sv.name}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Hủy')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Xoá')),
        ],
      ),
    );
    if (ok != true) return;
    await _controller.delete(sv.id!);
    await _loadData();
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchCtrl,
      onChanged: (_) => _loadData(),
      decoration: InputDecoration(
        hintText: 'Tìm kiếm sinh viên...',
        filled: true,
        fillColor: Colors.white70,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            _searchCtrl.clear();
            _loadData();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _addSinhVien,
        child: const Icon(Icons.add),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFE3F2FD), Color(0xFFFCE4EC)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Ô tìm kiếm có nút X xoá nhanh
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 8, 12, 4),
                child: Row(
                  children: [
                    if (Navigator.canPop(context)) const BackButton(),
                    Expanded(child: _buildSearchField()),
                  ],
                ),
              ),
              Expanded(
                child: _list.isEmpty
                    ? const Center(child: Text('Không có sinh viên nào'))
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        itemCount: _list.length,
                        itemBuilder: (context, index) {
                          final sv = _list[index];
                          return Card(
                            color: Colors.blueGrey[100],
                            child: ListTile(
                              leading: const CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(Icons.school, color: Colors.blue),
                              ),
                              title: Text(
                                sv.name,
                                style: const TextStyle(color: Color(0xFF0D47A1), fontSize: 18),
                              ),
                              subtitle: Text(sv.email, style: const TextStyle(color: Colors.white)),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _deleteSinhVien(sv),
                              ),
                              onTap: () => _showDetail(sv),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
