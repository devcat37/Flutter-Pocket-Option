import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pocket_option/internal/services/app_redirects.dart';
import 'package:pocket_option/internal/utils/infrastructure.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState() {
    SchedulerBinding.instance?.addPostFrameCallback(
      (_) => Future.delayed(
        aSecond * 3,
        () => replaceWithSimulator(context),
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
