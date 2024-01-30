import 'package:flutter/material.dart';
import 'package:my_project/app/issues/w1_d1/research_common_widget_page.dart';
import 'package:my_project/app/issues/w1_d2/assets_and_image_page.dart';
import 'package:my_project/app/issues/w1_d2/life_cycle_page.dart';
import 'package:my_project/app/issues/w1_d3/go_router_page.dart';
import 'package:my_project/app/issues/w2_d1/w2_d1_page.dart';
import 'package:my_project/app/issues/w2_d2/w2_d2_page.dart';
import 'package:my_project/app/issues/w2_d3/w2_d3_page.dart';
import 'package:my_project/app/issues/w2_d4/w2_d4_page.dart';
import 'package:my_project/app/issues/w3_d1/w3_d1_page.dart';
import 'package:my_project/app/issues/w3_d2/w3_d2_page.dart';
import 'package:my_project/data/temp_model/issue_model.dart';

const issues = [
  IssueModel(
      name: "[W1-D1] Research common widget",
      route: ResearchCommonWidgetPage.routeName),
  IssueModel(
      name: "[W1-D2] Stateless Widget, Stateful Widget, Lifecycle",
      route: LifeCyclePage.routeName),
  IssueModel(
      name: "[W1-D2] Assets & Image", route: AssetsAndImagePage.routeName),
  IssueModel(
      name: "[W1-D3] Navigation & Routing", route: GoRouterPage.routeName),
  IssueModel(name: "[W2-D1] Form Widget", route: W2D1Page.routeName),
  IssueModel(name: "[W2-D2] BLoC", route: W2D2Page.routeName),
  IssueModel(name: "[W2-D3] Theme and Localization", route: W2D3Page.routeName),
  IssueModel(name: "[W2-D4-5] Firebase", route: W2D4Page.routeName),
  IssueModel(name: "[W3-D1] Generate APKs", route: W3D1Page.routeName),
  IssueModel(name: "[W3-D2] RxDart", route: W3D2Page.routeName),
];

class IssuesPage extends StatelessWidget {
  static const String routeName = '/issue';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => IssuesPage(),
    );
  }

  const IssuesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("App Cyclone Issues"),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: ListView.separated(
              itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(issues[index].route,
                          arguments: issues[index].name);
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                issues[index].name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Icon(Icons.keyboard_arrow_right_rounded)
                          ],
                        ),
                      ),
                    ),
                  ),
              separatorBuilder: (context, index) => Divider(
                    height: 8,
                    thickness: 0.75,
                  ),
              itemCount: issues.length),
        ));
  }
}
