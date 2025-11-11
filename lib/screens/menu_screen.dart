import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/auth_provider.dart';
import '../providers/cart_provider.dart';
import '../models/category.dart';
import '../utils/constants.dart';
import 'products_screen.dart';
import 'profile_screen.dart';
import 'login_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final categories = CategoryData.getCategories();

  void _showLogoutDialog() {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Cerrar Sesión'),
        content: const Text('¿Estás seguro de que deseas cerrar sesión?'),
        actions: [
          CupertinoDialogAction(
            child: const Text('Cancelar'),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () async {
              final navigator = Navigator.of(context);
              navigator.pop();
              await Provider.of<AuthProvider>(context, listen: false).logout();
              if (mounted) {
                navigator.pushAndRemoveUntil(
                  CupertinoPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              }
            },
            child: const Text('Cerrar Sesión'),
          ),
        ],
      ),
    );
  }

  void _showOrdersBottomSheet() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        final size = MediaQuery.of(context).size;
        return Container(
          height: size.height * 0.4,
          padding: EdgeInsets.all(size.width * 0.06),
          decoration: BoxDecoration(
            color: CupertinoColors.systemBackground.resolveFrom(context),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(CupertinoIcons.cube_box, size: size.width * 0.16, color: CupertinoColors.systemGrey),
              SizedBox(height: size.height * 0.02),
              Text(
                'No tienes pedidos',
                style: GoogleFonts.poppins(
                  fontSize: size.width * 0.045,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: size.height * 0.01),
              const Text(
                'Tus pedidos aparecerán aquí una vez que realices una compra.',
                textAlign: TextAlign.center,
                style: TextStyle(color: CupertinoColors.systemGrey),
              ),
              SizedBox(height: size.height * 0.03),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final userEmail = authProvider.userEmail;
    final initial = userEmail.isNotEmpty ? userEmail[0].toUpperCase() : 'U';
    final size = MediaQuery.of(context).size;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Mi Tienda', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: Badge(
                label: const Text('3'),
                child: const Icon(CupertinoIcons.bell),
              ),
              onPressed: () {
                showCupertinoDialog(
                  context: context,
                  builder: (ctx) => CupertinoAlertDialog(
                    content: const Text('Tienes 3 notificaciones nuevas'),
                    actions: [
                      CupertinoDialogAction(child: const Text('OK'), onPressed: () => Navigator.pop(ctx)),
                    ],
                  ),
                );
              },
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: CircleAvatar(
                backgroundColor: AppConstants.primaryColor,
                radius: size.width * 0.045,
                child: Text(
                  initial,
                  style: const TextStyle(
                    color: CupertinoColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => const ProfileScreen()),
                );
              },
            ),
          ],
        ),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.line_horizontal_3),
          onPressed: () {
            showCupertinoModalPopup(
              context: context,
              builder: (context) => _buildDrawerContent(initial, userEmail, size),
            );
          },
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(size.width * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categorías',
                    style: GoogleFonts.poppins(
                      fontSize: size.width * 0.06,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: size.width * 0.04,
                        mainAxisSpacing: size.width * 0.04,
                        childAspectRatio: 1.1,
                      ),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => ProductsScreen(category: category.name),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  category.color.withValues(alpha: 0.7),
                                  category.color,
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: category.color.withValues(alpha: 0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  category.icon,
                                  size: size.width * 0.14,
                                  color: CupertinoColors.white,
                                ),
                                SizedBox(height: size.height * 0.015),
                                Text(
                                  category.name,
                                  style: GoogleFonts.poppins(
                                    fontSize: size.width * 0.04,
                                    fontWeight: FontWeight.bold,
                                    color: CupertinoColors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            if (cartProvider.itemCount > 0)
              Positioned(
                right: size.width * 0.04,
                bottom: size.width * 0.04,
                child: CupertinoButton.filled(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.04, vertical: 12),
                  borderRadius: BorderRadius.circular(30),
                  child: Row(
                    children: [
                      const Icon(CupertinoIcons.cart),
                      const SizedBox(width: 8),
                      Text('${cartProvider.itemCount}'),
                    ],
                  ),
                  onPressed: () => _showCartBottomSheet(cartProvider),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerContent(String initial, String userEmail, Size size) {
    return Container(
      height: size.height * 0.9,
      decoration: BoxDecoration(
        color: CupertinoColors.systemBackground.resolveFrom(context),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(size.width * 0.06),
            decoration: const BoxDecoration(
              gradient: AppConstants.primaryGradient,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: size.width * 0.1,
                    backgroundColor: CupertinoColors.white,
                    child: Text(
                      initial,
                      style: TextStyle(
                        fontSize: size.width * 0.075,
                        color: AppConstants.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    'Usuario Demo',
                    style: GoogleFonts.poppins(
                      fontSize: size.width * 0.05,
                      fontWeight: FontWeight.bold,
                      color: CupertinoColors.white,
                    ),
                  ),
                  SizedBox(height: size.height * 0.005),
                  Text(
                    userEmail,
                    style: GoogleFonts.poppins(
                      fontSize: size.width * 0.035,
                      color: CupertinoColors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                CupertinoListTile(
                  leading: const Icon(CupertinoIcons.house),
                  title: const Text('Inicio'),
                  onTap: () => Navigator.pop(context),
                ),
                CupertinoListTile(
                  leading: const Icon(CupertinoIcons.person),
                  title: const Text('Mi Perfil'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (context) => const ProfileScreen()),
                    );
                  },
                ),
                CupertinoListTile(
                  leading: const Icon(CupertinoIcons.settings),
                  title: const Text('Configuración'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const ProfileScreen(initialTab: 1),
                      ),
                    );
                  },
                ),
                CupertinoListTile(
                  leading: const Icon(CupertinoIcons.bag),
                  title: const Text('Mis Pedidos'),
                  onTap: () {
                    Navigator.pop(context);
                    _showOrdersBottomSheet();
                  },
                ),
                const Divider(),
                CupertinoListTile(
                  leading: const Icon(CupertinoIcons.arrow_right_square, color: CupertinoColors.destructiveRed),
                  title: const Text('Cerrar Sesión', style: TextStyle(color: CupertinoColors.destructiveRed)),
                  onTap: () {
                    Navigator.pop(context);
                    _showLogoutDialog();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showCartBottomSheet(CartProvider cartProvider) {
    final size = MediaQuery.of(context).size;
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          height: size.height * 0.6,
          padding: EdgeInsets.all(size.width * 0.04),
          decoration: BoxDecoration(
            color: CupertinoColors.systemBackground.resolveFrom(context),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Carrito de Compras',
                style: GoogleFonts.poppins(
                  fontSize: size.width * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Text(
                'Tienes ${cartProvider.itemCount} artículos en tu carrito',
                style: TextStyle(fontSize: size.width * 0.04),
              ),
              SizedBox(height: size.height * 0.01),
              Text(
                'Total: \$${cartProvider.totalAmount.toStringAsFixed(2)}',
                style: GoogleFonts.poppins(
                  fontSize: size.width * 0.045,
                  fontWeight: FontWeight.bold,
                  color: AppConstants.primaryColor,
                ),
              ),
              SizedBox(height: size.height * 0.03),
              SizedBox(
                width: double.infinity,
                child: CupertinoButton.filled(
                  onPressed: () {
                    Navigator.pop(context);
                    showCupertinoDialog(
                      context: context,
                      builder: (ctx) => CupertinoAlertDialog(
                        content: const Text('Funcionalidad de pago en desarrollo'),
                        actions: [
                          CupertinoDialogAction(child: const Text('OK'), onPressed: () => Navigator.pop(ctx)),
                        ],
                      ),
                    );
                  },
                  child: const Text('Proceder al Pago'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
