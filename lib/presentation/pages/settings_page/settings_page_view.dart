import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pocket_option/internal/services/app_redirects.dart';
import 'package:pocket_option/internal/services/helpers.dart';
import 'package:pocket_option/internal/services/service_locator.dart';
import 'package:pocket_option/internal/services/settings.dart';
import 'package:pocket_option/internal/states/subscription_state.dart';
import 'package:pocket_option/internal/utils/infrastructure.dart';
import 'package:pocket_option/presentation/global/icons/pocket_icons.dart';
import 'package:share_plus/share_plus.dart';

class SettingsPageView extends StatelessWidget {
  const SettingsPageView({Key? key}) : super(key: key);

  Widget _buildButton(BuildContext context, {required String title, required String icon, required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 81.h,
        width: (MediaQuery.of(context).size.width - 2 * 16.w - 13.w) / 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          color: surfaceColor,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                icon,
                height: 24.r,
                width: 24.r,
              ),
              SizedBox(height: 16.h),
              Text(
                title,
                style: TextStyle(fontSize: 15.w, color: whiteColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubscriptionButton(BuildContext context) {
    return GestureDetector(
      onTap: () => goToSubscriptionPage(context),
      child: Container(
        height: 81.h,
        width: MediaQuery.of(context).size.width - 2 * 16.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          color: surfaceColor,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                PocketIcons.premium,
                height: 24.r,
                width: 24.r,
              ),
              SizedBox(height: 16.h),
              Text(
                'Buy Premium',
                style: TextStyle(fontSize: 15.w, color: whiteColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSupportButton(BuildContext context) {
    return GestureDetector(
      onTap: () => openSupport(),
      child: Container(
        height: 81.h,
        width: MediaQuery.of(context).size.width - 2 * 16.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          color: surfaceColor,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                PocketIcons.support,
                height: 24.r,
                width: 24.r,
              ),
              SizedBox(height: 16.h),
              Text(
                'Support',
                style: TextStyle(fontSize: 15.w, color: whiteColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Observer(
        builder: (context) => Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => pop(context),
                  child: SvgPicture.asset(PocketIcons.home),
                ),
                SizedBox(width: 24.w),
                Text(
                  'Settings',
                  style: TextStyle(fontSize: 19.w, fontWeight: FontWeight.bold, color: whiteColor),
                )
              ],
            ),
            SizedBox(height: 16.h),
            if (!service<SubscriptionState>().subscribed) ...[
              _buildSubscriptionButton(context),
              SizedBox(height: 12.h),
            ],
            Row(
              children: [
                _buildButton(context, title: 'Privacy Policy', icon: PocketIcons.privacy, onTap: () => openPrivacy()),
                SizedBox(width: 12.w),
                _buildButton(context, title: 'Terms of Use', icon: PocketIcons.terms, onTap: () => openTerms()),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                _buildButton(context,
                    title: 'Rate App', icon: PocketIcons.rate, onTap: () => rateMyApp.showRateDialog(context)),
                SizedBox(width: 12.w),
                _buildButton(context,
                    title: 'Share App', icon: PocketIcons.share, onTap: () => Share.share(Settings.appName)),
              ],
            ),
            SizedBox(height: 12.h),
            _buildSupportButton(context),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _buildContent(context),
      ),
    );
  }
}
