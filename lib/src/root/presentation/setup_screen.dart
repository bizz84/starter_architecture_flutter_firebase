import 'package:flutter_starter_base_app/src/common_widgets/action_text_button.dart';
import 'package:flutter_starter_base_app/src/common_widgets/basic_page_importer.dart';
import 'package:flutter_starter_base_app/src/localization/generated/locale_keys.g.dart';
import 'package:flutter_starter_base_app/src/routing/routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key});

  @override
  SetupScreenState createState() => SetupScreenState();
}

class SetupScreenState extends State<SetupScreen> {
  int _completedStep = -1;

  @override
  void initState() {
    super.initState();
    _loadCompletedStep();
  }

  Future<void> _loadCompletedStep() async {
    _completedStep = (await SharedPreferences.getInstance()).getInt('completedStep') ?? -1;
    setState(() {});
  }

  Future<void> _saveCompletedStep(int step) async =>
      (await SharedPreferences.getInstance()).setInt('completedStep', step);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          titleWidget: Text(LocaleKeys.oob_setup.tr()),
          showHamburgerMenu: false,
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(LocaleKeys.oob_setupGuideline.tr(),
                      style: TextStyle(fontSize: 18, color: CustomColors().whitecolor), textAlign: TextAlign.center)),
              const SizedBox(height: 20),
              _buildSetupBox(0, LocaleKeys.account_wizard_title.tr(), LocaleKeys.oob_accountWizDesc.tr()),
              const SizedBox(height: 10),
              _buildSetupBox(1, LocaleKeys.charger_wizard_addChargerTitle.tr(), LocaleKeys.oob_chargerWizDesc.tr()),
              const SizedBox(height: 10),
              _buildSetupBox(2, LocaleKeys.vehicle_wizard_addVehicleTitle.tr(), LocaleKeys.oob_vehicleWizDesc.tr()),
              const Spacer(),
              Center(
                  child: ActionTextButton(
                      text: LocaleKeys.common_cancel.tr(), onPressed: () => context.goNamed(AppRoute.splash.name)))
            ])));
  }

  Widget _buildSetupBox(int index, String title, String subtitle) {
    bool isCompleted = index <= _completedStep;
    bool isNextStep = index == _completedStep + 1;
    Color boxColor;
    Color textColor;
    IconData icon;

    if (isCompleted) {
      boxColor = CustomColors().reportByButtonBG;
      textColor = CustomColors().setUpText;
      icon = Icons.check;
    } else if (isNextStep) {
      boxColor = CustomColors().primaryTextColor;
      textColor = CustomColors().secondaryButtonTextColor;
      icon = Icons.arrow_forward;
    } else {
      boxColor = CustomColors().lightGrayColor;
      textColor = CustomColors().secondaryDark;
      icon = Icons.arrow_forward;
    }

    return GestureDetector(
        onTap: () async {
          dynamic result;
          switch (index) {
            case 0:
              result = await context.pushNamed(AppRoute.addAccount.name);
            case 1:
              result = await context.pushNamed(AppRoute.addCharger.name);
            case 2:
              result = await context.pushNamed(AppRoute.addVehicle.name);
          }

          if (result == true) {
            setState(() => _completedStep = index);
            _saveCompletedStep(index);
            if (index == 2 && mounted) context.pushReplacementNamed(AppRoute.setupComplete.name);
          }
        },
        child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(color: boxColor),
            child: Row(children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textColor)),
                const SizedBox(height: 4),
                Text(subtitle, style: TextStyle(fontSize: 14, color: textColor))
              ]),
              const Spacer(),
              Icon(icon, color: textColor, size: 30)
            ])));
  }
}
