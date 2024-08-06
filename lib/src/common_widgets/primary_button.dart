import 'package:flutter_starter_base_app/src/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_base_app/src/constants/app_sizes.dart';
import 'package:flutter_starter_base_app/src/common_widgets/circular_loading_animation.dart';

/// Primary button based on [ElevatedButton].
/// Useful for CTAs in the app.
/// @param text - text to display on the button.
/// @param isLoading - if true, a loading indicator will be displayed instead of
/// the text.
/// @param onPressed - callback to be called when the button is pressed.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    this.isLoading = false,
    this.onPressed,
    this.backgroundColor,
  });
  final String text;
  final bool isLoading;
  final VoidCallback? onPressed;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizes.p48,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ??
              Theme.of(context).primaryColor, // Use provided background color or fallback to theme color
        ),
        child: isLoading
            ? const LoadingAnimation()
            : Text(
                text,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: CustomColors().darkblueColor,
                      fontWeight: FontWeight.bold, // Set font weight to bold
                    ), // Use provided text color or fallback to white
              ),
      ),
    );
  }
}
