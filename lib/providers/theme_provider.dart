import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;
  bool _notificationsEnabled = true;
  String _language = 'Español';

  bool get isDarkMode => _isDarkMode;
  bool get notificationsEnabled => _notificationsEnabled;
  String get language => _language;

  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  // Cargar preferencias guardadas
  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool(AppConstants.keyDarkMode) ?? false;
    _notificationsEnabled = prefs.getBool(AppConstants.keyNotifications) ?? true;
    _language = prefs.getString(AppConstants.keyLanguage) ?? 'Español';
    notifyListeners();
  }

  // Cambiar tema
  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.keyDarkMode, _isDarkMode);
    notifyListeners();
  }

  // Cambiar notificaciones
  Future<void> toggleNotifications() async {
    _notificationsEnabled = !_notificationsEnabled;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.keyNotifications, _notificationsEnabled);
    notifyListeners();
  }

  // Cambiar idioma
  Future<void> setLanguage(String newLanguage) async {
    _language = newLanguage;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.keyLanguage, newLanguage);
    notifyListeners();
  }
}
