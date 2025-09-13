import 'package:flutter/material.dart';
import 'package:iti_api/core/routing/routes.dart';
import 'package:iti_api/app/presentation/page/post_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (_, animation, __) => const PostPage(),
          transitionsBuilder: (_, animation, __, child) {
            final curved = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
            final slideTween = Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero)
                .chain(CurveTween(curve: Curves.easeOutCubic));
            return FadeTransition(
              opacity: curved,
              child: SlideTransition(
                position: curved.drive(slideTween),
                child: child,
              ),
            );
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/images/splash.png',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}