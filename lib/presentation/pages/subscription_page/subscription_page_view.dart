import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_option/internal/services/app_redirects.dart';
import 'package:pocket_option/internal/services/helpers.dart';
import 'package:pocket_option/internal/services/service_locator.dart';
import 'package:pocket_option/internal/states/subscription_state.dart';
import 'package:pocket_option/internal/utils/infrastructure.dart';

class SubscriptionPageView extends StatefulWidget {
  const SubscriptionPageView({Key? key}) : super(key: key);

  @override
  State<SubscriptionPageView> createState() => _SubscriptionPageViewState();
}

class _SubscriptionPageViewState extends State<SubscriptionPageView> {
  bool isLoading = false;

  Widget _buildContent(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => pop(context),
                  child: const Icon(
                    Icons.close,
                    color: whiteColor,
                  ),
                ),
              ),
            ),
            Image.asset('assets/images/premium.png'),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      style: TextStyle(fontSize: 27.h, fontWeight: FontWeight.bold, color: whiteColor),
                      children: [
                        const TextSpan(text: '• '),
                        const TextSpan(text: 'Ads '),
                        TextSpan(
                          text: 'removing',
                          style: TextStyle(
                              fontSize: 27.h, fontWeight: FontWeight.bold, color: whiteColor.withOpacity(0.4)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text.rich(
                    TextSpan(
                      style: TextStyle(fontSize: 27.h, fontWeight: FontWeight.bold, color: whiteColor),
                      children: [
                        const TextSpan(text: '• '),
                        TextSpan(
                          text: 'All ',
                          style: TextStyle(
                              fontSize: 27.h, fontWeight: FontWeight.bold, color: whiteColor.withOpacity(0.4)),
                        ),
                        const TextSpan(text: 'activities '),
                        TextSpan(
                          text: 'access',
                          style: TextStyle(
                              fontSize: 27.h, fontWeight: FontWeight.bold, color: whiteColor.withOpacity(0.4)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text.rich(
                    TextSpan(
                      style: TextStyle(fontSize: 27.h, fontWeight: FontWeight.bold, color: whiteColor),
                      children: [
                        TextSpan(text: '• '),
                        TextSpan(
                          text: 'All ',
                          style: TextStyle(
                              fontSize: 27.h, fontWeight: FontWeight.bold, color: whiteColor.withOpacity(0.4)),
                        ),
                        TextSpan(text: 'amounts '),
                        TextSpan(
                          text: 'access',
                          style: TextStyle(
                              fontSize: 27.h, fontWeight: FontWeight.bold, color: whiteColor.withOpacity(0.4)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.12),
                  _buildSubscribeButton(context),
                  SizedBox(height: 18.h),
                  _buildTermsRestoryPrivacy(context),
                  SizedBox(height: 8.h),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTermsRestoryPrivacy(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => openPrivacy(),
              child: Center(
                child: Text(
                  'Privacy policy',
                  style: TextStyle(fontSize: 11.w, color: whiteColor),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () async {
                setState(() {
                  isLoading = true;
                });

                final result = await service<SubscriptionState>().restorePurchase();

                setState(() {
                  isLoading = false;
                });

                if (result) {
                  pop(context);
                }
              },
              child: Center(
                child: Text(
                  'Restore',
                  style: TextStyle(fontSize: 11.w, color: whiteColor),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => openTerms(),
              child: Center(
                child: Text(
                  'Terms of Use',
                  style: TextStyle(fontSize: 11.w, color: whiteColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubscribeButton(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          isLoading = true;
        });

        final result = await service<SubscriptionState>().subscribe();

        setState(() {
          isLoading = false;
        });

        if (result) {
          pop(context);
        }
      },
      child: Container(
        height: 80.h,
        width: MediaQuery.of(context).size.width - 2 * 16.w,
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: buttonGradient),
          borderRadius: BorderRadius.circular(120.r),
        ),
        child: Center(
          child: Text(
            'Buy premium for 0.99\$',
            style: TextStyle(fontSize: 19.w, fontWeight: FontWeight.bold, color: whiteColor),
          ),
        ),
      ),
    );
  }

  Widget _buildLoader(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: blackColor.withOpacity(0.4),
      child: Center(
        child: CircularProgressIndicator(
          valueColor: const AlwaysStoppedAnimation(whiteColor),
          strokeWidth: 4.r,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildContent(context),
          if (isLoading) _buildLoader(context),
        ],
      ),
    );
  }
}
