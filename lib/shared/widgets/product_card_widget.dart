import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_api/features/wishlist/logic/cubit/wishlist_cubit.dart';
import 'package:iti_api/features/wishlist/logic/cubit/wishlist_state.dart';
import 'package:iti_api/core/theme/app_colors.dart';

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({
    super.key,
    required this.id,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.price,
  });

  final String id;
  final String image;
  final String title;
  final double? price;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.surface,
      child: SizedBox(
        width: 160.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  image,
                  fit: BoxFit.cover,
                  height: 120.h,
                  width: double.infinity,
                ),
                Positioned(
                  top: 6.h,
                  right: 6.w,
                  child: BlocBuilder<WishlistCubit, WishlistState>(
                    builder: (context, state) {
                      bool inWishlist = false;
                      if (state is WishlistLoaded) {
                        inWishlist = state.items.any((e) => e['id'].toString() == id);
                      }
                      return Container(
                        decoration: BoxDecoration(
                          color: AppColors.surface.withOpacity(0.9),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: Icon(
                            inWishlist ? Icons.favorite : Icons.favorite_border,
                            color: inWishlist ? AppColors.primary : AppColors.textSecondary,
                            size: 20.sp,
                          ),
                          onPressed: () {
                            final productMap = {
                              'id': id,
                              'thumbnail': image,
                              'image': image,
                              'title': title,
                              'subtitle': subtitle,
                              'price': price ?? 0,
                            };
                            context.read<WishlistCubit>().toggle(productMap);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 12.sp),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    '\$${price ?? 0}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}