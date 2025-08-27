import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_api/features/cart/logic/cubit/add_to_cart_cubit.dart';
import 'package:iti_api/shared/widgets/product_card_widget.dart';
import 'package:iti_api/features/cart/logic/cubit/add_to_cart_state.dart';
import 'package:iti_api/features/products/logic/cubit/product_cubit.dart';
import 'package:iti_api/features/products/logic/cubit/product_state.dart';
import 'package:iti_api/features/wishlist/logic/cubit/wishlist_cubit.dart';
import 'package:iti_api/features/wishlist/logic/cubit/wishlist_state.dart';
import 'package:iti_api/core/theme/app_colors.dart';
import 'package:iti_api/core/routing/routes.dart';
import 'package:iti_api/core/widgets/badge_icon_button.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().getProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Product Page'),
        centerTitle: true,
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        actions: [
          BlocBuilder<WishlistCubit, WishlistState>(
            builder: (context, state) {
              final count = state is WishlistLoaded ? state.items.length : 0;
              return BadgeIconButton(
                icon: Icons.favorite_border,
                badgeCount: count,
                iconColor: Colors.black,
                size: 24,
                onPressed: () {
                  Navigator.pushNamed(context, Routes.wishlist);
                },
              );
            },
          ),
          BlocBuilder<AddToCartCubit, AddToCartState>(
            builder: (context, state) {
              final count = state is CartState ? state.cartItems.length : 0;
              return BadgeIconButton(
                icon: Icons.shopping_cart,
                badgeCount: count,
                iconColor: Colors.black,
                size: 24,
                onPressed: () {
                  Navigator.pushNamed(context, Routes.cart);
                },
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is LoadingProductState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ErrorProductState) {
            return Center(
              child: Text(state.error),
            );
          }
          if (state is SuccessProductState) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: state.product.map<Widget>((item) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Routes.productDetails,
                          arguments: {
                            'image': item['thumbnail'] ?? '',
                            'title': item['title'] ?? '',
                            'price': (item['price'] ?? 0).toDouble(),
                            'subtitle': item['description'] ?? item['subtitle'] ?? '',
                          },
                        );
                      },
                      child: ProductCardWidget(
                        id: (item['id'] ?? '').toString(),
                        image: item['thumbnail'] ?? '',
                        title: item['title'] ?? '',
                        price: (item['price'] ?? 0).toDouble(),
                        subtitle: item['description'] ?? item['subtitle'] ?? '',
                      ),
                    );
                  }).toList(),
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
