import 'package:flutter/cupertino.dart';
import 'package:pocket_option/internal/pages/simulator_page/simulator_page.dart';

/// Закрывает текущий экран.
void pop(BuildContext context) => Navigator.of(context).pop();

void replaceWithSimulator(BuildContext context) => Navigator.of(context).pushNamedAndRemoveUntil(SimulatorPage.routeName, (route) => false);
