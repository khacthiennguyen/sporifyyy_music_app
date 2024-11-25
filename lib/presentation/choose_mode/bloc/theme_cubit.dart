import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  void updateTheme(ThemeMode themeMode) => emit(themeMode);

  @override
  ThemeMode? fromJson(Map<String, dynamic> json) {
    final themeString = json['themeMode'] as String?;
    if (themeString == 'light') {
      return ThemeMode.light;
    } else if (themeString == 'dark') {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  @override
  Map<String, dynamic>? toJson(ThemeMode state) {
    String themeString;
    if (state == ThemeMode.light) {
      themeString = 'light';
    } else if (state == ThemeMode.dark) {
      themeString = 'dark';
    } else {
      themeString = 'system';
    }
    return {'themeMode': themeString};
  }
}
