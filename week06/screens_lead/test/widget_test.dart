import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:screens_lead/main.dart';

void main() {
  testWidgets('shows the students list', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Students'), findsOneWidget);
    expect(find.text('Aida Akhmetova'), findsOneWidget);
  });

  testWidgets('tapping a student opens the detail screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Aida Akhmetova'));
    await tester.pumpAndSettle();

    expect(find.text('aida@kbtu.kz'), findsOneWidget);
    expect(find.byIcon(Icons.chevron_right), findsNothing);
  });
}
