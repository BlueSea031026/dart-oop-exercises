import 'package:flutter_test/flutter_test.dart';
import 'package:bai06/main.dart';

void main() {
  testWidgets('App khởi động', (WidgetTester tester) async {
    await tester.pumpWidget(const ContactManagerApp());
  });
}