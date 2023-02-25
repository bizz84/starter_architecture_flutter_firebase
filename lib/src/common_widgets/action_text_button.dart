import 'package:flutter/material.dart';
import 'package:starter_architecture_flutter_firebase/src/constants/app_sizes.dart';

/// Text button to be used as an [AppBar] action
class ActionTextButton extends StatelessWidget {
  const ActionTextButton({super.key, required this.text, this.onPressed});
  final String text;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
      child: TextButton(
        onPressed: onPressed,
        child: Text(text,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.white)),
      ),
    );
  }
}
