import 'package:flutter/material.dart';
import 'package:flutter_starter_base_app/src/constants/colors.dart';

/// https://www.mokoblue.com/measures-of-bluetooth-rssi/
/// >>> For example, a pretty good value is below -50, a fairly reasonable value is between -70 to -80, while -100 indicates no signal at all.
// https://www.metageek.com/training/resources/understanding-rssi/
class ReceptionIcon extends StatelessWidget {
  final int level;
  const ReceptionIcon({super.key, required this.level});
  @override
  Widget build(BuildContext context) => switch (level) {
        < -80 => Icon(Icons.wifi_1_bar, color: CustomColors().primaryTextColor),
        < -60 => Icon(Icons.wifi_2_bar, color: CustomColors().primaryTextColor),
        _ => Icon(Icons.wifi, color: CustomColors().primaryTextColor)
      };
}
