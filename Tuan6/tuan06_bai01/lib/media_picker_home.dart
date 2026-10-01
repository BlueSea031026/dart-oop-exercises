import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';

class MediaPickerHome extends StatefulWidget {
  const MediaPickerHome({super.key});

  @override
  State<MediaPickerHome> createState() => _MediaPickerHomeState();
}

class _MediaPickerHomeState extends State<MediaPickerHome> {
  File? _mediaFile; 
  VideoPlayerController? _videoController; 
  final ImagePicker _picker = ImagePicker();
  bool _isBusy = false; 

  // Xin quyền, trả về true nếu được cấp
  Future<bool> _requestPermissions(List<Permission> permissions) async {
    final statuses = await permissions.request();
    final granted = statuses.values.every((s) => s.isGranted);
    if (!granted) {
      _showMessage('Vui lòng cấp quyền để sử dụng chức năng này!');
    }
    return granted;
  }

  // 1. Chọn ảnh từ Gallery
  Future<void> _pickImageFromGallery() async {
    final XFile? file = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1920,
      maxHeight: 1080,
      imageQuality: 100,
    );
    if (file != null) {
      _showImage(file);
    } else {
      _showMessage('Chưa chọn ảnh nào');
    }
  }

  // 2. Chụp ảnh từ Camera
  Future<void> _captureImageFromCamera() async {
    if (!await _requestPermissions([Permission.camera])) return;
    final XFile? file = await _picker.pickImage(source: ImageSource.camera);
    if (file != null) {
      _showImage(file);
    } else {
      _showMessage('Chưa chụp ảnh nào');
    }
  }

  // 3. Chọn video từ Gallery
  Future<void> _pickVideoFromGallery() async {
    final XFile? file = await _picker.pickVideo(source: ImageSource.gallery);
    if (file != null) {
      await _showVideo(file);
    } else {
      _showMessage('Chưa chọn video nào');
    }
  }

  // 4. Quay video từ Camera
  Future<void> _recordVideoFromCamera() async {
    if (!await _requestPermissions(
        [Permission.camera, Permission.microphone])) {
      return;
    }
    final XFile? file = await _picker.pickVideo(
      source: ImageSource.camera,
      maxDuration: const Duration(minutes: 1),
    );
    if (file != null) {
      await _showVideo(file);
    } else {
      _showMessage('Chưa quay video nào');
    }
  }

  // Bọc các thao tác để không bị bấm 2 lần cùng lúc
  Future<void> _run(Future<void> Function() action) async {
    if (_isBusy) return;
    _isBusy = true;
    try {
      await action();
    } finally {
      _isBusy = false;
    }
  }

  // Hiển thị ảnh
  void _showImage(XFile xfile) {
    _videoController?.dispose(); // giải phóng video cũ (nếu có)
    setState(() {
      _mediaFile = File(xfile.path);
      _videoController = null;
    });
  }

  // Hiển thị và phát video
  Future<void> _showVideo(XFile xfile) async {
    final oldController = _videoController;
    setState(() => _videoController = null);
    await oldController?.dispose(); // giải phóng video cũ (nếu có)

    final file = File(xfile.path);
    final controller = VideoPlayerController.file(file);
    await controller.initialize();
    await controller.setLooping(true);
    await controller.play();

    if (!mounted) return;
    setState(() {
      _mediaFile = file;
      _videoController = controller;
    });
  }

  void _showMessage(String text) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  void dispose() {
    _videoController?.dispose(); // giải phóng bộ nhớ khi thoát
    super.dispose();
  }

  // Vùng hiển thị ảnh / video
  Widget _buildPreview() {
    if (_mediaFile == null) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text('Chưa chọn ảnh hoặc video.'),
      );
    }
    final c = _videoController;
    if (c != null && c.value.isInitialized) {
      return AspectRatio(
        aspectRatio: c.value.aspectRatio,
        child: VideoPlayer(c),
      );
    }
    return Image.file(_mediaFile!, height: 300);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Media Picker App')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(child: _buildPreview()),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _run(_pickImageFromGallery),
              child: const Text('Chọn ảnh từ Gallery'),
            ),
            ElevatedButton(
              onPressed: () => _run(_captureImageFromCamera),
              child: const Text('Chụp ảnh từ Camera'),
            ),
            ElevatedButton(
              onPressed: () => _run(_pickVideoFromGallery),
              child: const Text('Chọn video từ Gallery'),
            ),
            ElevatedButton(
              onPressed: () => _run(_recordVideoFromCamera),
              child: const Text('Quay video từ Camera'),
            ),
          ],
        ),
      ),
    );
  }
}