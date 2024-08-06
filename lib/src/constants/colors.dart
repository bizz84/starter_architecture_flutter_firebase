import 'package:flutter/material.dart' show Color;
import 'package:hexcolor/hexcolor.dart' show HexColor;

enum ColorPattern { green, blue, red, gray }

Map<Color, ColorPattern> colorPatternMap = {
  CustomColors().chargerGreen: ColorPattern.green,
  CustomColors().chargerBlue: ColorPattern.blue,
  CustomColors().chargerRed: ColorPattern.red,
  CustomColors().darkGrayBG: ColorPattern.gray,
};

/// Stores Custom Theme colors
class CustomColors {
  Color get red => HexColor('#CE0B00');

  /// Hamburger menu BG
  Color get darkMenuBG => const Color.fromARGB(255, 58, 58, 60);

  Color get darkestGrayBG => HexColor('#00000000');

  /// Circular indicator paint on idle
  Color get lighterGrayText => HexColor('#FFCBCBCB');

  /// Circular indicator paint BG on idle
  Color get lightGrayText => HexColor('#FF727272');

  /// - Bottom Nav. Bar BG
  Color get darkGrayBG => HexColor('#A6545458');

  Color get darkerGrayBG => HexColor('#993B383E');

  /// - Bottom Nav. Bar inactive text
  Color get darkGrayText => HexColor('#999999');

  /// - Bottom Nav. Bar active item/text
  Color get primaryTextColor => HexColor('#D0BCFF');

  /// - Remove Household Button BG
  Color get secondaryButtonBG => HexColor('#EFB8C8');
  // Color get primaryButtonTextColor => HexColor("#381E72");
  Color get secondaryButtonTextColor => HexColor('#381E72');

  /// Charger green
  Color get chargerGreen => HexColor('#00FF1A');
  Color get buttonGreen => HexColor('#33C542');

  ///Charger blue
  Color get chargerBlue => HexColor('#02B0F0');

  /// Charger orange
  Color get chargerRed => HexColor('#ED5601');
  Color get chargerGray => HexColor('#FFFFFF');

  /// Circular indicator
  Color get circularIndicatorBG => HexColor('#002A25'); //#002A25//#007568//#BDFF00//FD0000

  Color get vehicleBlueMask => HexColor('#CDE8E1');
  Color get vehicleRedMask => HexColor('#ED5601');
  Color get vehicleGreenMask => HexColor('#86FE16');

  /// Gauge colors

  Color get batteryRed => HexColor('FFFD0000');
  Color get batteryOrange => HexColor('#FFBDFF00');
  // Color get batteryOrangishYellow => HexColor('#FF007568');
  Color get batteryGreen => HexColor('#00FF38');
  Color get batteryYellowishGreen => HexColor('#D9FD00');
  Color get darkGray => HexColor("#1C1C1E");
  Color get grayColor => const Color.fromRGBO(84, 84, 88, 0.65);

  Color get lightblueColor => HexColor("#D0BCFF"); /* primarybuttonBGcolor, hinttextcolor, actiontextbuttoncolor */
  Color get darkblueColor => HexColor("#381E72"); /*primarybuttontextcolor*/
  Color get whitecolor => HexColor("#FFFFFF"); /* TextColor*/
  Color get lightGrayColor => HexColor('#3A3A3C'); // Card background color
  Color get darkelevatedColor => HexColor("#3A3A3C");

  Color get lightredColor => HexColor("#EFB8C8");

  Color get secondaryDark =>const Color.fromRGBO(235, 235, 245, 0.6);
  Color get progressBarFilledColor => primaryTextColor;
  Color get progressBarInactiveColor => HexColor('#ffbababa');
  Color get blueColor => HexColor("02B0F0"); //Manual schedule available hours color
  Color get blackColor => HexColor("38383A"); // Not avilable hours color

  /// Reports Page
  Color get reportBarBlue => HexColor('#02B0F0');
  Color get reportBarGray => HexColor('#EBEBF5');
  Color get reportByButtonBG => HexColor('#4A4458');
  Color get tableBorderColor => HexColor('#99EBEBF5');

  ///Setup flow
  Color get setUpText => HexColor("#CCC2DC");

  ///close icon
  Color get bgCloseIcon =>  const Color.fromRGBO(127, 127, 127, 0.5);
  Color get closeIcon => const Color.fromRGBO(141, 135, 135, 1);

  // dialog color
    Color get materialGrayBG => HexColor('#FF3B383E');
}
