import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pocket_option/internal/services/app_redirects.dart';
import 'package:pocket_option/internal/utils/infrastructure.dart';

class BetTimePageView extends StatelessWidget {
  const BetTimePageView({
    Key? key,
    required this.picked,
  }) : super(key: key);

  static const List<Duration> _times = [Duration(minutes: 3), Duration(minutes: 5), Duration(minutes: 10)];

  final Duration picked;

  Widget _buildTime(BuildContext context, {required Duration time}) {
    return InkWell(
      onTap: () => pop(context, time),
      child: Container(
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
                '${DateFormat('mm:ss').format(DateTime.fromMillisecondsSinceEpoch(time.inMilliseconds))} mins',
                style: TextStyle(fontSize: 15.w, color: whiteColor),
              ),
              const Spacer(),
              if (picked == time) const Icon(Icons.done, color: whiteColor)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: ListView.separated(
        padding: EdgeInsets.all(16.w),
        itemBuilder: (context, index) {
          return _buildTime(context, time: _times.elementAt(index));
        },
        separatorBuilder: (_, __) => SizedBox(height: 12.h),
        itemCount: _times.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Time',
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
