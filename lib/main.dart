import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'features/cart/logic/cubit/add_to_cart_cubit.dart';
import 'features/products/logic/cubit/product_cubit.dart';
import 'features/wishlist/logic/cubit/wishlist_cubit.dart';
import 'core/theme/app_theme.dart';
import 'core/routing/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ProductCubit()),
            BlocProvider(create: (context) => AddToCartCubit()),
            BlocProvider(create: (context) => WishlistCubit()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Stylish',
            theme: AppTheme.light,
            onGenerateRoute: AppRouter.onGenerateRoute,
            initialRoute: Routes.splash,
          ),
        );
      },
    );
  }
}