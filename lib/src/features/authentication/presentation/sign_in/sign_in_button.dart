import 'package:flutter/material.dart';
import 'package:starter_architecture_flutter_firebase/src/common_widgets/custom_elevated_button.dart';

class SignInButton extends CustomElevatedButton {
  SignInButton({
    Key? key,
    required String text,
    required Color color,
    VoidCallback? onPressed,
    Color textColor = Colors.black87,
    double height = 50.0,
  }) : super(
          key: key,
          child: Text(text, style: TextStyle(color: textColor, fontSize: 16.0)),
          color: color,
          textColor: textColor,
          height: height,
          onPressed: onPressed,
        );
}
