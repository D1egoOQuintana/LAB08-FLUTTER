import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/cart_provider.dart';
import '../models/product.dart';
import '../utils/constants.dart';

class ProductsScreen extends StatefulWidget {
  final String category;

  const ProductsScreen({super.key, required this.category});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<Product> products = [];
  List<Product> filteredProducts = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadProducts() {
    products = ProductData.getAllProducts();
    filteredProducts = products;
  }

  void _filterProducts(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredProducts = products;
      } else {
        filteredProducts = products
            .where(
              (product) =>
                  product.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
      }
    });
  }

  Future<void> _refreshProducts() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Productos',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        // background is handled by body gradient
      ),
      child: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                CupertinoSliverRefreshControl(onRefresh: _refreshProducts),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: CupertinoSearchTextField(
                      controller: _searchController,
                      onChanged: _filterProducts,
                      placeholder: 'Buscar productos...',
                    ),
                  ),
                ),
                if (filteredProducts.isEmpty) ...[
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            CupertinoIcons.search,
                            size: MediaQuery.of(context).size.width * 0.18,
                            color: CupertinoColors.systemGrey,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No se encontraron productos',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: CupertinoColors.systemGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ] else ...[
                  SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final product = filteredProducts[index];
                        // responsive sizes
                        final width = MediaQuery.of(context).size.width;
                        final imageSize = width * 0.18;

                        return GestureDetector(
                          onTap: () => _showProductDetail(product),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: CupertinoColors.systemBackground
                                  .resolveFrom(context),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: CupertinoColors.black.withValues(
                                    alpha: 0.05,
                                  ),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: imageSize,
                                  height: imageSize,
                                  decoration: BoxDecoration(
                                    color: product.color,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    product.icon,
                                    size: imageSize * 0.5,
                                    color: CupertinoColors.white,
                                  ),
                                ),
                                SizedBox(width: width * 0.04),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.name,
                                        style: GoogleFonts.poppins(
                                          fontSize: width * 0.04,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        product.description,
                                        style: TextStyle(
                                          fontSize: width * 0.032,
                                          color: CupertinoColors.systemGrey,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Icon(
                                            CupertinoIcons.star_fill,
                                            size: width * 0.032,
                                            color: CupertinoColors.systemYellow,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            '${product.rating}/5.0',
                                            style: TextStyle(
                                              fontSize: width * 0.032,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        '\$${product.price.toStringAsFixed(2)}',
                                        style: GoogleFonts.poppins(
                                          fontSize: width * 0.045,
                                          fontWeight: FontWeight.bold,
                                          color: AppConstants.primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                    gradient: AppConstants.buttonGradient,
                                    shape: BoxShape.circle,
                                  ),
                                  child: CupertinoButton(
                                    padding: const EdgeInsets.all(10),
                                    child: const Icon(
                                      CupertinoIcons.plus,
                                      color: CupertinoColors.white,
                                    ),
                                    onPressed: () {
                                      cartProvider.addItem(product);
                                      showCupertinoDialog(
                                        context: context,
                                        builder: (ctx) => CupertinoAlertDialog(
                                          content: Text(
                                            '${product.name} agregado al carrito',
                                          ),
                                          actions: [
                                            CupertinoDialogAction(
                                              child: const Text('OK'),
                                              onPressed: () =>
                                                  Navigator.pop(ctx),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }, childCount: filteredProducts.length),
                    ),
                  ),
                ],
              ],
            ),

            // Cart button (floating) placed bottom-right
            if (cartProvider.itemCount > 0)
              Positioned(
                right: 16,
                bottom: 16,
                child: CupertinoButton.filled(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
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

  void _showProductDetail(Product product) {
    final size = MediaQuery.of(context).size;
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          height: size.height * 0.8,
          decoration: BoxDecoration(
            color: CupertinoColors.systemBackground.resolveFrom(context),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(size.width * 0.06),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: size.width * 0.35,
                      height: size.width * 0.35,
                      decoration: BoxDecoration(
                        color: product.color,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        product.icon,
                        size: size.width * 0.18,
                        color: CupertinoColors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Text(
                    product.name,
                    style: GoogleFonts.poppins(
                      fontSize: size.width * 0.06,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.star_fill,
                        color: CupertinoColors.systemYellow,
                        size: size.width * 0.05,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${product.rating}/5.0',
                        style: TextStyle(
                          fontSize: size.width * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.03,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: product.color.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          product.category,
                          style: TextStyle(
                            color: product.color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    product.description,
                    style: TextStyle(
                      fontSize: size.width * 0.04,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: GoogleFonts.poppins(
                      fontSize: size.width * 0.08,
                      fontWeight: FontWeight.bold,
                      color: AppConstants.primaryColor,
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  SizedBox(
                    width: double.infinity,
                    child: CupertinoButton.filled(
                      onPressed: () {
                        Provider.of<CartProvider>(
                          context,
                          listen: false,
                        ).addItem(product);
                        Navigator.pop(context);
                        showCupertinoDialog(
                          context: context,
                          builder: (ctx) => CupertinoAlertDialog(
                            content: Text(
                              '${product.name} agregado al carrito',
                            ),
                            actions: [
                              CupertinoDialogAction(
                                child: const Text('OK'),
                                onPressed: () => Navigator.pop(ctx),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(CupertinoIcons.cart_badge_plus),
                          SizedBox(width: 8),
                          Text('Agregar al Carrito'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showCartBottomSheet(CartProvider cartProvider) {
    final size = MediaQuery.of(context).size;
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          height: size.height * 0.75,
          decoration: BoxDecoration(
            color: CupertinoColors.systemBackground.resolveFrom(context),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(size.width * 0.04),
                child: Text(
                  'Carrito de Compras',
                  style: GoogleFonts.poppins(
                    fontSize: size.width * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                  itemCount: cartProvider.items.length,
                  itemBuilder: (context, index) {
                    final cartItem = cartProvider.items[index];
                    final product = cartItem.product;
                    final imgSize = size.width * 0.12;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemGrey6.resolveFrom(context),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: imgSize,
                            height: imgSize,
                            decoration: BoxDecoration(
                              color: product.color,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              product.icon,
                              color: CupertinoColors.white,
                              size: imgSize * 0.5,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '\$${product.price.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: CupertinoColors.systemGrey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CupertinoButton(
                                padding: EdgeInsets.zero,
                                child: const Icon(CupertinoIcons.minus_circle),
                                onPressed: () {
                                  cartProvider.decreaseQuantity(product.id);
                                },
                              ),
                              Text('${cartItem.quantity}'),
                              CupertinoButton(
                                padding: EdgeInsets.zero,
                                child: const Icon(CupertinoIcons.plus_circle),
                                onPressed: () {
                                  cartProvider.addItem(product);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(size.width * 0.04),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemBackground.resolveFrom(context),
                  boxShadow: [
                    BoxShadow(
                      color: CupertinoColors.systemGrey.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total:',
                          style: GoogleFonts.poppins(
                            fontSize: size.width * 0.045,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\$${cartProvider.totalAmount.toStringAsFixed(2)}',
                          style: GoogleFonts.poppins(
                            fontSize: size.width * 0.06,
                            fontWeight: FontWeight.bold,
                            color: AppConstants.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
                    SizedBox(
                      width: double.infinity,
                      child: CupertinoButton.filled(
                        onPressed: () {
                          Navigator.pop(context);
                          showCupertinoDialog(
                            context: context,
                            builder: (ctx) => CupertinoAlertDialog(
                              content: const Text(
                                'Funcionalidad de pago en desarrollo',
                              ),
                              actions: [
                                CupertinoDialogAction(
                                  child: const Text('OK'),
                                  onPressed: () => Navigator.pop(ctx),
                                ),
                              ],
                            ),
                          );
                        },
                        child: const Text('Proceder al Pago'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
