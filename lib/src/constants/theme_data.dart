import 'package:flutter_starter_base_app/src/constants/colors.dart';
import 'package:flutter/material.dart';

const primaryColor = Colors.black;

class DefaultTheme {
  TextStyle defaultTextStyle(double fontSize) =>
      TextStyle(color: Colors.white, fontSize: fontSize, overflow: TextOverflow.ellipsis);
  BoxDecoration getColoredBoxDecoration(Color color) => BoxDecoration(
      border: Border.all(color: color, width: 2, style: BorderStyle.solid),
      color: CustomColors().darkestGrayBG,
      borderRadius: const BorderRadius.all(Radius.circular(25)));
  BoxDecoration getColoredBoxDecorationSharper(Color color) => BoxDecoration(
      border: Border.all(color: color, width: 2, style: BorderStyle.solid),
      color: CustomColors().darkestGrayBG,
      borderRadius: const BorderRadius.all(Radius.circular(10)));
  ThemeData get themeData => ThemeData(
        colorSchemeSeed: primaryColor,
        unselectedWidgetColor: Colors.grey,
        appBarTheme: AppBarTheme(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            elevation: 2.0,
            centerTitle: true,
            iconTheme: IconThemeData(color: CustomColors().primaryTextColor)),
        scaffoldBackgroundColor: const Color.fromARGB(255, 0, 0, 0),
        popupMenuTheme: PopupMenuThemeData(
            position: PopupMenuPosition.under,
            color: CustomColors().darkMenuBG,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
        dividerTheme: const DividerThemeData(color: Color.fromARGB(51, 255, 255, 255)),
        dividerColor: const Color.fromARGB(255, 255, 255, 255),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(primaryColor),
                foregroundColor: WidgetStateProperty.all<Color>(Colors.white))),
        bottomAppBarTheme: const BottomAppBarTheme(color: Colors.black),
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(primaryColor),
                foregroundColor: WidgetStateProperty.all<Color>(Colors.white))),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(foregroundColor: WidgetStateProperty.all<Color>(CustomColors().primaryTextColor)),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: primaryColor),
        timePickerTheme: TimePickerThemeData(
          helpTextStyle: TextStyle(color: CustomColors().lighterGrayText),
          backgroundColor: const Color.fromRGBO(43, 41, 48, 1),
          hourMinuteColor: WidgetStateColor.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? const Color.fromRGBO(79, 55, 139, 1)
                : const Color.fromRGBO(54, 52, 59, 1),
          ),
          hourMinuteTextColor: WidgetStateColor.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? const Color.fromRGBO(234, 221, 255, 1)
                : CustomColors().lighterGrayText,
          ),
          dialBackgroundColor: const Color.fromRGBO(54, 52, 59, 1),
          dialTextColor: WidgetStateColor.resolveWith(
            (states) => states.contains(WidgetState.selected) ? Colors.black : Colors.white,
          ),
          dialHandColor: CustomColors().primaryTextColor,
          dayPeriodBorderSide: BorderSide(
            color: CustomColors().lightGrayText,
          ),
          dayPeriodColor: WidgetStateColor.resolveWith(
            (states) =>
                states.contains(WidgetState.selected) ? const Color.fromRGBO(99, 59, 72, 1) : Colors.transparent,
          ),
          dayPeriodTextColor: WidgetStateColor.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? const Color.fromRGBO(255, 216, 228, 1)
                : CustomColors().lighterGrayText,
          ),
          entryModeIconColor: CustomColors().lightGrayText,
          cancelButtonStyle: ButtonStyle(foregroundColor: WidgetStatePropertyAll(CustomColors().primaryTextColor)),
          confirmButtonStyle: ButtonStyle(foregroundColor: WidgetStatePropertyAll(CustomColors().primaryTextColor)),
        ),
        dataTableTheme: DataTableThemeData(
            headingRowColor: WidgetStatePropertyAll(CustomColors().darkerGrayBG),
            decoration: BoxDecoration(
                border: Border.symmetric(horizontal: BorderSide(color: CustomColors().tableBorderColor, width: .5))),
            dataTextStyle: defaultTextStyle(11).copyWith(color: CustomColors().tableBorderColor),
            columnSpacing: 0,
            horizontalMargin: 0,
            dataRowMinHeight: 4,
            dataRowMaxHeight: 20,
            dividerThickness: .5,
            headingRowHeight: 24,
            dataRowColor: WidgetStatePropertyAll(CustomColors().darkerGrayBG)),
        dialogTheme: DialogTheme(
          backgroundColor: CustomColors().materialGrayBG,
          titleTextStyle: defaultTextStyle(24).copyWith(color: Colors.white),
          contentTextStyle: defaultTextStyle(14).copyWith(color: CustomColors().lighterGrayText),
        ),
      );
}
