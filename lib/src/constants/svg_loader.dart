import 'package:flutter_starter_base_app/src/constants/colors.dart';
import 'package:flutter_starter_base_app/src/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' hide Svg;

class SVGLoader {
  final String _bottomAppBarAssetPath = 'assets/bottom_navigation_bar/';
  final String _vehicleIconPath = 'assets/vehicle_icon/';
  final String _smallChargerIconPath = 'assets/charger_icon/small/';
  final String _redsPath = 'assets/charger_icon/red/';
  final String _bluesPath = 'assets/charger_icon/blue/';
  final String _graysPath = 'assets/charger_icon/gray/';
  final String _greensPath = 'assets/charger_icon/green/';
  final String _detailIconPath = 'assets/detail_icon/';
  final String _chargerSetupIconPath = 'assets/setup_charger/';
  final String _dongleSetupIconPath = 'assets/setup_dongle/';

  /// ----- Bottom Bar Icons -----
  Widget get accountIcon => SvgPicture.asset(
        '${_bottomAppBarAssetPath}account.svg',
        semanticsLabel: Strings.account,
        colorFilter: ColorFilter.mode(CustomColors().primaryTextColor, BlendMode.srcIn),
      );
  Widget get accountInactiveIcon => SvgPicture.asset(
        '${_bottomAppBarAssetPath}account.svg',
        semanticsLabel: Strings.account,
        colorFilter: ColorFilter.mode(CustomColors().darkGrayText, BlendMode.srcIn),
      );
  Widget get alertsIcon => SvgPicture.asset(
        '${_bottomAppBarAssetPath}alerts.svg',
        semanticsLabel: Strings.alerts,
        colorFilter: ColorFilter.mode(CustomColors().primaryTextColor, BlendMode.srcIn),
      );
  Widget get alertsInactiveIcon => SvgPicture.asset(
        '${_bottomAppBarAssetPath}alerts.svg',
        semanticsLabel: Strings.alerts,
        colorFilter: ColorFilter.mode(CustomColors().darkGrayText, BlendMode.srcIn),
      );
  Widget get homeIcon => SvgPicture.asset(
        '${_bottomAppBarAssetPath}home.svg',
        semanticsLabel: Strings.home,
        colorFilter: ColorFilter.mode(CustomColors().primaryTextColor, BlendMode.srcIn),
      );
  Widget get homeInactiveIcon => SvgPicture.asset(
        '${_bottomAppBarAssetPath}home.svg',
        semanticsLabel: Strings.home,
        colorFilter: ColorFilter.mode(CustomColors().darkGrayText, BlendMode.srcIn),
      );
  Widget get reportsIcon => SvgPicture.asset(
        '${_bottomAppBarAssetPath}reports.svg',
        semanticsLabel: Strings.reports,
        colorFilter: ColorFilter.mode(CustomColors().primaryTextColor, BlendMode.srcIn),
      );
  Widget get reportsInactiveIcon => SvgPicture.asset(
        '${_bottomAppBarAssetPath}reports.svg',
        semanticsLabel: Strings.reports,
        colorFilter: ColorFilter.mode(CustomColors().darkGrayText, BlendMode.srcIn),
      );
  Widget get scheduleIcon => SvgPicture.asset(
        '${_bottomAppBarAssetPath}schedule.svg',
        semanticsLabel: Strings.schedule,
        colorFilter: ColorFilter.mode(CustomColors().primaryTextColor, BlendMode.srcIn),
      );
  Widget get scheduleInactiveIcon => SvgPicture.asset(
        '${_bottomAppBarAssetPath}schedule.svg',
        semanticsLabel: Strings.schedule,
        colorFilter: ColorFilter.mode(CustomColors().darkGrayText, BlendMode.srcIn),
      );

  SvgPicture getVehicleIcon(String iconName, {ColorFilter? colorFilter}) =>
      SvgPicture.asset('${_vehicleIconPath + iconName}.svg',
          semanticsLabel: Strings.schedule, colorFilter: colorFilter);

  SvgPicture getSUVIcon({ColorFilter? colorFilter}) =>
      SvgPicture.asset('${_vehicleIconPath}suv.svg', semanticsLabel: Strings.schedule, colorFilter: colorFilter);

  /// ----- Vehicle Icons -----
  SvgPicture getMotoIcon({ColorFilter? colorFilter}) =>
      SvgPicture.asset('${_vehicleIconPath}motorcycle.svg', semanticsLabel: Strings.schedule, colorFilter: colorFilter);
  SvgPicture getLorryIcon({ColorFilter? colorFilter}) =>
      SvgPicture.asset('${_vehicleIconPath}van.svg', semanticsLabel: Strings.schedule, colorFilter: colorFilter);
  SvgPicture getSedanIcon({ColorFilter? colorFilter}) =>
      SvgPicture.asset('${_vehicleIconPath}sedan.svg', semanticsLabel: Strings.schedule, colorFilter: colorFilter);
  SvgPicture getPickupIcon({ColorFilter? colorFilter}) =>
      SvgPicture.asset('${_vehicleIconPath}pickup.svg', semanticsLabel: Strings.schedule, colorFilter: colorFilter);

  /// - Small
  Widget get smallRedChargerIcon => SvgPicture.asset('${_smallChargerIconPath}red.svg');
  Image get smallRedChargerGlow => Image.asset('${_smallChargerIconPath}red_glow.png', fit: BoxFit.cover);
  Widget get smallIdleChargerIcon => SvgPicture.asset('${_smallChargerIconPath}idle.svg');

  Widget get tinyRed => SvgPicture.asset('${_redsPath}tiny.svg');
  Image get tinyRedGlow => Image.asset('${_redsPath}tiny_glow.png', fit: BoxFit.cover);
  Widget get smallRed => SvgPicture.asset('${_redsPath}small.svg');
  Image get smallRedGlow => Image.asset('${_redsPath}small_glow.png', fit: BoxFit.cover);
  Widget get mediumRed => SvgPicture.asset('${_redsPath}medium.svg');
  Image get mediumRedGlow => Image.asset('${_redsPath}medium_glow.png', fit: BoxFit.cover);
  Widget get largeRed => SvgPicture.asset('${_redsPath}large.svg');
  Image get largeRedGlow => Image.asset('${_redsPath}large_glow.png', fit: BoxFit.cover);

  Widget get tinyGray => SvgPicture.asset('${_graysPath}tiny.svg');
  Widget get smallGray => SvgPicture.asset('${_graysPath}small.svg');
  Widget get mediumGray => SvgPicture.asset('${_graysPath}medium.svg');
  Widget get largeGray => SvgPicture.asset('${_graysPath}large.svg');
  Image get emptyGlow => Image.asset('${_graysPath}empty.png');

  Widget get tinyBlue => SvgPicture.asset('${_bluesPath}tiny.svg');
  Image get tinyBlueGlow => Image.asset('${_bluesPath}tiny_glow.png', fit: BoxFit.cover);
  Widget get smallBlue => SvgPicture.asset('${_bluesPath}small.svg');
  Image get smallBlueGlow => Image.asset('${_bluesPath}small_glow.png', fit: BoxFit.cover);
  Widget get mediumBlue => SvgPicture.asset('${_bluesPath}medium.svg');
  Image get mediumBlueGlow => Image.asset('${_bluesPath}medium_glow.png', fit: BoxFit.cover);
  Widget get largeBlue => SvgPicture.asset('${_bluesPath}large.svg');
  Image get largeBlueGlow => Image.asset('${_bluesPath}large_glow.png', fit: BoxFit.cover);

  Widget get tinyGreen => SvgPicture.asset('${_greensPath}tiny.svg');
  Image get tinyGreenGlow => Image.asset('${_greensPath}tiny_glow.png', fit: BoxFit.cover);
  Widget get smallGreen => SvgPicture.asset('${_greensPath}small.svg');
  Image get smallGreenGlow => Image.asset('${_greensPath}small_glow.png', fit: BoxFit.cover);
  Widget get mediumGreen => SvgPicture.asset('${_greensPath}medium.svg');
  Image get mediumGreenGlow => Image.asset('${_greensPath}medium_glow.png', fit: BoxFit.cover);
  Widget get largeGreen => SvgPicture.asset('${_greensPath}large.svg');
  Image get largeGreenGlow => Image.asset('${_greensPath}large_glow.png', fit: BoxFit.cover);

  /// ----- Detail Page Icons -----
  Widget get questionMark => SvgPicture.asset('${_detailIconPath}question_mark.svg');
  Widget get rightArrow => SvgPicture.asset('${_detailIconPath}right_arrow.svg');
  Widget get leftArrow => SvgPicture.asset('${_detailIconPath}left_arrow.svg');
  Widget get checkMark => SvgPicture.asset('${_detailIconPath}check_mark.svg');
  Widget get emptyMark => SvgPicture.asset('${_detailIconPath}empty_mark.svg');
  Widget get chargerWifi => SvgPicture.asset('${_detailIconPath}wifi_charger_icon.svg');
  Widget get wifi => SvgPicture.asset('${_detailIconPath}wifi_icon.svg');

  /// ----- Misc -----
  Widget get hamburgerMenuIcon => SvgPicture.asset('assets/hamburger_menu_icon.svg');
  Widget get chargerRateIcon => SvgPicture.asset('assets/charge_rate_icon.svg');
  Widget get closeIcon => SvgPicture.asset('assets/close_button.svg', height: 40);
  Widget get externalLinkIcon => SvgPicture.asset('assets/external_link.svg');

  /// ----- Add Charger -----
  Widget get phoneBGImage => Image.asset('${_chargerSetupIconPath}phone_background.png');
  Widget get phoneImage => Image.asset('${_chargerSetupIconPath}phone.png');
  Widget get qrChargerIcon => Image.asset('${_chargerSetupIconPath}qr_charger.png');
  Widget get plugChargerIcon => SvgPicture.asset('${_chargerSetupIconPath}plug_charger.svg');
  Widget get bluetoothIcon => SvgPicture.asset('${_chargerSetupIconPath}bluetooth_icon.svg');
  Widget get connectionFailIcon => SvgPicture.asset('${_chargerSetupIconPath}connection_fail.svg');
  Widget get emptyCircleIcon => SvgPicture.asset('${_chargerSetupIconPath}empty_circle_large.svg');
  Widget get connectionSuccessIcon => SvgPicture.asset('${_chargerSetupIconPath}connection_success.svg');
  Widget get addChargerButtonIcon => SvgPicture.asset('assets/add_button_icon.svg');

  /// ----- Add Dongle -----
  Widget get vehicleImage => Image.asset('${_dongleSetupIconPath}vehicle_icon.png');
  Widget get dongleImage => Image.asset('${_dongleSetupIconPath}dongle.png');
  Widget get dongleInstalleImage => Image.asset('${_dongleSetupIconPath}install_image.png');

// todo move
  List<Map<Widget, Image>> getChargerSizeMap(ColorPattern pattern) {
    switch (pattern) {
      case ColorPattern.red:
        return [
          {tinyRed: emptyGlow},
          {smallRed: emptyGlow},
          {mediumRed: emptyGlow},
          {largeRed: emptyGlow}
        ];
      case ColorPattern.green:
        return [
          {tinyGreen: tinyGreenGlow},
          {smallGreen: smallGreenGlow},
          {mediumGreen: mediumGreenGlow},
          {largeGreen: largeGreenGlow},
        ];
      case ColorPattern.blue:
        return [
          {tinyBlue: emptyGlow},
          {smallBlue: emptyGlow},
          {mediumBlue: emptyGlow},
          {largeBlue: emptyGlow},
        ];
      case ColorPattern.gray:
        return [
          {tinyGray: emptyGlow},
          {smallGray: emptyGlow},
          {mediumGray: emptyGlow},
          {largeGray: emptyGlow},
        ];
    }
  }
}
