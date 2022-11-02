import 'package:flutter/material.dart';
import 'package:starter_architecture_flutter_firebase/src/common_widgets/custom_elevated_button.dart';

class FormSubmitButton extends CustomElevatedButton {
  FormSubmitButton({
    super.key,
    required String text,
    bool loading = false,
    VoidCallback? onPressed,
  }) : super(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 20.0),
          ),
          height: 44.0,
          color: Colors.indigo,
          textColor: Colors.black87,
          loading: loading,
          onPressed: onPressed,
        );
}
