import 'package:flutter_test/flutter_test.dart';
import 'package:tuan06_bai04/main.dart';

void main() {
  testWidgets('App khởi động', (WidgetTester tester) async {
    await tester.pumpWidget(const VideoRecorderApp());
  });
}
