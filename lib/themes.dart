import 'package:flutter/material.dart';

const Color primaryColor = Color (0xFF2CBA64);

class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      fontFamily: "Inter",
      colorSchemeSeed: Colors.white,
      canvasColor: Colors.white,
      dialogBackgroundColor: Colors.white,
      dividerColor: Colors.white,
      hintColor: Colors.white,
      hoverColor: Colors.white,
      indicatorColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      secondaryHeaderColor: Colors.white,
      unselectedWidgetColor: Colors.white,
    );
  }
}

const Color textBlackColor = Color(0xFF1B1B1B);
const Color textGrayColor = Color(0xFF707070);
const Color textWhiteColor = Color(0xFFF5F5F7);
const Color boxGrayColor = Color(0xFFF5F5F7);
const Color boxBlueColor = Color(0xFFE4EBF5);
const Color buttonGrayColor = Color(0xFFF5F5F7);
const Color dividerNormal = Color(0xFFC7C7C7);
const Color dividerStrong = Color(0xFF8D8D8D);
const Color warningColor = Color(0xFFFA8219);
const Color errorColor = Color(0xFFE60000);

const double defaultPadding = 16.0;
const double defaultBorderRadius = 12.0;
const Duration defaultDuration = Duration(milliseconds: 300);
const double defaultElevation = 6.0;


class PText extends Text {
  PText(
      super.data,
      PFontStyle style,
      Color color,
      FontWeight weight,
      {
        super.key,
        TextDecoration decoration = TextDecoration.none
      }) : super(
      style: PTextStyle(
        color,
        style,
        weight,
        decoration: decoration,
      )
  );
}

class PTextStyle extends TextStyle {
  PTextStyle(
      Color color,
      PFontStyle style,
      FontWeight weight,
      {TextDecoration decoration = TextDecoration.none}
      ) : super(
      fontFamily: "Inter",
      color: color,
      fontSize: style.size,
      fontWeight: weight,
      decoration: decoration
  );
}

const FontWeight boldInter = FontWeight.w900;
const FontWeight semiboldInter = FontWeight.w600;
const FontWeight regularInter = FontWeight.w300;

class PFontStyle {
  final double size;

  // private 생성자
  const PFontStyle._(this.size);
  static const PFontStyle display1 = PFontStyle._(40.0);
  static const PFontStyle display2 = PFontStyle._(32.0);
  static const PFontStyle title1 = PFontStyle._(28.0);
  static const PFontStyle title2 = PFontStyle._(24.0);
  static const PFontStyle headline1 = PFontStyle._(20.0);
  static const PFontStyle headline2 = PFontStyle._(18.0);
  static const PFontStyle body1 = PFontStyle._(16.0);
  static const PFontStyle body2 = PFontStyle._(15.0);
  static const PFontStyle label = PFontStyle._(14.0);
  static const PFontStyle caption1 = PFontStyle._(12.0);
  static const PFontStyle caption2 = PFontStyle._(11.0);
}

// class CustomIcon {
//   CustomIcon._();
//
//   static const _kFontFam = 'CustomIcon';
//   static const String? _kFontPkg = null;
//
//   static const IconData progressIcon = IconData(0xe801, fontFamily: _kFontFam, fontPackage: _kFontPkg);
//   static const IconData robotIcon = IconData(0xe802, fontFamily: _kFontFam, fontPackage: _kFontPkg);
// }

BoxDecoration primaryBox = BoxDecoration(
  color: primaryColor,
  borderRadius: BorderRadius.all(
      Radius.circular(defaultBorderRadius)),
  border: Border.all(color: primaryColor, width: 2),
);

BoxDecoration secondaryBox = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.all(
      Radius.circular(defaultBorderRadius)),
  border: Border.all(color: primaryColor, width: 2),
);

BoxDecoration grayBox = BoxDecoration(
  color: boxGrayColor,
  borderRadius: BorderRadius.all(
      Radius.circular(defaultBorderRadius)),
);

BoxDecoration whiteBox = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.all(
      Radius.circular(defaultBorderRadius)),
);

BoxDecoration blueBox = BoxDecoration(
  color: boxBlueColor,
  borderRadius: BorderRadius.all(
      Radius.circular(defaultBorderRadius)),
);