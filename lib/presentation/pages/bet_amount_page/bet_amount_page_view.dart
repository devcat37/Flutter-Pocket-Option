import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_option/internal/services/app_redirects.dart';
import 'package:pocket_option/internal/services/service_locator.dart';
import 'package:pocket_option/internal/states/subscription_state.dart';
import 'package:pocket_option/internal/utils/infrastructure.dart';

class BetAmountPageView extends StatelessWidget {
  const BetAmountPageView({
    Key? key,
    required this.picked,
  }) : super(key: key);

  static const List<int> _amounts = [20, 50, 100, 1000, 5000, 10000];
  static const List<bool> _free = [true, true, true, false, false, false];

  final int picked;

  Widget _buildAmount(BuildContext context, {required int amount, required bool free}) {
    return InkWell(
      onTap: () {
        if (!free && !service<SubscriptionState>().subscribed) return goToSubscriptionPage(context);

        return pop(context, amount);
      },
      child: Observer(
        builder: (context) {
          print(service<SubscriptionState>().subscribed);
          return Container(
            height: 62.h,
            width: MediaQuery.of(context).size.width - 2 * 16.w,
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Row(
                children: [
                  Text(
                    amount.toString(),
                    style: TextStyle(fontSize: 15.w, color: whiteColor),
                  ),
                  const Spacer(),
                  if (picked == amount) const Icon(Icons.done, color: whiteColor),
                  if (picked != amount && !free && !service<SubscriptionState>().subscribed)
                    const Icon(Icons.lock, color: whiteColor),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: ListView.separated(
        padding: EdgeInsets.all(16.w),
        itemBuilder: (context, index) {
          return _buildAmount(
            context,
            amount: _amounts.elementAt(index),
            free: _free.elementAt(index),
          );
        },
        separatorBuilder: (_, __) => SizedBox(height: 12.h),
        itemCount: _amounts.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Amount',
          style: TextStyle(fontSize: 19.w, fontWeight: FontWeight.bold),
        ),
        leading: GestureDetector(
          onTap: () => pop(context),
          child: const Icon(Icons.arrow_back),
        ),
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      body: _buildContent(context),
    );
  }
}
