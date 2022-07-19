import 'package:flutter/material.dart';
import 'package:pocket_option/presentation/pages/bet_time_page/bet_time_page_view.dart';

class BetTimePage extends StatelessWidget {
  const BetTimePage({
    Key? key,
    required this.picked,
  }) : super(key: key);

  static const routeName = '/bet-time-page';

  final Duration picked;

  @override
  Widget build(BuildContext context) {
    return BetTimePageView(picked: picked);
  }
}
