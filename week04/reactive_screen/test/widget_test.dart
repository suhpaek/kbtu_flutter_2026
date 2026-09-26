import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:reactive_screen/main.dart';

void main() {
  testWidgets('TapCard counts taps and resets via dialog', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('0'), findsWidgets);

    await tester.tap(find.text('Tap this card'));
    await tester.pump();
    await tester.tap(find.text('Tap this card'));
    await tester.pump();

    expect(find.text('2'), findsOneWidget);

    await tester.longPress(find.text('Tap this card'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, 'Cancel'));
    await tester.pumpAndSettle();

    expect(find.text('2'), findsOneWidget);

    await tester.longPress(find.text('Tap this card'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, 'Reset'));
    await tester.pumpAndSettle();

    expect(find.text('2'), findsNothing);
  });

  testWidgets('TwoWayCounter disables minus at zero', (tester) async {
    await tester.pumpWidget(const MyApp());

    final minusButton = tester.widget<OutlinedButton>(
      find.widgetWithText(OutlinedButton, '−'),
    );
    expect(minusButton.onPressed, isNull);

    await tester.tap(find.widgetWithText(FilledButton, '+'));
    await tester.pump();

    final minusAfterIncrement = tester.widget<OutlinedButton>(
      find.widgetWithText(OutlinedButton, '−'),
    );
    expect(minusAfterIncrement.onPressed, isNotNull);
  });

  testWidgets('StopwatchCard disposes without error while running', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.widgetWithText(OutlinedButton, 'Start'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    await tester.pumpWidget(const SizedBox());
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(tester.takeException(), isNull);
  });
}
