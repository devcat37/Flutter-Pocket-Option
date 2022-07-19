import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_option/domain/mocks/mock_pairs.dart';
import 'package:pocket_option/domain/models/currency_pair.dart';
import 'package:pocket_option/internal/services/app_redirects.dart';
import 'package:pocket_option/internal/services/service_locator.dart';
import 'package:pocket_option/internal/states/subscription_state.dart';
import 'package:pocket_option/internal/utils/infrastructure.dart';

class CurrencyPairsPageView extends StatelessWidget {
  const CurrencyPairsPageView({
    Key? key,
    required this.picked,
  }) : super(key: key);

  final CurrencyPair picked;

  Widget _buildPair(BuildContext context, {required CurrencyPair pair}) {
    return InkWell(
      onTap: () {
        if (!pair.free && !service<SubscriptionState>().subscribed) return goToSubscriptionPage(context);

        return pop(context, pair);
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${pair.one}/${pair.two}',
                        style: TextStyle(fontSize: 15.w, color: whiteColor),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        pair.description,
                        style: TextStyle(fontSize: 11.w, color: whiteColor.withOpacity(0.4)),
                      )
                    ],
                  ),
                  const Spacer(),
                  if (picked == pair) const Icon(Icons.done, color: whiteColor),
                  if (picked != pair && !pair.free && !service<SubscriptionState>().subscribed)
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
          return _buildPair(context, pair: allMockPairs.elementAt(index));
        },
        separatorBuilder: (_, __) => SizedBox(height: 12.h),
        itemCount: allMockPairs.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Currency pair',
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
