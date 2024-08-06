import 'package:flutter_starter_base_app/src/constants/colors.dart';
import 'package:flutter_starter_base_app/src/constants/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_base_app/src/localization/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class AddAccountPage extends ConsumerWidget {
  const AddAccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(children: [
                Container(
          color: primaryColor,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.10,
              ),
              Image.asset("assets/images/house.png"),
              Padding(
                padding:
                  const  EdgeInsets.only(left: 50.0, right: 50, top: 50, bottom: 10),
                child: Text(
                    LocaleKeys.account_wizard_welcomeDesc.tr(),
                  textAlign: TextAlign.start,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: CustomColors().whitecolor,
                      fontSize: 17,
                      fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.10,
              ),
            ],
          ),
                )
              ]),
        ));
  }
}
