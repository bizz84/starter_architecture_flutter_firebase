import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_base_app/src/constants/colors.dart';

/// todo add greyed out
class GradientLoadingAnimation extends ConsumerWidget {
  final bool isOutOfRange;
  final double percent;
  final List<String> innerCircleTextList;
  const GradientLoadingAnimation(
      {super.key, required this.innerCircleTextList, this.isOutOfRange = false, required this.percent});

  @override
  Widget build(BuildContext context, WidgetRef ref) => SizedBox(
      width: 50,
      height: 50,
      child: CustomPaint(
          painter: _CircularPaint(progressValue: percent, isOutOfRange: isOutOfRange),
          child: Container(
              padding: const EdgeInsets.all(4.5),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.fromBorderSide(BorderSide(color: Colors.transparent, width: 1.5))),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: innerCircleTextList
                      .map((text) => Text(text,
                          style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold)))
                      .toList()))));
}

class _CircularPaint extends CustomPainter {
  final double borderThickness = 5;
  final double progressValue;
  final bool isOutOfRange;

  _CircularPaint({required this.progressValue, required this.isOutOfRange});
  List<Color> buildGradient(bool isOutOfRange, double range) {
    if (isOutOfRange) return [CustomColors().lighterGrayText, CustomColors().lighterGrayText];
    if (range > .25) {
      return [
        CustomColors().batteryGreen,
        CustomColors().batteryGreen,
        CustomColors().batteryGreen,
        CustomColors().batteryYellowishGreen,
        CustomColors().batteryYellowishGreen,
        CustomColors().batteryGreen,
      ];
    }
    return [
      CustomColors().batteryOrange,
      CustomColors().batteryOrange,
      CustomColors().batteryOrange,
      CustomColors().batteryRed,
      CustomColors().batteryRed,
    ];
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      height: size.height,
      width: size.width,
    );
    canvas.drawArc(
        rect,
        0,
        pi * 2,
        false,
        Paint()
          ..color = isOutOfRange ? CustomColors().lightGrayText : CustomColors().circularIndicatorBG
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.square
          ..strokeWidth = borderThickness);
    canvas.drawArc(
        rect,

        /// not at the center?
        -pi / 2 - pi / 38,
        -pi * progressValue * 2,
        false,
        Paint()
          ..blendMode = BlendMode.srcIn
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.square
          ..strokeWidth = borderThickness
          ..shader = SweepGradient(tileMode: TileMode.clamp, colors: buildGradient(isOutOfRange, progressValue))
              .createShader(rect));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
