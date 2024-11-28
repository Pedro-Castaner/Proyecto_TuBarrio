import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
/// The [AppTheme] defines light and dark themes for the app.
///
/// Theme setup for FlexColorScheme package v8.
/// Use same major flex_color_scheme package version. If you use a
/// lower minor version, some properties may not be supported.
/// In that case, remove them after copying this theme to your
/// app or upgrade package to version 8.0.1.
///
/// Use in [MaterialApp] like this:
///
/// MaterialApp(
///  theme: AppTheme.light,
///  darkTheme: AppTheme.dark,
///  :
/// );
sealed class AppTheme {
  // The defined light theme.
  static ThemeData light = FlexThemeData.light(
  colors: const FlexSchemeColor( // Custom
    primary: Color(0xff00d6dc),
    primaryContainer: Color(0xffaaf2f0),
    primaryLightRef: Color(0xff00d6dc),
    secondary: Color(0xff4b4bf2),
    secondaryContainer: Color(0xff00cdd9),
    secondaryLightRef: Color(0xff4b4bf2),
    tertiary: Color(0xffddfaf9),
    tertiaryContainer: Color(0xff6ae9e9),
    tertiaryLightRef: Color(0xffddfaf9),
    appBarColor: Color(0xff00cdd9),
    error: Color(0xffdc3545),
    errorContainer: Color(0xfffe9c1a),
  ),
  subThemesData: const FlexSubThemesData(
    interactionEffects: true,
    tintedDisabledControls: true,
    useM2StyleDividerInM3: true,
    toggleButtonsSchemeColor: SchemeColor.primary,
    checkboxSchemeColor: SchemeColor.primary,
    inputDecoratorSchemeColor: SchemeColor.surfaceContainerLow,
    inputDecoratorIsFilled: true,
    inputDecoratorBorderType: FlexInputBorderType.outline,
    inputDecoratorUnfocusedHasBorder: false,
    inputDecoratorFocusedHasBorder: false,
    inputDecoratorSuffixIconSchemeColor: SchemeColor.black,
    inputCursorSchemeColor: SchemeColor.primary,
    inputSelectionSchemeColor: SchemeColor.primaryContainer,
    listTileIconSchemeColor: SchemeColor.secondaryContainer,
    fabUseShape: true,
    fabAlwaysCircular: true,
    fabSchemeColor: SchemeColor.secondary,
    cardRadius: 8.0,
    alignedDropdown: true,
    dialogBackgroundSchemeColor: SchemeColor.white,
    dialogElevation: 6.0,
    dialogRadius: 24.0,
    snackBarRadius: 12,
    snackBarBackgroundSchemeColor: SchemeColor.onSurfaceVariant,
    snackBarActionSchemeColor: SchemeColor.errorContainer,
    bottomAppBarSchemeColor: SchemeColor.primaryContainer,
    bottomAppBarHeight: 64,
    bottomNavigationBarSelectedLabelSchemeColor: SchemeColor.secondary,
    bottomNavigationBarSelectedIconSchemeColor: SchemeColor.secondary,
    bottomNavigationBarBackgroundSchemeColor: SchemeColor.primaryContainer,
    navigationBarSelectedLabelSchemeColor: SchemeColor.black,
    navigationBarUnselectedLabelSchemeColor: SchemeColor.black,
    navigationBarSelectedIconSchemeColor: SchemeColor.black,
    navigationBarUnselectedIconSchemeColor: SchemeColor.black,
    navigationBarIndicatorSchemeColor: SchemeColor.secondaryContainer,
    navigationBarBackgroundSchemeColor: SchemeColor.primaryContainer,
    navigationBarSelectedLabelSize: 18,
    navigationBarUnselectedLabelSize: 13,
    navigationBarSelectedIconSize: 24,
    navigationBarUnselectedIconSize: 18,
    navigationRailUseIndicator: true,
    navigationRailLabelType: NavigationRailLabelType.all,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
  );
  // The defined dark theme.
  static ThemeData dark = FlexThemeData.dark(
  colors: const FlexSchemeColor( // Custom
    primary: Color(0xff9fc9ff),
    primaryContainer: Color(0xff00325b),
    primaryLightRef: Color(0xff00d6dc),
    secondary: Color(0xffffb59d),
    secondaryContainer: Color(0xff872100),
    secondaryLightRef: Color(0xff4b4bf2),
    tertiary: Color(0xff86d2e1),
    tertiaryContainer: Color(0xff004e59),
    tertiaryLightRef: Color(0xffddfaf9),
    appBarColor: Color(0xff00cdd9),
    error: Color(0xffffb4ab),
    errorContainer: Color(0xff93000a),
  ),
  subThemesData: const FlexSubThemesData(
    interactionEffects: true,
    tintedDisabledControls: true,
    blendOnColors: true,
    useM2StyleDividerInM3: true,
    toggleButtonsSchemeColor: SchemeColor.primary,
    checkboxSchemeColor: SchemeColor.primary,
    inputDecoratorIsFilled: true,
    inputDecoratorBorderType: FlexInputBorderType.outline,
    inputDecoratorUnfocusedHasBorder: false,
    inputDecoratorFocusedHasBorder: false,
    listTileIconSchemeColor: SchemeColor.secondaryContainer,
    fabUseShape: true,
    fabAlwaysCircular: true,
    fabSchemeColor: SchemeColor.secondary,
    cardRadius: 8.0,
    alignedDropdown: true,
    dialogElevation: 6.0,
    dialogRadius: 24.0,
    snackBarRadius: 12,
    snackBarBackgroundSchemeColor: SchemeColor.onSurfaceVariant,
    snackBarActionSchemeColor: SchemeColor.errorContainer,
    bottomAppBarHeight: 64,
    bottomNavigationBarSelectedLabelSchemeColor: SchemeColor.secondary,
    bottomNavigationBarSelectedIconSchemeColor: SchemeColor.secondary,
    bottomNavigationBarBackgroundSchemeColor: SchemeColor.primaryContainer,
    navigationBarSelectedLabelSchemeColor: SchemeColor.black,
    navigationBarUnselectedLabelSchemeColor: SchemeColor.black,
    navigationBarSelectedIconSchemeColor: SchemeColor.black,
    navigationBarUnselectedIconSchemeColor: SchemeColor.black,
    navigationBarIndicatorSchemeColor: SchemeColor.secondaryContainer,
    navigationBarBackgroundSchemeColor: SchemeColor.primaryContainer,
    navigationBarSelectedLabelSize: 18,
    navigationBarUnselectedLabelSize: 13,
    navigationBarSelectedIconSize: 24,
    navigationBarUnselectedIconSize: 18,
    navigationRailUseIndicator: true,
    navigationRailLabelType: NavigationRailLabelType.all,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
  );
}
