import 'package:flutter/material.dart';
import 'package:pocket_option/presentation/pages/splash_screen/splash_screen_view.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return const SplashScreenView();
  }
}
