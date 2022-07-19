import 'package:flutter/material.dart';
import 'package:pocket_option/domain/models/currency_pair.dart';
import 'package:pocket_option/presentation/pages/currency_pairs_page/currency_pairs_page_view.dart';

class CurrencyPairsPage extends StatelessWidget {
  const CurrencyPairsPage({
    Key? key,
    required this.picked,
  }) : super(key: key);

  static const routeName = '/currency-pairs-page';

  final CurrencyPair picked;

  @override
  Widget build(BuildContext context) {
    return CurrencyPairsPageView(
      picked: picked,
    );
  }
}
