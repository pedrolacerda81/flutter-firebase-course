import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/common_widgets/custom_raised_button.dart';

void main() {
  group('Custom Raised Button', () {
    testWidgets('onPressed Callback', (WidgetTester widgetTester) async {
      var pressed = false;
      await widgetTester.pumpWidget(
        MaterialApp(
          home: CustomRaisedButton(
            child: Text('TapMe'),
            onPressed: () => pressed = true,
          ),
        ),
      );
      final button = find.byType(RaisedButton);
      expect(button, findsOneWidget);
      expect(find.byType(FlatButton), findsNothing);
      expect(find.text('TapMe'), findsOneWidget);
      await widgetTester.tap(button);
      expect(pressed, true);
    });
  });
}
