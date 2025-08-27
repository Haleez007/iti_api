import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_api/features/wishlist/logic/cubit/wishlist_cubit.dart';
import 'package:iti_api/features/wishlist/logic/cubit/wishlist_state.dart';
import 'package:iti_api/core/theme/app_colors.dart';
import 'package:iti_api/core/routing/routes.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Wishlist'),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
      ),
      body: BlocBuilder<WishlistCubit, WishlistState>(
        builder: (context, state) {
          if (state is WishlistLoaded && state.items.isNotEmpty) {
            return ListView.separated(
              itemCount: state.items.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final item = state.items[index];
                return ListTile(
                  leading: Image.network(
                    item['thumbnail'] ?? item['image'] ?? '',
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                  ),
                  title: Text(item['title'] ?? '', style: const TextStyle(color: AppColors.textPrimary)),
                  subtitle: Text(
                    '\$${(item['price'] ?? 0).toString()}',
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline, color: AppColors.primary),
                    onPressed: () => context.read<WishlistCubit>().removeById(item['id']),
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.productDetails,
                      arguments: {
                        'image': item['image'] ?? item['thumbnail'] ?? '',
                        'title': item['title'] ?? '',
                        'price': (item['price'] ?? 0).toDouble(),
                        'subtitle': item['subtitle'] ?? item['description'] ?? '',
                      },
                    );
                  },
                );
              },
            );
          }
          return const Center(
            child: Text('Your wishlist is empty'),
          );
        },
      ),
    );
  }
}
