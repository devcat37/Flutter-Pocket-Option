import 'package:flutter/material.dart';
import 'package:pocket_option/internal/pages/simulator_page/simulator_page.dart';
import 'package:pocket_option/internal/pages/splash_screen/splash_screen.dart';
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
          }

          return route;
        },
      ),
    );
  }
}
