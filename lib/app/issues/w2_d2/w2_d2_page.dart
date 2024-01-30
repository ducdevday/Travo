import 'package:flutter/material.dart';
import 'package:my_project/app/common/widgets/menu_item_widget.dart';
import 'package:my_project/app/issues/w2_d2/login/login_form_page.dart';
import 'package:my_project/app/issues/w2_d2/otp/otp_form_page.dart';
import 'package:my_project/app/issues/w2_d2/posts/view/post_page.dart';
import 'register/register_form_page.dart';
import 'timer/timer.dart';

import 'counter/counter.dart';

class W2D2Page extends StatelessWidget {
  static const String routeName = '/w2d2';
  final String title;

  static Route route({required String title}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => W2D2Page(title: title),
    );
  }

  const W2D2Page({
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
            MenuItem(page: CounterPage(), title: "CounterPage"),
            MenuItem(page: TimerPage(), title: "TimerPage"),
            MenuItem(page: PostsPage(), title: "PostsPage"),
            MenuItem(page: RegisterFormPage(), title: "RegisterFormPage"),
            MenuItem(page: LoginFormPage(), title: "LoginFormPage"),
            MenuItem(page: OtpFormPage(), title: "OtpFormPage")
          ],
        ),
      ),
    );
  }
}
