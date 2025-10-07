import 'package:flutter/material.dart';

class AppConstants {
  // Credenciales de prueba
  static const String testEmail = 'usuario@tienda.com';
  static const String testPassword = '123456';
  
  // Colores
  static const Color primaryColor = Color(0xFF6366F1);
  static const Color secondaryColor = Color(0xFF8B5CF6);
  static const Color accentColor = Color(0xFFF43F5E);
  
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryColor, secondaryColor],
  );
  
  static const LinearGradient buttonGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [primaryColor, secondaryColor],
  );
  
  // Duración de animaciones
  static const Duration animationDuration = Duration(milliseconds: 300);
  
  // Keys para SharedPreferences
  static const String keyToken = 'auth_token';
  static const String keyEmail = 'user_email';
  static const String keyRememberMe = 'remember_me';
  static const String keyDarkMode = 'dark_mode';
  static const String keyNotifications = 'notifications_enabled';
  static const String keyLanguage = 'app_language';
}
