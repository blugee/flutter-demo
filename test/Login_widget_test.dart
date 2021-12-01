import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocci/app/global_widgets/ui_widgets.dart';
import 'package:mocci/main.dart';

void main() {
  testWidgets('Login button', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    var loginButton = find.byType(MainButton);
    await tester.tap(loginButton);
    await tester.pump();
    expect(loginButton, findsWidgets);
  });
}
