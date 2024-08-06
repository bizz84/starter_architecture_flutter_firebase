import 'package:flutter_starter_base_app/src/common_widgets/action_text_button.dart';
import 'package:flutter_starter_base_app/src/common_widgets/basic_page_importer.dart';
import 'package:flutter_starter_base_app/src/common_widgets/circular_loading_animation.dart';
import 'package:flutter_starter_base_app/src/common_widgets/custom_stepper.dart';
import 'package:flutter_starter_base_app/src/common_widgets/primary_button.dart';
import 'package:flutter_starter_base_app/src/features/account/domain/create_account.dart';
import 'package:flutter_starter_base_app/src/features/account/presentation/add_account_page.dart';
import 'package:flutter_starter_base_app/src/features/account/presentation/username_password_page.dart';
import 'package:flutter_starter_base_app/src/features/account/presentation/default_contact_info_page.dart';
import 'package:flutter_starter_base_app/src/features/account/presentation/eula_view.dart';
import 'package:flutter_starter_base_app/src/utils/authentication_handler.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_starter_base_app/src/localization/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class AddAccountFLow extends ConsumerStatefulWidget {
  const AddAccountFLow({super.key});

  @override
  ConsumerState createState() => _AddAccountFLowState();
}

class _AddAccountFLowState extends ConsumerState<AddAccountFLow> {
  List<Widget> pages = [];
  int currentStep = 0;
  PageController pageController = PageController();
  bool complete = false;
  String title = LocaleKeys.account_wizard_title.tr();
  bool isAccountCreated = false;
  bool isHouseholdStepComplete = false;
  PricingMethodType? pricingMethod;
  String selectedUtility = "";
  String selectedRateProgram = "";
  var selectedCustomRate;
  bool pricingMethodavailable = false;
  bool utilityrateavailable = false;
  bool rateprogrameavailble = false;
  bool customrateavailble = false;
  bool ispricingSelecte = false;
  final GlobalKey<FormState> _createaccountformKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _createaccounthouseholdformKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _createaccounthouseholdadressformKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _createinfoformKey = GlobalKey<FormState>();
// / Controllers for Create Account form
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  //  Controllers for Create Household form
  TextEditingController nameController = TextEditingController();
  //  Controllers for Create Household Address form
  TextEditingController streetController = TextEditingController();
  TextEditingController street1Controller = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  // Controller for Info form
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  PricingMethodStep currentPricingMethodStep = PricingMethodStep.methodChooser;
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: currentStep);
    updateTitle(currentStep);
  }

  @override
  Widget build(BuildContext context) {
    pages = [
      const AddAccountPage(),
      UsernameandPasswordPage(
        formKey: _createaccountformKey,
        usernameController: usernameController,
        passwordController: passwordController,
        confirmPasswordController: confirmPasswordController,
      ),
      DefaultContactInfoPage(
        formKey: _createinfoformKey,
        emailController: emailController,
        phoneNumberController: phoneNumberController,
      ),
      isHouseholdStepComplete
          ? CreateHouseholdAddressPage(
              formKey: _createaccounthouseholdadressformKey,
              streetAccountController: streetController,
              street1AccountController: street1Controller,
              cityAccountController: cityController,
              zipcodeAccountController: zipCodeController,
              countryAccountController: countryController,
              stateAccountController: stateController,
            )
          : CreateHouseHoldNamePage(
              formKey: _createaccounthouseholdformKey,
              accountnameController: nameController,
            ),
      getPricingMethodWidget(),
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: CustomColors().whitecolor),
        ),
        actions: [
          GestureDetector(
              child: Container(
                height: 24,
                width: 24,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 0),
                  color: CustomColors().bgCloseIcon,
                ),
                child: Icon(
                  Icons.close_rounded,
                  size: 16,
                  color: CustomColors().closeIcon,
                ),
              ),
              onTap: () => context.canPop() ? context.pop() : null),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: CustomStepper(
                totalSteps: pages.length,
                width: MediaQuery.of(context).size.width,
                curStep: currentStep + 1,
                stepCompleteColor: CustomColors().progressBarFilledColor,
                currentStepColor: CustomColors().whitecolor,
                inactiveColor: CustomColors().progressBarInactiveColor,
                lineWidth: 0.7,
                pageController: pageController,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                itemCount: pages.length,
                onPageChanged: (index) {
                  setState(() {
                    currentStep = index;
                    updateTitle(currentStep);
                  });
                },
                itemBuilder: (context, index) {
                  return pages[index];
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  currentStep == 0
                      ? PrimaryButton(
                          backgroundColor: CustomColors().lightblueColor,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return EulaView(
                                  onEULAAccepted: (bool acceptEULA) {
                                    if (mounted && context.canPop()) context.pop();
                                    if (acceptEULA) {
                                      goTo(1); // Navigate to the next step
                                    }
                                  },
                                );
                              },
                            );
                          },
                          text: LocaleKeys.common_start.tr(),
                        )
                      : PrimaryButton(
                          backgroundColor: CustomColors().lightblueColor,
                          text: getButtonLabel(),
                          onPressed: next,
                        ),
                  const SizedBox(width: 10),
                  ActionTextButton(
                    onPressed: currentStep == 0 ? () => context.pop(true) : back,
                    text: currentStep == 0 ? LocaleKeys.common_cancel.tr() : LocaleKeys.common_back.tr(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getPricingMethodWidget() {
    switch (currentPricingMethodStep) {
      case PricingMethodStep.utilityChooser:
        return UtilityChooser(
          zipCode: zipCodeController.text,
          showappbar: false,
          onUtilitySelected: (utility) {
            setState(() {
              selectedUtility = utility;
              ref.read(utilityProvider.notifier).selectUtility(utility);
            });
          },
        );
      case PricingMethodStep.rateProgramChooser:
        return RateProgramChooser(
          showappbar: false,
          onRateProgramSelected: (rateProgram) {
            setState(() {
              selectedRateProgram = rateProgram;
              ref.read(rateProgramProvider.notifier).state = rateProgram;
            });
          },
        );
      case PricingMethodStep.customRateChooser:
        return CustomRateChooser(
          onRateEntered: (rate) {
            setState(() {
              print("Parent received rate: $rate"); // Debug statement
              selectedCustomRate = rate;
              ref.read(customRateProvider.notifier).state = rate;
            });
          },
        );
      default:
        return AccountPricingMethodChooser(
          onMethodSelected: (PricingMethodType method) {
            setState(() {
              pricingMethod = method;
            });
          },
          onNext: next,
        );
    }
  }

  void back() {
    if (currentStep == 4) {
      if (currentPricingMethodStep == PricingMethodStep.utilityChooser) {
        setState(() {
          currentPricingMethodStep = PricingMethodStep.methodChooser;
        });
      } else if (currentPricingMethodStep == PricingMethodStep.rateProgramChooser) {
        setState(() {
          currentPricingMethodStep = PricingMethodStep.utilityChooser;
        });
      } else if (currentPricingMethodStep == PricingMethodStep.customRateChooser) {
        setState(() {
          currentPricingMethodStep = PricingMethodStep.methodChooser;
        });
      } else {
        goTo(currentStep - 1);
      }
    } else if (currentStep > 0) {
      if (currentStep == 3 && isHouseholdStepComplete) {
        setState(() {
          isHouseholdStepComplete = false;
        });
      } else {
        goTo(currentStep - 1);
      }
    }
  }

  void goTo(int step) {
    setState(() {
      currentStep = step;
    });
    pageController.animateToPage(
      step,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
    updateTitle(step);
  }

  Future<void> next() async {
    bool isValid = true;

    if (currentStep == 1) {
      isValid = _createaccountformKey.currentState!.validate();
      if (isValid) {
        _createaccountformKey.currentState!.save();
      }
    }
    if (currentStep == 2) {
      isValid = _createinfoformKey.currentState!.validate();
      if (isValid) {
        _createinfoformKey.currentState!.save();
        await createAccount(context, ref);
        if (!isAccountCreated) {
          return;
        }
      }
    }
    if (currentStep == 3 && isAccountCreated) {
      if (!isHouseholdStepComplete) {
        isValid = _createaccounthouseholdformKey.currentState!.validate();
        if (isValid) {
          _createaccounthouseholdformKey.currentState!.save();
          setState(() {
            isHouseholdStepComplete = true;
          });
          return;
        }
      } else {
        isValid = _createaccounthouseholdadressformKey.currentState!.validate();
        if (isValid) {
          _createaccounthouseholdadressformKey.currentState!.save();
          goTo(currentStep + 1);
          return;
        }
      }
    }

    if (currentStep == 4) {
      if (pricingMethod == null) {
        isValid = false;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a pricing method.'),
          ),
        );
      } else {
        ispricingSelecte = true;
        if (pricingMethod == PricingMethodType.utilityRates) {
          if (currentPricingMethodStep == PricingMethodStep.utilityChooser && selectedUtility == '') {
            isValid = false;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please select a utility company.'),
              ),
            );
          } else if (currentPricingMethodStep == PricingMethodStep.rateProgramChooser && selectedRateProgram == '') {
            isValid = false;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please select a rate program.'),
              ),
            );
          }
        } else if (pricingMethod == PricingMethodType.manual) {
          if (currentPricingMethodStep == PricingMethodStep.customRateChooser && selectedCustomRate == null) {
            isValid = false;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please enter a custom rate.'),
              ),
            );
          }
        }
      }
    }
    if (isValid) {
      if (currentStep == 4 && ispricingSelecte) {
        if (pricingMethod == PricingMethodType.utilityRates) {
          if (currentPricingMethodStep == PricingMethodStep.methodChooser) {
            setState(() {
              currentPricingMethodStep = PricingMethodStep.utilityChooser;
            });
          } else if (currentPricingMethodStep == PricingMethodStep.utilityChooser && selectedUtility.isNotEmpty) {
            setState(() {
              currentPricingMethodStep = PricingMethodStep.rateProgramChooser;
            });
          } else if (currentPricingMethodStep == PricingMethodStep.rateProgramChooser &&
              selectedRateProgram.isNotEmpty) {
            createHouseholdDetails();
          }
        } else if (pricingMethod == PricingMethodType.manual) {
          if (currentPricingMethodStep == PricingMethodStep.methodChooser) {
            setState(() {
              currentPricingMethodStep = PricingMethodStep.customRateChooser;
            });
          } else if (currentPricingMethodStep == PricingMethodStep.customRateChooser && selectedCustomRate != null) {
            createHouseholdDetails();
          }
        } else if (pricingMethod == PricingMethodType.chargerEstimatesCost) {
          createHouseholdDetails();
        } else {
          createHouseholdDetails();
        }
      }
      if (isValid && (currentStep < pages.length - 1)) {
        goTo(currentStep + 1);
      } else if (isValid && currentStep == pages.length - 1) {
        createHouseholdDetails();
      }
    }
  }

  String getButtonLabel() {
    if (currentStep == 4) {
      if (currentPricingMethodStep == PricingMethodStep.methodChooser && pricingMethod == null) {
        return pricingMethod == null ? 'Next' : 'Next';
      } else if (pricingMethod == PricingMethodType.utilityRates &&
          selectedUtility.isEmpty &&
          selectedRateProgram.isEmpty) {
        return 'Next';
      } else if (PricingMethodType == PricingMethodType.utilityRates) {
        return 'Next';
      } else if (currentPricingMethodStep == PricingMethodStep.utilityChooser) {
        return 'Next';
      } else if (currentPricingMethodStep == PricingMethodStep.rateProgramChooser) {
        return 'Finish';
      } else if (currentPricingMethodStep == PricingMethodStep.customRateChooser) {
        return 'Finish';
      } else if (pricingMethod == PricingMethodType.manual && selectedCustomRate == null) {
        return 'Next';
      } else if (pricingMethod == PricingMethodType.chargerEstimatesCost) {
        return 'Finish';
      }
    }
    return currentStep == pages.length - 1 ? 'Next' : 'Next';
  }

  /// creating account

  Future<void> createAccount(BuildContext context, WidgetRef ref) async {
    final username = usernameController.text;
    final password = passwordController.text;
    final email = emailController.text;
    final phoneNumber = phoneNumberController.text;

    final createAccountData = CreateAccountRequest(
      username: username,
      email: email,
      password: password,
      phoneNumber: "+${phoneNumber}",
      languageCode: "en-US",
    );

    try {
      final response =
          await ref.read(createAccountProvider(createAccountRequest: createAccountData).future).then((response) {
        if (response.status == 'success') {
          attemptLogin(context, username: username, password: password);

          clearAccountFields();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response.message)),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response.message)),
          );
        }
      });
    } catch (e) {
      String errorMessage = 'Failed to create account. Please try again.';
      if (e is DioException && e.response != null && e.response?.data != null) {
        final responseData = e.response?.data;
        print('Error response domain: $responseData');

        if (responseData is Map<String, dynamic> && responseData.containsKey('message')) {
          final dynamic message = responseData['message'];
          errorMessage = message != null ? message.toString() : errorMessage;
        }
      }
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  Future<void> attemptLogin(BuildContext context, {required String username, required String password}) async {
    try {
      await ref.read(loginProvider(username: username, password: password).future);
      if (context.mounted && (await AuthenticationHandler().canAuthenticateUser())) {
        setState(() => isAccountCreated = true);
        if (kDebugMode) print("Login successful");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Cannot login at this moment.')));
      }
    } catch (e) {
  String errorMessage = 'Failed to Login. Please try again.';
 ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(errorMessage)),
  );
}
  }

  Future<void> createHouseholdDetails() async {
    final householdName = nameController.text;
    final homeAddress = HouseAddress(
      streetAddressFirstLine: streetController.text,
      streetAddressSecondLine: street1Controller.text,
      city: cityController.text,
      state: stateController.text,
      zipCode: zipCodeController.text,
      country: countryController.text,
    );
    PricingMethod? chargePricingMethod;
    if (pricingMethod == PricingMethodType.utilityRates) {
      chargePricingMethod = PricingMethod(
        type: PricingMethodType.utilityRates,
        utilityCompany: selectedUtility,
        rateProgram: selectedRateProgram,
      );
    } else if (pricingMethod == PricingMethodType.manual) {
      chargePricingMethod = const PricingMethod(
        type: PricingMethodType.manual,
      );
    } else if (pricingMethod == PricingMethodType.chargerEstimatesCost) {
      chargePricingMethod = const PricingMethod(
        type: PricingMethodType.chargerEstimatesCost,
      );
    } else {
      throw Exception("Invalid pricing method selected");
    }

    try {
      ref
          .read(createHouseholdDetailsProvider(
            householdName: householdName,
            homeAddress: homeAddress,
            chargePricingMethod: chargePricingMethod,
          ))
          .when(
            data: (data) {
              if (data.status == 'success') {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${data.message}'),
                    ),
                  );
                  clearTextFields();
                  clearSelections();
                  if (context.canPop()) context.pop(true);
                }
              }
            },
            error: (error, _) {
              WidgetsBinding.instance.addPostFrameCallback((_) => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(backgroundColor: CustomColors().darkestGrayBG, content: Center(child: Text('$error')))));
              return Container();
            },
            loading: () => const LoadingAnimation(),
          );
      if (context.canPop()) context.pop(true);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to create household. Please try again.'),
          ),
        );
      }
    }
  }

  void updateTitle(int step) {
    setState(() {
      switch (step) {
        case 0:
          title = LocaleKeys.account_wizard_title.tr();
          break;
        case 1:
          title = LocaleKeys.account_wizard_title.tr();

          break;
        case 2:
          title = LocaleKeys.household_wizard_title.tr();
          break;
        case 3:
          title = LocaleKeys.household_wizard_title.tr();
          break;
        case 4:
          title = LocaleKeys.account_wizard_title.tr();
          break;
        default:
          title = LocaleKeys.account_wizard_title.tr();
          break;
      }
    });
  }

  void clearAccountFields() {
    usernameController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    emailController.clear();
    phoneNumberController.clear();
  }

  void clearTextFields() {
    nameController.clear();
    streetController.clear();
    street1Controller.dispose();
    cityController.clear();
    stateController.clear();
    zipCodeController.clear();
    countryController.clear();
  }

  void clearSelections() {
    setState(() {
      pricingMethod = null;
      selectedUtility = "";
      selectedRateProgram = "";
      selectedCustomRate = null;
      ref.read(utilityProvider.notifier).selectUtility("");
      ref.read(rateProgramProvider.notifier).state = null;
      ref.read(customRateProvider.notifier).state = {};

      currentPricingMethodStep = PricingMethodStep.methodChooser;
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    nameController.dispose();
    streetController.dispose();
    street1Controller.dispose();
    cityController.dispose();
    stateController.dispose();
    countryController.dispose();
    super.dispose();
  }
}
