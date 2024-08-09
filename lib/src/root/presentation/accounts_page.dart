import 'package:flutter_starter_base_app/src/common_widgets/basic_page_importer.dart';
import 'package:flutter_starter_base_app/src/common_widgets/circular_loading_animation.dart';
import 'package:flutter_starter_base_app/src/common_widgets/primary_button.dart';
import 'package:flutter_starter_base_app/src/common_widgets/subsection_title.dart';
import 'package:flutter_starter_base_app/src/features/account/data/account_provider.dart';
import 'package:flutter_starter_base_app/src/localization/generated/locale_keys.g.dart';
import 'package:flutter_starter_base_app/src/routing/routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:ui' as ui;
import 'package:go_router/go_router.dart';

class AccountDetailsPage extends ConsumerStatefulWidget {
  const AccountDetailsPage({super.key});

  @override
  ConsumerState<AccountDetailsPage> createState() => _AccountDetailsPageState();
}

class _AccountDetailsPageState extends ConsumerState<AccountDetailsPage> {
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isEditingPhone = false;
  bool isEditingEmail = false;

  Future<void> _saveAccountDetails({required String phoneNumber, required String emailId}) async {
    try {
      final future = ref.read(saveAccountDetailsProvider(emailId: emailId, phoneNumber: phoneNumber).future);

      future.then((response) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Center(child: Text(response.message)),
          ),
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Center(child: Text('Error: $error')),
          ),
        );
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: CustomColors().darkestGrayBG,
          content: Center(child: Text('Failed to save account details: $e')),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final accountDetailsAsync = ref.watch(fetchAccountDetailsProvider);

    return Scaffold(
      appBar: CustomAppBar(
          titleWidget: Text(LocaleKeys.common_account.tr(),
              style: DefaultTheme().defaultTextStyle(20).copyWith(fontWeight: FontWeight.w500))),
      body: accountDetailsAsync.when(
        loading: () => const Scaffold(
            body: Directionality(
                textDirection: ui.TextDirection.ltr,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text('Loading Account Details'), LoadingAnimation()]))),
        error: (error, stack) {
          return Center(child: Text('Error: $error'));
        },
        data: (accountDetails) {
          phoneNumberController.text = accountDetails.phoneNumber;
          emailController.text = accountDetails.emailId;
          return Form(
              key: _formKey,
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        SubSectionTitle(text: LocaleKeys.account_wizard_contactInformationDesc.tr().toUpperCase()),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isEditingPhone = !isEditingPhone;
                            });
                          },
                          child: Container(
                            height: 44,
                            decoration: BoxDecoration(
                              color: CustomColors().grayColor,
                              border: Border(
                                bottom: BorderSide(
                                  color: CustomColors().grayColor,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16.0, right: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    LocaleKeys.account_phoneNumber.tr(),
                                    style: TextStyle(
                                      color: CustomColors().whitecolor,
                                      fontSize: 17,
                                    ),
                                  ),
                                  if (isEditingPhone)
                                    Expanded(
                                      child: TextFormField(
                                        controller: phoneNumberController,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: CustomColors().secondaryDark,
                                          fontSize: 17,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: LocaleKeys.hint_phoneNumber.tr(),
                                          hintStyle: TextStyle(
                                            color: CustomColors().secondaryDark,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                        keyboardType: TextInputType.phone,
                                        onChanged: (value) {
                                          setState(() {
                                            accountDetails.phoneNumber = value;
                                          });
                                        },
                                        onEditingComplete: () {
                                          if (_formKey.currentState!.validate()) {
                                            _saveAccountDetails(
                                              phoneNumber: accountDetails.phoneNumber,
                                              emailId: accountDetails.emailId,
                                            );
                                            setState(() {
                                              isEditingPhone = false;
                                            });
                                          }
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter a phone number';
                                          }
                                          final phoneRegExp = RegExp(r'^\d{10}$');
                                          if (!phoneRegExp.hasMatch(value)) {
                                            return 'Please enter a valid 10-digit phone number';
                                          }
                                          return null;
                                        },
                                      ),
                                    )
                                  else
                                    Expanded(
                                      child: Text(
                                        accountDetails.phoneNumber,
                                        maxLines: 1,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: CustomColors().secondaryDark,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isEditingEmail = !isEditingEmail;
                            });
                          },
                          child: Container(
                            height: 44,
                            decoration: BoxDecoration(
                              color: CustomColors().grayColor,
                              border: Border(
                                bottom: BorderSide(
                                  color: CustomColors().grayColor,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16.0, right: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    LocaleKeys.account_email.tr(),
                                    style: TextStyle(
                                      color: CustomColors().whitecolor,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Icon(
                                      Icons.help_rounded,
                                      color: CustomColors().lightblueColor,
                                      size: 15,
                                    ),
                                  ),
                                  // Spacer(),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  if (isEditingEmail)
                                    Expanded(
                                      child: TextFormField(
                                        controller: emailController,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: CustomColors().secondaryDark,
                                          fontSize: 17,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: 'Enter email',
                                          hintStyle: TextStyle(
                                            color: CustomColors().secondaryDark,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                        keyboardType: TextInputType.emailAddress,
                                        onChanged: (value) {
                                          setState(() {
                                            accountDetails.emailId = value;
                                          });
                                        },
                                        onEditingComplete: () {
                                          if (_formKey.currentState!.validate()) {
                                            _saveAccountDetails(
                                                phoneNumber: accountDetails.phoneNumber,
                                                emailId: accountDetails.emailId);
                                            setState(() {
                                              isEditingEmail = false;
                                            });
                                          }
                                        },
                                        validator: (value) =>
                                            EmailValidator.validate(value ?? '') ? null : "Please enter a valid email",
                                      ),
                                    )
                                  else
                                    Expanded(
                                      child: Text(
                                        accountDetails.emailId,
                                        textAlign: TextAlign.right,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: CustomColors().secondaryDark,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            final result = await context.push<bool>(
                              '/${AppRoute.addHousehold.name}',
                            );

                            if (result == true) {
                              ref.invalidate(fetchAccountDetailsProvider);
                              ref.read(fetchAccountDetailsProvider);
                              debugPrint("refresh = ");
                            }
                          },
                          child: Container(
                            height: 44,
                            decoration: BoxDecoration(color: CustomColors().grayColor),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.add_circle,
                                    color: CustomColors().lightblueColor,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      LocaleKeys.btn_addHousehold.tr(),
                                      style: TextStyle(
                                        color: CustomColors().lightblueColor,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            final result = await context.push<bool>(
                              '/${AppRoute.addVehicle.name}',
                            );

                            if (result == true) {
                              ref.invalidate(fetchAccountDetailsProvider);
                              ref.read(fetchAccountDetailsProvider);
                              debugPrint("refresh = ");
                            }
                          },
                          child: Container(
                            height: 44,
                            decoration: BoxDecoration(color: CustomColors().grayColor),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.add_circle,
                                    color: CustomColors().lightblueColor,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      LocaleKeys.vehicle_wizard_addVehicleTitle.tr(),
                                      style: TextStyle(
                                        color: CustomColors().lightblueColor,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        PrimaryButton(
                          onPressed: () => context.goNamed(AppRoute.logoutPageTransition.name),
                          backgroundColor: CustomColors().lightblueColor,
                          text: LocaleKeys.btn_logout.tr(),
                        ),
                      ],
                    ),
                  ),
                ],
              ));
        },
      ),
    );
  }
}
