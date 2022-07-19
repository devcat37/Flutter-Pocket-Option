import 'package:rate_my_app/rate_my_app.dart';
import 'package:url_launcher/url_launcher.dart';

void openPrivacy() => launchUrl(Uri.parse('https://google.com'));

void openTerms() => launchUrl(Uri.parse('https://google.com'));

void openSupport() => launchUrl(Uri.parse('https://google.com'));

RateMyApp rateMyApp = RateMyApp(
  preferencesPrefix: 'rateMyApp_',
  minDays: 0, // Show rate popup on first day of install.
  minLaunches: 50, // Show rate popup after 5 launches of app after minDays is passed.
  appStoreIdentifier: '1628172676',
);
