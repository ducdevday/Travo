import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:my_project/app/issues/issues_page.dart';

class MyGoRouter {
  static const issuesRoute = "/";
  static const researchCommonWidgetRoute = "/researchCommonWidget";
  static const researchCommonWidgetPath = "researchCommonWidget";
  static const lifeCycleRoute = "/lifeCycle";
  static const lifeCyclePath = "lifeCycle";
  static const assetsAndImageRoute = "/assetsAndImage";
  static const assetsAndImagePath = "assetsAndImage";
  static const goRouterRoute = "/goRouter";
  static const goRouterPath = "goRouter";
  static const productDetailPath = "productDetail";

  late final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const IssuesPage();
        },
        routes: [
          // GoRoute(
          //     path: researchCommonWidgetPath,
          //     name: researchCommonWidgetPath,
          //     builder: (BuildContext context, GoRouterState state) {
          //       return const ResearchCommonWidgetPage();
          //     }),
          // GoRoute(
          //     name: lifeCyclePath,
          //     path: lifeCyclePath,
          //     builder: (BuildContext context, GoRouterState state) {
          //       return const LifeCyclePage();
          //     }),
          // GoRoute(
          //     name: assetsAndImagePath,
          //     path: assetsAndImagePath,
          //     builder: (BuildContext context, GoRouterState state) {
          //       return const AssetsAndImagePage();
          //     }),
          // GoRoute(
          //     name: goRouterPath,
          //     path: goRouterPath,
          //     builder: (BuildContext context, GoRouterState state) {
          //       return const GoRouterPage();
          //     }),
          // GoRoute(
          //     name: productDetailPath,
          //     path: "$productDetailPath/:productID",
          //     builder: (BuildContext context, GoRouterState state) {
          //       return ProductDetailPage(
          //           productID: state.pathParameters["productID"]!);
          //     }),
          // GoRoute(
          //   name: 'product_list',
          //   path: 'product_list/:category',
          //   builder: (BuildContext context, GoRouterState state) {
          //     return ProductListScreen(
          //       category: state.params['category']!,
          //       asc: state.queryParams['sort'] == 'asc',
          //       quantity: int.parse(state.queryParams['filter'] ?? '0'),
          //     );
          //   },
          // ),
        ],
      ),
    ],
    // redirect: (BuildContext context, GoRouterState state) {
    //   final bool loggedIn = loginCubit.state.status == AuthStatus.authenticated;
    //   final bool loggingIn = state.subloc == '/login';
    //   if (!loggedIn) {
    //     return loggingIn ? null : '/login';
    //   }
    //   if (loggingIn) {
    //     return '/';
    //   }
    //   return null;
    // },
  );
}
