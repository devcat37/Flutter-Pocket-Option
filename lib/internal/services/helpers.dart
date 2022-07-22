import 'package:rate_my_app/rate_my_app.dart';
import 'package:url_launcher/url_launcher.dart';

void openPrivacy() => launchUrl(
    Uri.parse('https://docs.google.com/document/d/1w7JqgtAxNLVrtctWiZFmkKD_d-ufGoGla_BZ4DyvoTU/edit?usp=sharing'));

void openTerms() => launchUrl(
    Uri.parse('https://docs.google.com/document/d/1WAo6BFR6MLVsZX7h1jlLPJFa7D_O70HgibbiDEVgtCs/edit?usp=sharing'));

void openSupport() => launchUrl(Uri.parse(
    'https://docs.google.com/forms/d/e/1FAIpQLSfkbUMmAjJALSmV1iqgVdgAzKsqeHSPYIZOygkhvPdxzHhAwA/viewform?usp=sf_link'));

RateMyApp rateMyApp = RateMyApp(
  preferencesPrefix: 'rateMyApp_',
  minDays: 0, // Show rate popup on first day of install.
  minLaunches: 50, // Show rate popup after 5 launches of app after minDays is passed.
  appStoreIdentifier: '1628172676',
);
