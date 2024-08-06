import 'package:flutter_starter_base_app/src/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_base_app/src/constants/app_sizes.dart';

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
                .titleMedium!
                .copyWith(color: CustomColors().lightblueColor
                    //  Colors.white
                    )),
      ),
    );
  }
}
// >>>>>>> 31efecbea456f03fbf91d0d8ec13fb67bc80b137
