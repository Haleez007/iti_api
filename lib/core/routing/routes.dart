import 'package:flutter/material.dart';
import 'package:iti_api/features/cart/presentation/pages/cart_page.dart';
import 'package:iti_api/features/home/presentation/pages/home_page.dart';
import 'package:iti_api/features/payment/presentation/pages/payment_page.dart';
import 'package:iti_api/features/payment/presentation/pages/payment_success_page.dart';
import 'package:iti_api/features/products/presentation/pages/product_details_page.dart';
import 'package:iti_api/features/products/presentation/pages/product_page.dart';
import 'package:iti_api/features/splash/presentation/pages/splash_screen.dart';
import 'package:iti_api/features/wishlist/presentation/pages/wishlist_page.dart';
import 'package:iti_api/app/presentation/page/post_page.dart';
import 'package:iti_api/app/presentation/page/get_started.dart';
import 'package:iti_api/features/auth/presentation/pages/login_screen.dart';

class Routes {
  static const String splash = '/';
  static const String home = '/home';
  static const String products = '/products';
  static const String cart = '/cart';
  static const String wishlist = '/wishlist';
  static const String payment = '/payment';
  static const String productDetails = '/product-details';
  static const String paymentSuccess = '/payment-success';
  static const String post = '/post';
  static const String getStarted = '/get-started';
  static const String login = '/login';
}

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.post:
        return MaterialPageRoute(builder: (_) => const PostPage());
      case Routes.getStarted:
        return MaterialPageRoute(builder: (_) => const GetStarted());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case Routes.products:
        return MaterialPageRoute(builder: (_) => const ProductPage());
      case Routes.cart:
        return MaterialPageRoute(builder: (_) => const CartPage());
      case Routes.wishlist:
        return MaterialPageRoute(builder: (_) => const WishlistPage());
      case Routes.payment:
        return MaterialPageRoute(builder: (_) => const PaymentPage());
      case Routes.paymentSuccess:
        return MaterialPageRoute(builder: (_) => const PaymentSuccessPage());
      case Routes.productDetails:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => ProductDetailsPage(
            image: args?['image'] ?? '',
            title: args?['title'] ?? '',
            price: (args?['price'] ?? 0).toDouble(),
            subtitle: args?['subtitle'] ?? '',
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route not found')),
          ),
        );
    }
  }
}
