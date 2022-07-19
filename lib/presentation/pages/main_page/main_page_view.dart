import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_option/internal/services/app_redirects.dart';
import 'package:pocket_option/internal/services/service_locator.dart';
import 'package:pocket_option/internal/services/settings.dart';
import 'package:pocket_option/internal/states/simulator_state.dart';
import 'package:pocket_option/internal/states/subscription_state.dart';
import 'package:pocket_option/internal/utils/infrastructure.dart';

class MainPageView extends StatefulWidget {
  const MainPageView({Key? key}) : super(key: key);

  @override
  State<MainPageView> createState() => _MainPageViewState();
}

class _MainPageViewState extends State<MainPageView> {
  Settings get settings => service<Settings>();

  @override
  void initState() {
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      if (!service<SubscriptionState>().subscribed) {
        goToSubscriptionPage(context);
      }

      if (settings.lastTimeSign.day != DateTime.now().day && settings.balance < 10000.0) {
        settings.balance = 10000.0;
      }

      settings.lastTimeSign = DateTime.now();

      Future.wait([
        service<SimulatorState>().initialize(),
      ]);
    });

    super.initState();
  }

  Widget _buildStartTradingButton(BuildContext context) {
    return InkWell(
      onTap: () => goToSimulatorPage(context),
      borderRadius: BorderRadius.circular(100),
      child: Ink(
        height: 80.h,
        width: MediaQuery.of(context).size.width - 2 * 40.w,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(100),
          gradient: const LinearGradient(
            colors: buttonGradient,
          ),
        ),
        child: Center(
          child: Text(
            'Start trading',
            style: TextStyle(fontSize: 19.w, color: whiteColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsButton(BuildContext context) {
    return InkWell(
      onTap: () => goToSettingsPage(context),
      child: Ink(
        height: 56.h,
        width: MediaQuery.of(context).size.width - 2 * 40.w,
        child: Center(
          child: Text(
            'Settings',
            style: TextStyle(fontSize: 19.w, color: whiteColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: mainPageGradient,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: SafeArea(
          child: Column(
            children: [
              Image.asset(
                'assets/images/main_page_background.png',
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              const Spacer(),
              _buildStartTradingButton(context),
              SizedBox(height: 18.h),
              _buildSettingsButton(context),
              SizedBox(height: 12.h),
            ],
          ),
        ),
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
