import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_option/domain/models/currency_pair.dart';
import 'package:pocket_option/internal/services/app_redirects.dart';
import 'package:pocket_option/internal/utils/infrastructure.dart';
import 'package:pocket_option/presentation/global/icons/pocket_icons.dart';

class SimulatorPageHeader extends StatelessWidget {
  const SimulatorPageHeader({
    Key? key,
    required this.balance,
    required this.pair,
    required this.onChangePair,
    required this.canChangePair,
  }) : super(key: key);

  final double balance;
  final CurrencyPair pair;

  final bool canChangePair;

  final Function(CurrencyPair) onChangePair;

  Widget _buildBalance(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          balance.toStringAsFixed(4),
          style: TextStyle(fontSize: 15.w, color: whiteColor),
        ),
        SizedBox(height: 4.h),
        Text(
          'Your balance',
          style: TextStyle(fontSize: 11.w, color: whiteColor.withOpacity(0.4)),
        ),
      ],
    );
  }

  Widget _buildCurrencyPair(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (!canChangePair) return;
        final CurrencyPair? pair = await goToCurrencyPairsPage(context);

        if (pair != null) {
          if (pair == this.pair) return;

          onChangePair(pair);
        }
      },
      borderRadius: BorderRadius.circular(4.r),
      child: Ink(
        height: 32.h,
        decoration: BoxDecoration(
          color: greenColor,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Row(
            children: [
              Icon(Icons.arrow_drop_down, size: 16.r, color: whiteColor),
              SizedBox(width: 4.w),
              Text(
                '${pair.one}/${pair.two}',
                style: TextStyle(fontSize: 15.w, color: whiteColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => pop(context),
            child: SvgPicture.asset(PocketIcons.home),
          ),
          SizedBox(width: 24.w),
          _buildBalance(context),
          const Spacer(),
          _buildCurrencyPair(context)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56.h,
      child: Center(
        child: _buildContent(context),
      ),
    );
  }
}
