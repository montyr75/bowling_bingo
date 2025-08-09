import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'theme_state.dart';

part 'theme_service.g.dart';

@riverpod
class ThemeService extends _$ThemeService {
  static const colorScheme = FlexScheme.bahamaBlue;

  @override
  ThemeState build() {
    final light = FlexThemeData.light(scheme: colorScheme);
    final dark = FlexThemeData.dark(scheme: colorScheme);

    return ThemeState(
      light: light,
      dark: dark.copyWith(textTheme: _buildTextTheme(dark.textTheme)),
    );
  }

  /// Use this to customize the color scheme (current code is an example).
  ThemeData _modTheme(ThemeData data) {
    final textTheme = _buildTextTheme(data.textTheme);

    return data.copyWith(
      // primaryColorDark: primaryColor,
      // dividerColor: Colors.white12,
      appBarTheme: data.appBarTheme.copyWith(
        titleTextStyle: const TextStyle(
          fontSize: 24,
          color: Colors.white,
          fontFamily: 'MedievalSharp',
        ),
      ),
      inputDecorationTheme: data.inputDecorationTheme.copyWith(
        filled: false,
      ),
      // popupMenuTheme: data.popupMenuTheme.copyWith(
      //   color: Colors.black87,
      // ),
      // dialogTheme: data.dialogTheme.copyWith(
      //   // titleTextStyle: const TextStyle(fontFamily: 'Apocalypse'),
      //   backgroundColor: Colors.black87,
      //   shape: const BeveledRectangleBorder(
      //     side: BorderSide(width: 2, color: Colors.white30),
      //     borderRadius: BorderRadius.all(Radius.circular(med)),
      //   ),
      // ),
      textTheme: textTheme,
    );
  }

  /// Use this to customize the text theme (current code is an example).
  TextTheme _buildTextTheme(TextTheme base) {
    return base.copyWith(
      displayLarge: base.displayLarge!.copyWith(
        fontSize: 22,
        fontFamily: 'Anton',
      ),
      displayMedium: base.displayMedium!.copyWith(
        fontSize: 14,
        fontFamily: 'Anton',
      ),
      displaySmall: base.displaySmall!.copyWith(
        fontSize: 10,
        fontFamily: 'Anton',
      ),
      headlineLarge: base.headlineLarge!.copyWith(
        fontSize: 28,
        fontFamily: 'Sniglet',
      ),
      headlineMedium: base.headlineMedium!.copyWith(
        fontSize: 18,
        fontFamily: 'Sniglet',
      ),
      headlineSmall: base.headlineSmall!.copyWith(
        fontSize: 16,
        fontFamily: 'Sniglet',
      ),
      titleLarge: base.titleLarge!.copyWith(
        fontSize: 18,
        fontFamily: 'Sniglet',
      ),
      // TextField default
      titleMedium: base.titleMedium!.copyWith(
        fontSize: 16,
        fontFamily: 'Sniglet',
      ),
      titleSmall: base.titleSmall!.copyWith(
        fontSize: 14,
        fontFamily: 'Sniglet',
      ),
      bodyLarge: base.bodyLarge!.copyWith(
        fontSize: 18,
        fontFamily: 'Sniglet',
      ),
      bodyMedium: base.bodyMedium!.copyWith(
        fontSize: 12,
        fontFamily: 'Sniglet',
      ),
      bodySmall: base.bodySmall!.copyWith(
        fontSize: 10,
        fontFamily: 'Sniglet',
      ),
    );
  }

  void onModeChange(ThemeMode value) {
    state = state.copyWith(mode: value);
  }
}
