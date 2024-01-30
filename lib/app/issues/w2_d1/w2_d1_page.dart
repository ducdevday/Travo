import 'package:flutter/material.dart';
import 'package:my_project/app/common/widgets/menu_item_widget.dart';
import 'package:my_project/app/issues/w2_d1/login_form_page.dart';
import 'package:my_project/app/issues/w2_d1/otp_form_page.dart';
import 'package:my_project/app/issues/w2_d1/register_form_page.dart';

class W2D1Page extends StatelessWidget {
  static const String routeName = '/w2d1';
  final String title;

  static Route route({required String title}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => W2D1Page(title: title),
    );
  }

  const W2D1Page({
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
            MenuItem(page: RegisterFormPage(), title: "RegisterFormPage"),
            MenuItem(page: LoginFormPage(), title: "LoginFormPage"),
            MenuItem(page: OtpFormPage(), title: "OtpFormPage")
          ],
        ),
      ),
    );
  }
}

