import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_api/cubit/add_to_cart/add_to_cart_cubit.dart';
import 'package:iti_api/product_card_widget.dart';
import 'package:iti_api/product_details_page.dart';
import 'cart_page.dart';
import 'cubit/add_to_cart/add_to_cart_state.dart';
import 'cubit/get_product/product_cubit.dart';
import 'cubit/get_product/product_state.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Product Page'),
        centerTitle: true,

        actions: [
          BlocBuilder<AddToCartCubit, AddToCartState>(
            builder: (context, state) {
              if (state is CartState) {
                return Stack(
                  alignment: Alignment.topRight,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const CartPage()),
                        );
                      },
                      icon: Icon(Icons.shopping_cart, color: Colors.black, size: 24),
                    ),
                    state.cartItems.isNotEmpty
                        ? Positioned(
                            top: 4.r,
                            right: 4.r,
                            child: Container(
                              height: 16.r,
                              width: 16.r,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '${state.cartItems.length}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.r,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : SizedBox(),
                  ],
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is LoadingProductState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ErrorProductState) {
            return Center(
              child: Text(state.error),
            );
          }
          if (state is SuccessProductState) {
            print('state.product ${state.product}');
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: state.product.map<Widget>((item) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProductDetailsPage(
                              image: item['thumbnail'] ?? '',
                              title: item['title'] ?? '',
                              price: (item['price'] ?? 0).toDouble(),
                              subtitle: item['description'] ?? item['subtitle'] ?? '',
                            ),
                          ),
                        );
                      },
                      child: ProductCardWidget(
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
