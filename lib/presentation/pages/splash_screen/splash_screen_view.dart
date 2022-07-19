import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_option/internal/services/app_redirects.dart';
import 'package:pocket_option/internal/services/service_locator.dart';
import 'package:pocket_option/internal/states/simulator_state.dart';
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
        () => replaceWithMainPage(context),
      ),
    );

    super.initState();
  }

  Widget _buildContent(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/logo/logo.svg',
            height: 120.r,
            width: 120.r,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContent(context),
    );
  }
}
