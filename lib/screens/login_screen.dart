import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/auth_provider.dart';
import '../utils/constants.dart';
import 'menu_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = false;
  
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      
      final success = await authProvider.login(
        _emailController.text,
        _passwordController.text,
        _rememberMe,
      );

      if (success && mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MenuScreen()),
        );
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Credenciales incorrectas. Intenta nuevamente.'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

  void _showForgotPasswordDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Recuperar Contraseña'),
        content: const Text('Se enviará un enlace de recuperación a tu correo electrónico.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Enlace enviado a tu correo'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Enviar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final size = MediaQuery.of(context).size;

    return CupertinoPageScaffold(
      backgroundColor: Colors.transparent,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppConstants.primaryGradient,
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(size.width * 0.06),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: size.height * 0.06),

                    // Logo
                    Container(
                      width: size.width * 0.28,
                      height: size.width * 0.28,
                      decoration: BoxDecoration(
                        color: CupertinoColors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: CupertinoColors.black.withValues(alpha: 0.2),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Icon(
                        CupertinoIcons.bag,
                        size: size.width * 0.12,
                        color: AppConstants.primaryColor,
                      ),
                    ),

                    SizedBox(height: size.height * 0.03),

                    // Título
                    Text(
                      'Bienvenido',
                      style: GoogleFonts.poppins(
                        fontSize: size.width * 0.09,
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.white,
                      ),
                    ),

                    SizedBox(height: size.height * 0.01),

                    // Subtítulo
                    Text(
                      'Inicia sesión para continuar',
                      style: GoogleFonts.poppins(
                        fontSize: size.width * 0.036,
                        color: CupertinoColors.white.withValues(alpha: 0.9),
                      ),
                    ),

                    SizedBox(height: size.height * 0.04),

                    // Card del formulario
                    Container(
                      padding: EdgeInsets.all(size.width * 0.06),
                      decoration: BoxDecoration(
                        color: CupertinoColors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: CupertinoColors.black.withValues(alpha: 0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Email TextField
                          CupertinoTextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            placeholder: 'correo@ejemplo.com',
                            prefix: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Icon(CupertinoIcons.mail, color: CupertinoColors.systemGrey),
                            ),
                          ),

                          SizedBox(height: size.height * 0.02),

                          // Password TextField
                          CupertinoTextField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            placeholder: 'Contraseña',
                            suffix: CupertinoButton(
                              padding: EdgeInsets.zero,
                              child: Icon(_obscurePassword ? CupertinoIcons.eye_slash : CupertinoIcons.eye),
                              onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                            ),
                          ),

                          SizedBox(height: size.height * 0.015),

                          // Recordar sesión
                          Row(
                            children: [
                              CupertinoSwitch(
                                value: _rememberMe,
                                onChanged: (v) => setState(() => _rememberMe = v),
                              ),
                              const SizedBox(width: 8),
                              const Text('Recordar sesión'),
                            ],
                          ),

                          SizedBox(height: size.height * 0.03),

                          // Botón de login
                          SizedBox(
                            width: double.infinity,
                            height: size.height * 0.07,
                            child: authProvider.isLoading
                                ? const Center(child: CupertinoActivityIndicator())
                                : CupertinoButton.filled(
                                    onPressed: _handleLogin,
                                    borderRadius: BorderRadius.circular(12),
                                    child: Text('INICIAR SESIÓN', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                                  ),
                          ),

                          SizedBox(height: size.height * 0.02),

                          // Olvidaste tu contraseña
                          CupertinoButton(
                            onPressed: _showForgotPasswordDialog,
                            padding: EdgeInsets.zero,
                            child: Text('¿Olvidaste tu contraseña?', style: GoogleFonts.poppins(color: AppConstants.primaryColor)),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: size.height * 0.03),

                    // Credenciales de prueba
                    Container(
                      padding: EdgeInsets.all(size.width * 0.04),
                      decoration: BoxDecoration(
                        color: CupertinoColors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Text('Credenciales de prueba:', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
                          SizedBox(height: size.height * 0.01),
                          Text('Email: usuario@tienda.com', style: GoogleFonts.poppins(color: Colors.white, fontSize: size.width * 0.03)),
                          Text('Password: 123456', style: GoogleFonts.poppins(color: Colors.white, fontSize: size.width * 0.03)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
