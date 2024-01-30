import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_project/app/config/app_color.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Language Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              "hello".tr(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("choose_language".tr()),
            SizedBox(height: 10,),
            Column(
              children: [
                _SwitchListTileMenuItem(
                    title: 'English',
                    subtitle: 'en-US',
                    locale: context.supportedLocales[0]),
                SizedBox(height: 5,),
                _SwitchListTileMenuItem(
                    title: 'VietNam',
                    subtitle: 'vi-VN',
                    locale: context.supportedLocales[1]),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _SwitchListTileMenuItem extends StatelessWidget {
  const _SwitchListTileMenuItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.locale,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final Locale locale;

  bool isSelected(BuildContext context) => locale == context.locale;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 5),
      decoration: BoxDecoration(
        border:
            isSelected(context) ? Border.all(color: AppColor.primaryColor) : Border.all(color: Colors.grey),
      ),
      child: ListTile(
          dense: true,
          // isThreeLine: true,
          title: Text(
            title,
          ),
          subtitle: Text(
            subtitle,
          ),
          onTap: () async {
            print(locale.toString());
            await context.setLocale(locale); //BuildContext extension method
          }),
    );
  }
}
