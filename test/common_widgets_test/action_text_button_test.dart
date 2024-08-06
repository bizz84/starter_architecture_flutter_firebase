import 'package:danlaw_charger/src/common_widgets/action_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("action text button", () {
    testWidgets("display the text correctly", (WidgetTester tester) async {
      const text = "click here";

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: ActionTextButton(
            text: text,
            onPressed: () {},
          ),
        ),
      ));
      expect(find.text(text), findsOneWidget);
    });

    testWidgets("onPressed is Triggered", (WidgetTester tester) async {
      bool onpressed = false;
      await tester.pumpWidget(MaterialApp(
          home: Scaffold(
        body: ActionTextButton(
          text: "Click here",
          onPressed: () {
            onpressed = true;
          },
        ),
      )));

      await tester.tap(find.byType(TextButton));
      await tester.pump();
      expect(onpressed, isTrue);
    });
  });
}
