import 'package:flutter/material.dart';
import 'package:pocket_option/internal/application.dart';
import 'package:pocket_option/internal/services/helpers.dart';
import 'package:pocket_option/internal/services/service_locator.dart';
import 'package:pocket_option/internal/services/settings.dart';
import 'package:pocket_option/internal/states/simulator_state.dart';
import 'package:pocket_option/internal/states/subscription_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Settings.
  final Settings settings = Settings();
  await rateMyApp.init();
  await settings.initStorage();
  service.registerSingleton(settings);

  // States.
  service.registerLazySingleton<SimulatorState>(() => SimulatorState());
  service.registerLazySingleton<SubscriptionState>(() => SubscriptionState());

  runApp(const Application());
}
