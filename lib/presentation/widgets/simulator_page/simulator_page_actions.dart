import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pocket_option/internal/services/app_redirects.dart';
import 'package:pocket_option/internal/states/simulator_state.dart';
import 'package:pocket_option/internal/utils/infrastructure.dart';

class SimulatorPageActions extends StatefulWidget {
  const SimulatorPageActions({
    Key? key,
    required this.onBet,
    required this.time,
    this.isAwaitingForEnd = false,
    this.isLoading = false,
    this.reward,
  }) : super(key: key);

  /// Нажал ли пользователь на одну из кнопок Up/Down и ждет окончания ставки.
  final bool isAwaitingForEnd;

  final bool isLoading;

  /// Время.
  final DateTime? time;

  /// Награда.
  final double? reward;

  final Function(int, Duration, BetType) onBet;

  @override
  State<SimulatorPageActions> createState() => _SimulatorPageActionsState();
}

class _SimulatorPageActionsState extends State<SimulatorPageActions> {
  Duration time = const Duration(minutes: 5);
  int betAmount = 20;

  Widget _buildDownButton(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: (widget.isAwaitingForEnd || widget.isLoading) ? null : () => widget.onBet(betAmount, time, BetType.down),
        borderRadius: BorderRadius.circular(4.w),
        child: Ink(
          padding: EdgeInsets.symmetric(vertical: 17.h),
          decoration: BoxDecoration(
            color: (widget.isAwaitingForEnd || widget.isLoading) ? whiteColor.withOpacity(0.4) : redColor,
            borderRadius: BorderRadius.circular(4.w),
          ),
          child: Center(
            child: Text(
              'Down',
              style: TextStyle(fontSize: 19.w, fontWeight: FontWeight.bold, color: whiteColor),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUpButton(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: (widget.isAwaitingForEnd || widget.isLoading) ? null : () => widget.onBet(betAmount, time, BetType.up),
        borderRadius: BorderRadius.circular(4.w),
        child: Ink(
          padding: EdgeInsets.symmetric(vertical: 17.h),
          decoration: BoxDecoration(
            color: (widget.isAwaitingForEnd || widget.isLoading) ? whiteColor.withOpacity(0.4) : greenColor,
            borderRadius: BorderRadius.circular(4.w),
          ),
          child: Center(
            child: Text(
              'Up',
              style: TextStyle(fontSize: 19.w, fontWeight: FontWeight.bold, color: whiteColor),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildDownButton(context),
        SizedBox(width: 12.w),
        _buildUpButton(context),
      ],
    );
  }

  Widget _buildBetAmount(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Amount',
            style: TextStyle(fontSize: 11.w, color: whiteColor.withOpacity(0.4)),
          ),
          DropdownButton(
            isExpanded: true,
            value: betAmount,
            iconEnabledColor: whiteColor,
            onTap: () async {
              if (widget.isAwaitingForEnd || widget.isLoading) return;

              final int? amount = await goToBetAmountPage(context, betAmount);
              if (amount != null) {
                setState(() {
                  betAmount = amount;
                });
              }
            },
            menuMaxHeight: 0,
            items: [
              DropdownMenuItem(
                value: betAmount,
                child: Text(
                  betAmount.toString(),
                  style: TextStyle(fontSize: 15.w, color: whiteColor),
                ),
              ),
            ],
            onChanged: (_) {},
          )
        ],
      ),
    );
  }

  Widget _buildTimeButton(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Time',
            style: TextStyle(fontSize: 11.w, color: whiteColor.withOpacity(0.4)),
          ),
          DropdownButton(
            isExpanded: true,
            value: betAmount,
            iconEnabledColor: whiteColor,
            onTap: () async {
              if (widget.isAwaitingForEnd || widget.isLoading) return;

              final Duration? time = await goToBetTimePage(context, this.time);
              if (time != null) {
                setState(() {
                  this.time = time;
                });
              }
            },
            menuMaxHeight: 0,
            items: [
              DropdownMenuItem(
                value: betAmount,
                child: Text(
                  DateFormat('mm:ss').format(widget.isAwaitingForEnd
                      ? widget.time!
                      : DateTime.fromMillisecondsSinceEpoch(time.inMilliseconds)),
                  style: TextStyle(fontSize: 15.w, color: whiteColor),
                ),
              ),
            ],
            onChanged: (_) {},
          ),
        ],
      ),
    );
  }

  Widget _buildReward(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Reward',
            style: TextStyle(fontSize: 11.w, color: greenColor),
          ),
          SizedBox(height: 12.h),
          Text(
            widget.reward?.toStringAsFixed(5) ?? '--',
            style: TextStyle(
              fontSize: 15.w,
              color: (widget.reward ?? 0) == 0 ? whiteColor : ((widget.reward ?? 0) > 0 ? greenColor : redColor),
            ),
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }

  Widget _buildAmounTimeReward(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBetAmount(context),
        SizedBox(width: 12.w),
        _buildTimeButton(context),
        SizedBox(width: 12.w),
        _buildReward(context),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: [
        _buildAmounTimeReward(context),
        SizedBox(height: 32.h),
        _buildButtons(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SizedBox(
        child: _buildContent(context),
      ),
    );
  }
}
