import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const PhotoCaptureApp());
}

class PhotoCaptureApp extends StatelessWidget {
  const PhotoCaptureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Photo Capture & Preview',
      theme: ThemeData(colorSchemeSeed: Colors.green, useMaterial3: true),
      home: const PhotoCaptureHome(),
    );
  }
}

class PhotoCaptureHome extends StatefulWidget {
  const PhotoCaptureHome({super.key});

  @override
  State<PhotoCaptureHome> createState() => _PhotoCaptureHomeState();
}

class _PhotoCaptureHomeState extends State<PhotoCaptureHome> {
  // Lưu ảnh được chọn hoặc chụp
  File? _imageFile;

  // Đối tượng ImagePicker
  final ImagePicker _picker = ImagePicker();

  // Chặn bấm nhiều lần liên tiếp
  bool _isBusy = false;

  // Chọn ảnh từ Gallery
  Future<void> _pickImageFromGallery() async {
    if (_isBusy) return;
    _isBusy = true;
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() => _imageFile = File(pickedFile.path));
      } else {
        _showMessage('Chưa chọn ảnh nào');
      }
    } finally {
      _isBusy = false;
    }
  }

  // Chụp ảnh từ Camera
  Future<void> _captureImageFromCamera() async {
    if (_isBusy) return;
    _isBusy = true;
    try {
      final status = await Permission.camera.request(); // xin quyền camera
      if (!status.isGranted) {
        _showMessage('Vui lòng cấp quyền camera!');
        return;
      }
      final XFile? capturedFile =
          await _picker.pickImage(source: ImageSource.camera);
      if (capturedFile != null) {
        setState(() => _imageFile = File(capturedFile.path));
      } else {
        _showMessage('Chưa chụp ảnh nào');
      }
    } finally {
      _isBusy = false;
    }
  }

  // Mở màn hình xem trước toàn màn hình
  void _showFullScreenPreview() {
    if (_imageFile == null) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenImage(imageFile: _imageFile!),
      ),
    );
  }

  void _showMessage(String text) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Photo Capture & Preview')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Vùng hiển thị ảnh: bấm vào để xem toàn màn hình
              _imageFile == null
                  ? const Text('Chưa có ảnh nào được chọn.')
                  : GestureDetector(
                      onTap: _showFullScreenPreview,
                      child: Hero(
                        tag: 'preview-image',
                        child: Image.file(_imageFile!, height: 300),
                      ),
                    ),
              if (_imageFile != null)
                const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    'Nhấn vào ảnh để xem toàn màn hình',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _pickImageFromGallery,
                icon: const Icon(Icons.photo_library),
                label: const Text('Chọn ảnh từ Gallery'),
              ),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: _captureImageFromCamera,
                icon: const Icon(Icons.camera_alt),
                label: const Text('Chụp ảnh từ Camera'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Màn hình xem trước ảnh toàn màn hình
class FullScreenImage extends StatelessWidget {
  final File imageFile;

  const FullScreenImage({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Xem trước'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Center(
        // Cho phép phóng to / thu nhỏ bằng 2 ngón tay
        child: InteractiveViewer(
          minScale: 1,
          maxScale: 5,
          child: Hero(
            tag: 'preview-image',
            child: Image.file(imageFile),
          ),
        ),
      ),
    );
  }
}