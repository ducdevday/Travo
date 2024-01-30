import 'package:flutter/material.dart';
import 'package:my_project/app/common/widgets/menu_item_widget.dart';
import 'package:my_project/app/issues/w3_d2/search/search_page.dart';
import 'counter/counter_page.dart';

class W3D2Page extends StatelessWidget {
  static const String routeName = '/w3d2';
  final String title;

  static Route route({required String title}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => W3D2Page(title: title),
    );
  }

  const W3D2Page({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            MenuItem(page: CounterPage(), title: "CounterPage"),
            MenuItem(page: SearchPage(), title: "SearchPage"),
          ],
        ),
      ),
    );
  }
}
