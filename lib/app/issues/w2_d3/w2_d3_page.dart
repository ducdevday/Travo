import 'package:flutter/material.dart';
import 'package:my_project/app/common/widgets/menu_item_widget.dart';

import 'language/language_page.dart';
import 'theme/theme_page.dart';

class W2D3Page extends StatelessWidget {
  static const String routeName = '/w2d3';
  final String title;

  static Route route({required String title}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => W2D3Page(title: title),
    );
  }

  const W2D3Page({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            MenuItem(page: ThemePage(), title: "ThemePage"),
            MenuItem(page: LanguagePage(), title: "LanguagePage")
          ],
        ),
      ),
    );
  }
}
