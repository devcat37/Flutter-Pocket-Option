import 'package:flutter/material.dart';
import 'package:pocket_option/presentation/pages/subscription_page/subscription_page_view.dart';

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({Key? key}) : super(key: key);

  static const routeName = '/subscription-page';

  @override
  Widget build(BuildContext context) {
    return const SubscriptionPageView();
  }
}
