import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  bool _isLoading = false;
  String _userEmail = '';
  bool _rememberMe = false;

  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String get userEmail => _userEmail;
  bool get rememberMe => _rememberMe;

  // Inicializar y verificar si hay sesión guardada
  Future<void> initAuth() async {
    final prefs = await SharedPreferences.getInstance();
    _rememberMe = prefs.getBool(AppConstants.keyRememberMe) ?? false;
    
    if (_rememberMe) {
      final token = prefs.getString(AppConstants.keyToken);
      final email = prefs.getString(AppConstants.keyEmail);
      
      if (token != null && email != null) {
        _isAuthenticated = true;
        _userEmail = email;
        notifyListeners();
      }
    }
  }

  // Método de login
  Future<bool> login(String email, String password, bool rememberMe) async {
    _isLoading = true;
    notifyListeners();

    // Simular delay de red
    await Future.delayed(const Duration(seconds: 2));

    // Validar credenciales
    if (email == AppConstants.testEmail && password == AppConstants.testPassword) {
      _isAuthenticated = true;
      _userEmail = email;
      _rememberMe = rememberMe;

      // Guardar en SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(AppConstants.keyToken, 'fake_token_${DateTime.now().millisecondsSinceEpoch}');
      await prefs.setString(AppConstants.keyEmail, email);
      await prefs.setBool(AppConstants.keyRememberMe, rememberMe);

      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Método de logout
  Future<void> logout() async {
    _isAuthenticated = false;
    _userEmail = '';
    _rememberMe = false;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstants.keyToken);
    await prefs.remove(AppConstants.keyEmail);
    await prefs.setBool(AppConstants.keyRememberMe, false);

    notifyListeners();
  }

  void setRememberMe(bool value) {
    _rememberMe = value;
    notifyListeners();
  }
}
