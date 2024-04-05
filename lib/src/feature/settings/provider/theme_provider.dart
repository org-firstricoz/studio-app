import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeProvider =
    StateNotifierProvider<ThemeProvider, ThemeMode?>((ref) => ThemeProvider());

class ThemeProvider extends StateNotifier<ThemeMode?> {
  ThemeProvider() : super(null) {
    _loadThemeFromLocal();
  }

  void _loadThemeFromLocal() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final ThemeMode savedThemeMode =
        ThemeMode.values[prefs.getInt('themeMode') ?? ThemeMode.system.index];
    state = savedThemeMode;
  }

  void _saveThemeToLocal(ThemeMode themeMode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('themeMode', themeMode.index);
  }

  void toggleTheme(ThemeMode themeMode) {
    state = themeMode;
    _saveThemeToLocal(themeMode);
  }

 
}
