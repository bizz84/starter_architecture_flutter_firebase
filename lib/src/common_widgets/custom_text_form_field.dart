import 'package:flutter_starter_base_app/src/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.labelText,
    this.suffixIcon,
    required this.controller,
    required this.textInputType,
    // this.label,
    this.errorText,
    this.hintText,
    this.onPressed,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
    this.onSaved,
    this.validator,
    this.enabled,
    this.prefixIcon,
    this.maxLines,
    this.minimumLines,
    this.onEditing,
    this.prefixtext,
    this.helptext,
    this.focusNode,
    this.obscureText = false,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.suffixtext,
    this.readOnly = false,
    this.inputFormatter,
  });

  final String? labelText;
  final String? hintText;
  final int? maxLines;
  final int? minimumLines;
  final TextEditingController controller;
  final TextInputType textInputType;
  final IconData? suffixIcon;
  final VoidCallback? onPressed;
  final VoidCallback? onTap;
  final ValueChanged<String>? onFieldSubmitted;
  final ValueChanged? onChanged;
  final FormFieldValidator<dynamic>? validator;
  final FormFieldSetter<dynamic>? onSaved;
  final bool? enabled;
  final Widget? prefixIcon;
  final void Function()? onEditing;
  final String? prefixtext;
  final String? helptext;
  final String? suffixtext;
  final FocusNode? focusNode;
  final String? errorText;
  final bool obscureText;
  final AutovalidateMode autovalidateMode;
  final bool readOnly;
 final TextInputFormatter? inputFormatter;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      controller: controller,
      onTap: onTap,
      keyboardType: textInputType,
      validator: validator,
      maxLines: maxLines,
      minLines: minimumLines,
      enabled: enabled,
      onEditingComplete: onEditing,
      onSaved: onSaved,
      obscureText: obscureText,
      autovalidateMode: autovalidateMode,
      inputFormatters: inputFormatter == null ? [] : [inputFormatter!],
      // autofocus: true,
      // textDirection: TextDirection.rtl,
      readOnly: readOnly,
      textAlign: TextAlign.right,
      style: TextStyle(
        overflow: TextOverflow.ellipsis,
        color: CustomColors().whitecolor, // Set the text color
      ),

      // style: Theme.of(context).textTheme.bodySmall,
      cursorColor: CustomColors().whitecolor,
      decoration: decoration(),
    );
  }

  InputDecoration decoration() {
    return InputDecoration(
      contentPadding: const EdgeInsets.all(12.0),
      hintMaxLines: 1,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0.0),
          borderSide: BorderSide(
            color: CustomColors().grayColor,
          )),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: CustomColors().grayColor, width: 0),
        borderRadius: BorderRadius.circular(0.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: CustomColors().grayColor, width: 0),
        borderRadius: BorderRadius.circular(0.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(0.0),
        borderSide: BorderSide(
          color: CustomColors().red,
          width: 1,
        ),
      ),
      errorText: errorText,
      errorStyle: TextStyle(color: CustomColors().red),
      helperText: helptext,
      suffixText: suffixtext,
      suffixStyle: TextStyle(color: CustomColors().whitecolor, fontSize: 17, fontWeight: FontWeight.normal),
      labelText: labelText,
      hintTextDirection: TextDirection.rtl,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      labelStyle: TextStyle(color: CustomColors().lightblueColor, fontSize: 17, fontWeight: FontWeight.normal),
      fillColor: CustomColors().grayColor,
      filled: true,
      isDense: true,
      prefixText: controller.text.isEmpty ? prefixtext : null,
      prefixStyle: TextStyle(color: CustomColors().whitecolor, fontSize: 17, fontWeight: FontWeight.normal),
      hintText: hintText,
      hintStyle: TextStyle(
          overflow: TextOverflow.ellipsis,
          color: CustomColors().lightblueColor,
          fontSize: 17,
          fontWeight: FontWeight.normal),
      prefixIcon: prefixIcon,
      prefixIconConstraints: prefixIcon != null
          ? const BoxConstraints(
              minWidth: 30,
              minHeight: 30,
            )
          : const BoxConstraints(),
      suffixIcon: suffixIcon != null
          ? IconButton(
              icon: Icon(
                suffixIcon,
                color: CustomColors().lightblueColor,
                size: 20,
              ),
              color: CustomColors().lightblueColor,
              onPressed: onPressed,
              iconSize: 20,
            )
          : null,
    );
  }
}