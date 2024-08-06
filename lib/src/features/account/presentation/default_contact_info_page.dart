import 'package:flutter_starter_base_app/src/common_widgets/basic_page_importer.dart';
import 'package:flutter_starter_base_app/src/common_widgets/custom_text_form_field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DefaultContactInfoPage extends ConsumerStatefulWidget {
  final GlobalKey<FormState>? formKey;
  final TextEditingController emailController;
  final TextEditingController phoneNumberController;
  const DefaultContactInfoPage(
      {required this.formKey, required this.emailController, required this.phoneNumberController, super.key});
  @override
  _DefaultContactInfoPageState createState() => _DefaultContactInfoPageState();
}

class _DefaultContactInfoPageState extends ConsumerState<DefaultContactInfoPage> {
  FocusNode _emailfocusNode = FocusNode();
  FocusNode _passwordfocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _emailfocusNode = FocusNode();
    _passwordfocusNode = FocusNode();
  }
  @override
  void dispose() {
    _emailfocusNode.dispose();
    _passwordfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailActiveController = widget.emailController;
    final TextEditingController phoneNumberActiveController = widget.phoneNumberController;
       return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: widget.formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                child: Text(
                  "Default Contact Information",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: CustomColors().whitecolor),
                ),
              ),
              phoneNumberTextField(context, phoneNumberActiveController),
              emailTextField(context, emailActiveController)
            ],
          ),
        ),
      ),
    );
  }

  CustomTextFormField phoneNumberTextField(BuildContext context, TextEditingController controller) {
    return CustomTextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      focusNode: _emailfocusNode,
      textInputType: TextInputType.number,
      hintText: "Enter Phone Number",
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Phone Number',
              style: TextStyle(
                  color: CustomColors().whitecolor,
                  fontWeight: FontWeight.w400,
                  fontSize: 17),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.02,
            ),
            Icon(
              Icons.help,
              color: CustomColors().whitecolor,
            )
          ],
        ),
      ),
       inputFormatter: FilteringTextInputFormatter.digitsOnly,    
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Phone Number  can't be empty";
        }
        // if (value.length < 10) {
        //   return "Phone Number must be  10 characters";
        // }
        // if (value.length > 10) {
        //   return "Phone Number can't be more than 10 characters";
        // }
        return null;
      },
      onSaved: (value) {},
    );
  }

  CustomTextFormField emailTextField(BuildContext context, TextEditingController controller) {
    return CustomTextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      focusNode: _emailfocusNode,
      textInputType: TextInputType.emailAddress,
      hintText: "Enter Email",
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Email',
              style: TextStyle(
                   color: CustomColors().whitecolor,
                  fontWeight: FontWeight.w400,
                  fontSize: 17),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.02,
            ),
            Icon(
              Icons.help,
              color: CustomColors().whitecolor,
            )
          ],
        ),
      ),
      validator: (value) => EmailValidator.validate(value ?? '') ? null : "Please enter a valid email",
    );
  }
}
