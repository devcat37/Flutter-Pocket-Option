import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pocket_option/internal/application.dart';
import 'package:pocket_option/internal/services/helpers.dart';
import 'package:pocket_option/internal/services/service_locator.dart';
import 'package:pocket_option/internal/services/settings.dart';
import 'package:pocket_option/internal/states/simulator_state.dart';
import 'package:pocket_option/internal/states/subscription_state.dart';
import 'package:http/http.dart';
import 'package:traffic_router/traffic_router.dart' as tr;
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:apphud/apphud.dart';
import 'package:app_review/app_review.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:async';

final api = 'app_4kZryPQPqxstTU6C7H7bR2zPtBFjWY';
final productID = 'premium_potrade';

final termsOfUse = 'https://docs.google.com/document/d/1WAo6BFR6MLVsZX7h1jlLPJFa7D_O70HgibbiDEVgtCs/edit?usp=sharing';
final privacyPolicy =
    'https://docs.google.com/document/d/1w7JqgtAxNLVrtctWiZFmkKD_d-ufGoGla_BZ4DyvoTU/edit?usp=sharing';
final support =
    'https://docs.google.com/forms/d/e/1FAIpQLSfkbUMmAjJALSmV1iqgVdgAzKsqeHSPYIZOygkhvPdxzHhAwA/viewform?usp=sf_link';

// Этот контроллер подписки может использоваться в StreamBuilder
final StreamController<bool> subscribedController = StreamController.broadcast();
// Через эту переменную можно смотреть состояние подписки юзера
bool subscribed = false;
late Stream<bool> subscribedStream;
late StreamSubscription<bool> subT;

// Закинуть на экран с покупкой, если вернул true, то закрыть экран покупки
// В дебаге этот метод вернет true
Future<bool> purchase() async {
  final res = await Apphud.purchase(productId: productID);
  if ((res.nonRenewingPurchase?.isActive ?? false) || kDebugMode) {
    subscribedController.add(true);
    return true;
  }
  return false;
}

// Закинуть на экран с покупкой, если вернул true, то закрыть экран покупки
// В дебаге этот метод вернет true
Future<bool> restore() async {
  final res = await Apphud.restorePurchases();
  if (res.purchases.isNotEmpty || kDebugMode) {
    subscribedController.add(true);
    return true;
  }
  return false;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final trafficRouter = await tr.TrafficRouter.initialize(
      settings: tr.Settings(
          paramNames: tr.ParamNames(
    databaseRoot: 'json_potradeapp',
    baseUrl1: 'hesoya',
    baseUrl2: 'lika',
    url11key: 'tennun',
    url12key: 'juttiy',
    url21key: 'brovnc',
    url22key: 'timaly',
  )));

  if (trafficRouter.url.isEmpty) {
    await Apphud.start(apiKey: api);
    subscribedStream = subscribedController.stream;
    subT = subscribedStream.listen((event) {
      subscribed = event;
      service<SubscriptionState>().subscribed = event;
    });
    if (await Apphud.isNonRenewingPurchaseActive(productID)) {
      subscribedController.add(true);
    }
    startMain();
  } else {
    AppReview.requestReview;
    if (trafficRouter.override) {
      await _launchInBrowser(trafficRouter.url);
    } else {
      runApp(MaterialApp(
        home: WebViewPage(
          url: trafficRouter.url,
        ),
      ));
    }
  }
}

Future<void> _launchInBrowser(String url) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
    );
  } else {
    throw 'Could not launch $url';
  }
}

class WebViewPage extends StatefulWidget {
  final String url;

  const WebViewPage({Key? key, required this.url}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WebViewPageState();
  }
}

class _WebViewPageState extends State<WebViewPage> {
  WebViewController? _webController;
  late String webviewUrl;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    _enableRotation();
    webviewUrl = widget.url;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if ((await _webController?.canGoBack()) ?? false) {
          await _webController?.goBack();
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Scaffold(
        body: SafeArea(
          child: WebView(
            gestureNavigationEnabled: true,
            initialUrl: webviewUrl,
            javascriptMode: JavascriptMode.unrestricted,
            navigationDelegate: (action) {
              return NavigationDecision.navigate;
            },
            onWebViewCreated: (con) {
              print('complete');
              _webController = con;
            },
          ),
        ),
      ),
    );
  }

  void _enableRotation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }
}

void startMain() async {
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
