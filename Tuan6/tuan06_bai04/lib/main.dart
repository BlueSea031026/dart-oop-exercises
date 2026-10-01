import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const VideoRecorderApp());
}

class VideoRecorderApp extends StatelessWidget {
  const VideoRecorderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Recorder & Playback',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.purple, useMaterial3: true),
      home: const VideoRecorderHome(),
    );
  }
}

class VideoRecorderHome extends StatefulWidget {
  const VideoRecorderHome({super.key});

  @override
  State<VideoRecorderHome> createState() => _VideoRecorderHomeState();
}

class _VideoRecorderHomeState extends State<VideoRecorderHome> {
  final ImagePicker _picker = ImagePicker();
  VideoPlayerController? _videoController; // điều khiển phát video
  bool _isLoading = false;

  // Chọn video từ gallery
  Future<void> _pickVideoFromGallery() async {
    final XFile? pickedFile =
        await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      await _loadVideo(File(pickedFile.path));
    } else {
      _showMessage('Chưa chọn video nào');
    }
  }

  // Quay video từ camera 
  Future<void> _recordVideoFromCamera() async {
    final statuses =
        await [Permission.camera, Permission.microphone].request();
    if (!statuses[Permission.camera]!.isGranted ||
        !statuses[Permission.microphone]!.isGranted) {
      _showMessage('Vui lòng cấp quyền camera và micro!');
      return;
    }

    final XFile? recordedFile = await _picker.pickVideo(
      source: ImageSource.camera,
      maxDuration: const Duration(minutes: 1), // giới hạn 1 phút
    );
    if (recordedFile != null) {
      await _loadVideo(File(recordedFile.path));
    } else {
      _showMessage('Chưa quay video nào');
    }
  }

  // Tải video vào player và tự động phát
  Future<void> _loadVideo(File videoFile) async {
    setState(() => _isLoading = true);

    // Giải phóng controller cũ (nếu có)
    final oldController = _videoController;
    _videoController = null;
    oldController?.removeListener(_onVideoChanged);
    await oldController?.dispose();

    final controller = VideoPlayerController.file(videoFile);
    await controller.initialize();
    controller.addListener(_onVideoChanged); // cập nhật nút play/pause, thời gian
    await controller.play();

    if (!mounted) return;
    setState(() {
      _videoController = controller;
      _isLoading = false;
    });
  }

  void _onVideoChanged() {
    if (mounted) setState(() {});
  }

  // Phát / tạm dừng
  void _togglePlayPause() {
    final c = _videoController;
    if (c == null) return;
    final isEnded = c.value.position >= c.value.duration;
    if (c.value.isPlaying) {
      c.pause();
    } else {
      if (isEnded) c.seekTo(Duration.zero); // hết video thì phát lại từ đầu
      c.play();
    }
  }

  // Phát lại từ đầu
  void _replay() {
    _videoController?.seekTo(Duration.zero);
    _videoController?.play();
  }

  String _formatDuration(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  void _showMessage(String text) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  void dispose() {
    _videoController?.removeListener(_onVideoChanged);
    _videoController?.dispose(); // giải phóng bộ nhớ khi thoát màn hình
    super.dispose();
  }

  Widget _buildVideoArea() {
    if (_isLoading) {
      return const SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      );
    }
    final c = _videoController;
    if (c == null || !c.value.isInitialized) {
      return const SizedBox(
        height: 200,
        child: Center(child: Text('Chưa có video nào được chọn.')),
      );
    }
    return Column(
      children: [
        AspectRatio(
          aspectRatio: c.value.aspectRatio,
          child: VideoPlayer(c),
        ),
        // Thanh tiến trình, có thể kéo để tua
        VideoProgressIndicator(
          c,
          allowScrubbing: true,
          padding: const EdgeInsets.symmetric(vertical: 8),
        ),
        Text(
          '${_formatDuration(c.value.position)} / '
          '${_formatDuration(c.value.duration)}',
        ),
        const SizedBox(height: 8),
        // Nút điều khiển
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _togglePlayPause,
              child: Icon(
                c.value.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            ),
            const SizedBox(width: 12),
            ElevatedButton(
              onPressed: _replay,
              child: const Icon(Icons.replay),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Video Recorder & Playback')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildVideoArea(),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _pickVideoFromGallery,
              icon: const Icon(Icons.video_library),
              label: const Text('Chọn video từ Gallery'),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: _recordVideoFromCamera,
              icon: const Icon(Icons.videocam),
              label: const Text('Quay video từ Camera'),
            ),
          ],
        ),
      ),
    );
  }
}