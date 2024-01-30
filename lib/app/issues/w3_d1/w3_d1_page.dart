import 'package:flutter/material.dart';
import 'package:my_project/data/model/environment.dart';

class W3D1Page extends StatelessWidget {
  static const String routeName = '/w3d1';
  final String title;

  static Route route({required String title}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => W3D1Page(title: title),
    );
  }

  const W3D1Page({
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
        child: Center(
          child: Text(Environment.apiUrl),
        ),
      ),
    );
  }
}
