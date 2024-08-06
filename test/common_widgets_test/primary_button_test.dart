import 'package:danlaw_charger/src/common_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Primary Button ", () {
    testWidgets("on Pressed is triggered", (WidgetTester tester) async {
      bool onpressed = false;
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: PrimaryButton(
          onPressed: () {
            onpressed = true;
          },
          text: "Click Me",
        )),
      ));

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      expect(onpressed, isTrue);
    });
    testWidgets("display the text correctly", (WidgetTester tester) async {
      const buttontext = "Click Me";
      await tester.pumpWidget(MaterialApp(
          home: Scaffold(
              body: PrimaryButton(text: buttontext, onPressed: () {}))));
      expect(find.text(buttontext), findsOneWidget);
    });

    testWidgets("applies background color correctly",
        (WidgetTester tester) async {
      const color = Colors.red;
      await tester.pumpWidget(MaterialApp(
          home: Scaffold(
        body: PrimaryButton(
          text: 'Click Me',
          onPressed: () {},
          backgroundColor: color,
        ),
      )));
      final elevatedButton =
          tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      final backgroundColor =
          elevatedButton.style?.backgroundColor?.resolve({});

      expect(backgroundColor, color);
    });
  });
}
