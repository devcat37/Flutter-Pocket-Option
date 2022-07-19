import 'package:flutter/cupertino.dart';
import 'package:pocket_option/domain/models/currency_pair.dart';
import 'package:pocket_option/internal/pages/bet_amount_page/bet_amount_page.dart';
import 'package:pocket_option/internal/pages/bet_time_page/bet_time_page.dart';
import 'package:pocket_option/internal/pages/currency_pairs_page/currency_pairs_page.dart';
import 'package:pocket_option/internal/pages/main_page/main_page.dart';
import 'package:pocket_option/internal/pages/settings_page/settings_page.dart';
import 'package:pocket_option/internal/pages/simulator_page/simulator_page.dart';
import 'package:pocket_option/internal/pages/subcription_page/subscription_page.dart';
import 'package:pocket_option/internal/services/service_locator.dart';
import 'package:pocket_option/internal/states/simulator_state.dart';

/// Закрывает текущий экран.
void pop(BuildContext context, [dynamic result]) => Navigator.of(context).pop(result);

void replaceWithMainPage(BuildContext context) =>
    Navigator.of(context).pushNamedAndRemoveUntil(MainPage.routeName, (route) => false);

void goToSimulatorPage(BuildContext context) => Navigator.of(context).pushNamed(SimulatorPage.routeName);

void goToSettingsPage(BuildContext context) => Navigator.of(context).pushNamed(SettingsPage.routeName);

void goToSubscriptionPage(BuildContext context) => Navigator.of(context).pushNamed(SubscriptionPage.routeName);

Future<CurrencyPair?> goToCurrencyPairsPage(BuildContext context) async =>
    await Navigator.of(context).pushNamed(CurrencyPairsPage.routeName, arguments: service<SimulatorState>().pair);

Future<Duration?> goToBetTimePage(BuildContext context, Duration time) async =>
    await Navigator.of(context).pushNamed(BetTimePage.routeName, arguments: time);

Future<int?> goToBetAmountPage(BuildContext context, int amount) async =>
    await Navigator.of(context).pushNamed(BetAmountPage.routeName, arguments: amount);
