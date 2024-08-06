import 'package:flutter_starter_base_app/src/common_widgets/app_bar.dart';
import 'package:flutter_starter_base_app/src/constants/colors.dart';
import 'package:flutter/material.dart';

class SelectTimeWidget extends StatelessWidget {
  const SelectTimeWidget({super.key, this.pageTitle, this.initialTime});

  final String? pageTitle;
  final TimeOfDay? initialTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors().darkGray,
      appBar: CustomAppBar(
          showBackButton: true,
          titleWidget: Text(pageTitle != null ? pageTitle! : "Alert Time"),
          showHamburgerMenu: false),
      body: Column(
        children: [
          const SizedBox(height: 5),
          TimePickerDialog(
            initialTime: initialTime ?? TimeOfDay.now(),
          ),
        ],
      ),
    );
  }
}
