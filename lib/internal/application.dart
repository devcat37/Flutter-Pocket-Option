import 'package:flutter/material.dart';
import 'package:pocket_option/domain/models/currency_pair.dart';
import 'package:pocket_option/internal/pages/bet_amount_page/bet_amount_page.dart';
import 'package:pocket_option/internal/pages/bet_time_page/bet_time_page.dart';
import 'package:pocket_option/internal/pages/currency_pairs_page/currency_pairs_page.dart';
import 'package:pocket_option/internal/pages/main_page/main_page.dart';
import 'package:pocket_option/internal/pages/settings_page/settings_page.dart';
import 'package:pocket_option/internal/pages/simulator_page/simulator_page.dart';
import 'package:pocket_option/internal/pages/splash_screen/splash_screen.dart';
import 'package:pocket_option/internal/pages/subcription_page/subscription_page.dart';
import 'package:pocket_option/internal/services/settings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_option/internal/utils/infrastructure.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, _) => MaterialApp(
        title: Settings.appName,
        initialRoute: SplashScreen.routeName,
        theme: ThemeData(
          scaffoldBackgroundColor: backgroundColor,
          fontFamily: 'Arial',
        ),
        onGenerateRoute: (routeSettings) {
          Route? route;

          switch (routeSettings.name) {
            case SplashScreen.routeName:
              route = MaterialPageRoute(builder: (context) => const SplashScreen());
              break;
            case SimulatorPage.routeName:
              route = MaterialPageRoute(builder: (context) => const SimulatorPage());
              break;
            case MainPage.routeName:
              route = MaterialPageRoute(builder: (context) => const MainPage());
              break;
            case SettingsPage.routeName:
              route = MaterialPageRoute(builder: (context) => const SettingsPage());
              break;
            case SubscriptionPage.routeName:
              route = MaterialPageRoute(builder: (context) => const SubscriptionPage());
              break;
            case CurrencyPairsPage.routeName:
              route = MaterialPageRoute<CurrencyPair>(
                builder: (context) => CurrencyPairsPage(
                  picked: routeSettings.arguments as CurrencyPair,
                ),
              );
              break;
            case BetAmountPage.routeName:
              route = MaterialPageRoute<int>(
                  builder: (context) => BetAmountPage(
                        picked: routeSettings.arguments as int,
                      ));
              break;
            case BetTimePage.routeName:
              route = MaterialPageRoute<Duration>(
                  builder: (context) => BetTimePage(
                        picked: routeSettings.arguments as Duration,
                      ));
              break;
          }

          return route;
        },
      ),
    );
  }
}
