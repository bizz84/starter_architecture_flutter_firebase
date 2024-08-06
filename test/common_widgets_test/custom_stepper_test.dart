import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:danlaw_charger/src/constants/colors.dart';
import 'package:danlaw_charger/src/common_widgets/custom_stepper.dart';

void main() {
  group('CustomStepper Widget Tests', () {
    testWidgets('renders the correct number of steps',
        (WidgetTester tester) async {
      const totalSteps = 5;
      const curStep = 3;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomStepper(
              curStep: curStep,
              totalSteps: totalSteps,
              stepCompleteColor: Color(0xffD0BCFF),
              inactiveColor: Color(0xffbababa),
              currentStepColor: CustomColors().whitecolor,
              lineWidth: 2.0,
            ),
          ),
        ),
      );

      // Verify the number of step circles
      expect(find.byType(GestureDetector), findsNWidgets(totalSteps));
    });

    //   testWidgets('renders correct colors for steps',
    //       (WidgetTester tester) async {
    //     const totalSteps = 5;
    //     const curStep = 3;

    //     await tester.pumpWidget(
    //       MaterialApp(
    //         home: Scaffold(
    //           body: CustomStepper(
    //             curStep: curStep,
    //             totalSteps: totalSteps,
    //             stepCompleteColor: Color(0xffD0BCFF),
    //             inactiveColor: Color(0xffbababa),
    //             currentStepColor: CustomColors().whitecolor,
    //             lineWidth: 2.0,
    //           ),
    //         ),
    //       ),
    //     );

    //     final containers = tester.widgetList<Container>(find.byType(Container));

    //     // Verify the colors of the step circles
    //     BoxDecoration? decoration1 =
    //         containers.elementAt(0).decoration as BoxDecoration?;
    //     BoxDecoration? decoration2 =
    //         containers.elementAt(1).decoration as BoxDecoration?;
    //     BoxDecoration? decoration3 =
    //         containers.elementAt(2).decoration as BoxDecoration?;
    //     BoxDecoration? decoration4 =
    //         containers.elementAt(3).decoration as BoxDecoration?;
    //     BoxDecoration? decoration5 =
    //         containers.elementAt(4).decoration as BoxDecoration?;

    //     expect(
    //       decoration1?.color,
    //       Color(0xffbababa),
    //     ); // Step 1 (inactive)
    //     expect(
    //       decoration2?.color,
    //       Color(0xffbababa),
    //     ); // Step 2 (inactive)
    //     expect(decoration3?.color, CustomColors().whitecolor); // Step 3 (current)
    //     expect(decoration4?.color, Color(0xffD0BCFF)); // Step 4 (complete)
    //     expect(decoration5?.color, Color(0xffD0BCFF)); // Step 5 (complete)
    //   });

    //   testWidgets('tapping on a step calls jumpToPage',
    //       (WidgetTester tester) async {
    //     const totalSteps = 5;
    //     const curStep = 3;
    //     final pageController = PageController();

    //     await tester.pumpWidget(
    //       MaterialApp(
    //         home: Scaffold(
    //           body: CustomStepper(
    //             curStep: curStep,
    //             totalSteps: totalSteps,
    //             stepCompleteColor: Color(0xffD0BCFF),
    //             inactiveColor: Color(0xffbababa),
    //             currentStepColor: CustomColors().whitecolor,
    //             lineWidth: 2.0,
    //             pageController: pageController,
    //           ),
    //         ),
    //       ),
    //     );

    //     await tester.tap(find.byType(GestureDetector).at(1));
    //     await tester.pumpAndSettle();

    //     expect(pageController.page, 1);
    //   });
  });
}
