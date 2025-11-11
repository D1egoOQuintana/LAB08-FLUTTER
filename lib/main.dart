import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'providers/auth_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/login_screen.dart';
import 'screens/menu_screen.dart';
import 'utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          // Use CupertinoApp to provide iOS look-and-feel.
          return CupertinoApp(
            title: 'Mi Tienda',
            debugShowCheckedModeBanner: false,
            theme: CupertinoThemeData(
              brightness: themeProvider.isDarkMode
                  ? Brightness.dark
                  : Brightness.light,
              primaryColor: AppConstants.primaryColor,
              textTheme: CupertinoTextThemeData(
                textStyle: GoogleFonts.poppins(),
              ),
            ),
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    // Cargar preferencias
    await Future.wait([
      authProvider.initAuth(),
      themeProvider.loadPreferences(),
    ]);

    // Esperar 2 segundos para mostrar splash
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      // Navegar según el estado de autenticación usando CupertinoPageRoute
      Navigator.of(context).pushReplacement(
        CupertinoPageRoute(
          builder: (context) => authProvider.isAuthenticated
              ? const MenuScreen()
              : const LoginScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Make layout responsive using MediaQuery
    final size = MediaQuery.of(context).size;
    final logoSize =
        (size.width < size.height ? size.width : size.height) * 0.22;

    return CupertinoPageScaffold(
      // Use a Container as background to keep the gradient
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: AppConstants.primaryGradient),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: logoSize,
              height: logoSize,
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
                size: logoSize * 0.5,
                color: AppConstants.primaryColor,
              ),
            ),
            SizedBox(height: size.height * 0.04),
            Text(
              'Mi Tienda',
              style: GoogleFonts.poppins(
                fontSize: size.width * 0.08,
                fontWeight: FontWeight.bold,
                color: CupertinoColors.white,
              ),
            ),
            SizedBox(height: size.height * 0.06),
            const CupertinoActivityIndicator(),
          ],
        ),
      ),
    );
  }
}
