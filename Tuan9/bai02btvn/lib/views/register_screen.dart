import 'package:flutter/material.dart';
import 'package:bai02btvn/controllers/user_controller.dart';

/// BÀI TẬP VỀ NHÀ 2: form đăng ký tài khoản
class RegisterScreen extends StatefulWidget {
  final String initialEmail;
  const RegisterScreen({super.key, this.initialEmail = ''});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailCtrl;
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  final UserController _userController = UserController();

  @override
  void initState() {
    super.initState();
    _emailCtrl = TextEditingController(text: widget.initialEmail);
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    final email = _emailCtrl.text.trim().toLowerCase();
    final ok = await _userController.register(email, _passCtrl.text);
    if (!mounted) return;

    if (!ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email đã được đăng ký, hãy dùng email khác.')),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đăng ký thành công! Hãy đăng nhập.')),
    );
    Navigator.pop(context, email); // trả email về màn hình đăng nhập
  }

  InputDecoration _deco(String label) => InputDecoration(
        labelText: label,
        filled: true,
        fillColor: const Color(0xFFF2F2F2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      appBar: AppBar(title: const Text('Register'), backgroundColor: const Color(0xFFEEEEEE)),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFDDDDDD),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    decoration: _deco('Email'),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'Vui lòng nhập email';
                      final ok =
                          RegExp(r'^[\w.\-]+@[\w\-]+(\.[\w\-]+)+$').hasMatch(v.trim());
                      return ok ? null : 'Email không hợp lệ';
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _passCtrl,
                    obscureText: true,
                    decoration: _deco('Password'),
                    validator: (v) =>
                        (v == null || v.length < 6) ? 'Mật khẩu tối thiểu 6 ký tự' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _confirmCtrl,
                    obscureText: true,
                    decoration: _deco('Confirm password'),
                    validator: (v) => v != _passCtrl.text ? 'Mật khẩu nhập lại không khớp' : null,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0B6BD3),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Register'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
