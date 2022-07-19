import 'package:flutter/material.dart';
import 'package:pocket_option/presentation/pages/bet_amount_page/bet_amount_page_view.dart';

class BetAmountPage extends StatelessWidget {
  const BetAmountPage({
    Key? key,
    required this.picked,
  }) : super(key: key);

  static const routeName = '/bet-amount-page';

  final int picked;

  @override
  Widget build(BuildContext context) {
    return BetAmountPageView(
      picked: picked,
    );
  }
}
