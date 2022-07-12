import 'package:flutter/material.dart';
import 'package:pocket_option/presentation/pages/simulator_page/simulator_page_view.dart';

class SimulatorPage extends StatelessWidget {
  const SimulatorPage({Key? key}) : super(key: key);

  static const routeName = '/simulator-page';

  @override
  Widget build(BuildContext context) {
    return const SimulatorPageView();
  }
}
