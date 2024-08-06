import 'package:danlaw_charger/src/common_widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// Adjust this import according to your project structure

void main() {
  group('CustomTextFormField Tests', () {
    testWidgets('displays hint text correctly', (WidgetTester tester) async {
      final hintText = 'Enter text';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextFormField(
              controller: TextEditingController(),
              textInputType: TextInputType.text,
              hintText: hintText,
            ),
          ),
        ),
      );

      expect(find.text(hintText), findsOneWidget);
    });

    testWidgets('displays prefix icon correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextFormField(
              controller: TextEditingController(),
              textInputType: TextInputType.text,
              hintText: 'Enter text',
              prefixIcon: Icon(Icons.location_on),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.location_on), findsOneWidget);
    });

    testWidgets('onTap callback is triggered', (WidgetTester tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextFormField(
              controller: TextEditingController(),
              textInputType: TextInputType.text,
              hintText: 'Enter text',
              onTap: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(TextFormField));
      await tester.pump();

      expect(tapped, isTrue);
    });

    testWidgets('validator displays error text', (WidgetTester tester) async {
      final formKey = GlobalKey<FormState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: CustomTextFormField(
                controller: TextEditingController(),
                textInputType: TextInputType.text,
                hintText: 'Enter text',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Error text';
                  }
                  return null;
                },
              ),
            ),
          ),
        ),
      );

      formKey.currentState?.validate();
      await tester.pump();

      expect(find.text('Error text'), findsOneWidget);
    });

    testWidgets('readonly field does not accept input',
        (WidgetTester tester) async {
      final controller = TextEditingController(text: 'Initial text');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextFormField(
              controller: controller,
              textInputType: TextInputType.text,
              hintText: 'Enter text',
              readOnly: true,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'New text');
      await tester.pump();

      expect(controller.text, 'Initial text');
    });
  });
}
