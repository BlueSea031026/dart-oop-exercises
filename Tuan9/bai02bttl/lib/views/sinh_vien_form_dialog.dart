import 'package:flutter/material.dart';
import 'package:bai02bttl/models/sinh_vien.dart';

/// Dialog dùng chung cho 2 chế độ:
///  - Thêm mới (sinhVien == null): tiêu đề "Thêm Sinh Viên", nút Hủy / Lưu
///  - Chi tiết + cập nhật (sinhVien != null): nút Cập nhật / Hủy
/// Trả về SinhVien qua Navigator.pop, hoặc null nếu bấm Hủy.
/// Viết thành StatefulWidget để TextEditingController được dispose đúng lúc.
class SinhVienFormDialog extends StatefulWidget {
  final SinhVien? sinhVien;
  const SinhVienFormDialog({super.key, this.sinhVien});

  @override
  State<SinhVienFormDialog> createState() => _SinhVienFormDialogState();
}

class _SinhVienFormDialogState extends State<SinhVienFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl;
  late final TextEditingController _emailCtrl;

  bool get _isEdit => widget.sinhVien != null;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.sinhVien?.name ?? '');
    _emailCtrl = TextEditingController(text: widget.sinhVien?.email ?? '');
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pop(
      context,
      SinhVien(
        id: widget.sinhVien?.id,
        name: _nameCtrl.text.trim(),
        email: _emailCtrl.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sv = widget.sinhVien;
    return AlertDialog(
      title: Text(_isEdit ? 'Thông tin chi tiết của sinh viên' : 'Thêm Sinh Viên'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_isEdit)
              Text('Dữ liệu: ${sv!.id} ${sv.name}', style: const TextStyle(fontSize: 12)),
            TextFormField(
              controller: _nameCtrl,
              decoration: const InputDecoration(labelText: 'Tên Sinh Viên'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Vui lòng nhập tên' : null,
            ),
            TextFormField(
              controller: _emailCtrl,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Vui lòng nhập email';
                final ok = RegExp(r'^[\w.\-]+@[\w\-]+(\.[\w\-]+)+$').hasMatch(v.trim());
                return ok ? null : 'Email không hợp lệ';
              },
            ),
          ],
        ),
      ),
      actions: _isEdit
          ? [
              TextButton(onPressed: _submit, child: const Text('Cập nhật')),
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Hủy')),
            ]
          : [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Hủy')),
              ElevatedButton(onPressed: _submit, child: const Text('Lưu')),
            ],
    );
  }
}
