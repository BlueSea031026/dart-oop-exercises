import 'package:flutter/material.dart';
import 'package:bai01btvn/models/chi_tieu.dart';

/// Dialog thêm / sửa một mục chi tiêu. Trả về ChiTieu hoặc null (Hủy).
class ChiTieuFormDialog extends StatefulWidget {
  final ChiTieu? chiTieu;
  const ChiTieuFormDialog({super.key, this.chiTieu});

  @override
  State<ChiTieuFormDialog> createState() => _ChiTieuFormDialogState();
}

class _ChiTieuFormDialogState extends State<ChiTieuFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _noiDungCtrl;
  late final TextEditingController _soTienCtrl;
  late final TextEditingController _ghiChuCtrl;

  @override
  void initState() {
    super.initState();
    final ct = widget.chiTieu;
    _noiDungCtrl = TextEditingController(text: ct?.noiDung ?? '');
    _soTienCtrl = TextEditingController(text: ct == null ? '' : ct.soTien.toStringAsFixed(0));
    _ghiChuCtrl = TextEditingController(text: ct?.ghiChu ?? '');
  }

  @override
  void dispose() {
    _noiDungCtrl.dispose();
    _soTienCtrl.dispose();
    _ghiChuCtrl.dispose();
    super.dispose();
  }

  // Cho phép nhập "50.000" hoặc "50,000" -> 50000
  double? _parseTien(String s) => double.tryParse(s.replaceAll(RegExp(r'[.,\s]'), ''));

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pop(
      context,
      ChiTieu(
        id: widget.chiTieu?.id,
        noiDung: _noiDungCtrl.text.trim(),
        soTien: _parseTien(_soTienCtrl.text)!,
        ghiChu: _ghiChuCtrl.text.trim(),
        ngayTao: widget.chiTieu?.ngayTao, // sửa thì giữ ngày cũ
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.chiTieu == null ? 'Thêm chi tiêu' : 'Sửa chi tiêu'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _noiDungCtrl,
                decoration: const InputDecoration(labelText: 'Nội dung chi tiêu'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Vui lòng nhập nội dung' : null,
              ),
              TextFormField(
                controller: _soTienCtrl,
                decoration: const InputDecoration(labelText: 'Số tiền (VNĐ)'),
                keyboardType: TextInputType.number,
                validator: (v) {
                  final value = _parseTien(v ?? '');
                  if (value == null) return 'Số tiền không hợp lệ';
                  if (value <= 0) return 'Số tiền phải lớn hơn 0';
                  return null;
                },
              ),
              TextFormField(
                controller: _ghiChuCtrl,
                decoration: const InputDecoration(labelText: 'Ghi chú'),
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Hủy')),
        ElevatedButton(onPressed: _submit, child: const Text('Lưu')),
      ],
    );
  }
}
