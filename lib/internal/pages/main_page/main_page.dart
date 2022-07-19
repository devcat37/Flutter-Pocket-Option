import 'package:flutter/material.dart';
import 'package:pocket_option/presentation/pages/main_page/main_page_view.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  static const routeName = '/main-page';

  @override
  Widget build(BuildContext context) {
    return const MainPageView();
  }
}
