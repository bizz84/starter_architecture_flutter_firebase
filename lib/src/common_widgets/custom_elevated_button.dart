import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.child,
    this.color,
    this.textColor,
    this.height = 50.0,
    this.borderRadius = 4.0,
    this.loading = false,
    this.onPressed,
  });
  final Widget child;
  final Color? color;
  final Color? textColor;
  final double height;
  final double borderRadius;
  final bool loading;
  final VoidCallback? onPressed;

  Widget buildSpinner(BuildContext context) {
    final ThemeData data = Theme.of(context);
    return Theme(
      data: data.copyWith(
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.white70)),
      child: const SizedBox(
        width: 28,
        height: 28,
        child: CircularProgressIndicator(
          strokeWidth: 3.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        child: loading ? buildSpinner(context) : child,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.all(
        //     Radius.circular(borderRadius),
        //   ),
        // ),
        style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: textColor,
            disabledForegroundColor: textColor // foreground (text) color
            ), // height / 2
        onPressed: onPressed,
      ),
    );
  }
}
