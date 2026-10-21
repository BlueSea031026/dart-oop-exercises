import 'package:flutter/material.dart';
import 'package:bai02btvn/controllers/user_controller.dart';
import 'package:bai02btvn/views/register_screen.dart';

/// BÀI TẬP VỀ NHÀ 2: form đăng nhập
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final UserController _userController = UserController();
  bool _loading = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    final user = await _userController.login(_emailCtrl.text, _passCtrl.text);
    if (!mounted) return;
    setState(() => _loading = false);

    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        icon: Icon(
          user != null ? Icons.check_circle : Icons.error,
          color: user != null ? Colors.green : Colors.red,
          size: 48,
        ),
        title: Text(user != null ? 'Đăng nhập thành công' : 'Đăng nhập thất bại'),
        content: Text(
          user != null ? 'Xin chào ${user.email}' : 'Email hoặc mật khẩu không đúng.',
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('OK'))],
      ),
    );
  }

  Future<void> _goRegister() async {
    // RegisterScreen trả về email vừa đăng ký -> điền sẵn vào ô Email
    final email = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => RegisterScreen(initialEmail: _emailCtrl.text.trim())),
    );
    if (email != null) {
      _emailCtrl.text = email;
      _passCtrl.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      appBar: AppBar(backgroundColor: const Color(0xFFEEEEEE)),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _Label('Email'),
                  _InputBox(
                    controller: _emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'Vui lòng nhập email' : null,
                  ),
                  const SizedBox(height: 14),
                  const _Label('Password'),
                  _InputBox(
                    controller: _passCtrl,
                    obscureText: true,
                    validator: (v) => (v == null || v.isEmpty) ? 'Vui lòng nhập mật khẩu' : null,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _BlueButton(
                        text: _loading ? '...' : 'Sign in',
                        onPressed: _loading ? null : _signIn,
                      ),
                      _BlueButton(text: 'Register', onPressed: _goRegister),
                    ],
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

// ----- Các widget nhỏ dùng chung cho Login/Register -----

class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.w500)),
      );
}

class _InputBox extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const _InputBox({
    required this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          hintText: 'Value',
          filled: true,
          fillColor: const Color(0xFFF2F2F2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
      );
}

class _BlueButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  const _BlueButton({required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0B6BD3),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: Text(text),
      );
}
