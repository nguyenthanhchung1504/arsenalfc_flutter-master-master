import 'package:flutter_test/flutter_test.dart';
import 'package:gooner_vietnam/core/constants/app_info.dart';
import 'package:gooner_vietnam/ui/splash/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('Splash hiển thị tên app', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: SplashScreen()),
    );
    expect(find.text(AppInfo.displayName), findsOneWidget);
  });
}
