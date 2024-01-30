import 'package:flutter/material.dart';
import 'package:my_project/app/features/booking_detail/booking_detail.dart';
import 'package:my_project/app/features/booking_flight_detail/booking_flight_detail.dart';
import 'package:my_project/app/features/checkout/checkout.dart';
import 'package:my_project/app/features/checkout_flight/checkout_flight.dart';
import 'package:my_project/app/features/default/page/default_page.dart';
import 'package:my_project/app/features/flight/flight.dart';
import 'package:my_project/app/features/flight_search/flight_search.dart';
import 'package:my_project/app/features/forgot_password/forgot_password.dart';
import 'package:my_project/app/features/hotel_detail/hotel_detail.dart';
import 'package:my_project/app/features/hotel_search/hotel_search.dart';
import 'package:my_project/app/features/hotels/hotels.dart';
import 'package:my_project/app/features/login/login.dart';
import 'package:my_project/app/features/onboarding/onboarding.dart';
import 'package:my_project/app/features/personal_infomation/personal_information.dart';
import 'package:my_project/app/features/rooms/rooms.dart';
import 'package:my_project/app/features/sign_up/sign_up.dart';

import 'package:my_project/app/issues/issues_page.dart';
import 'package:my_project/app/issues/w1_d1/research_common_widget_page.dart';
import 'package:my_project/app/issues/w1_d2/assets_and_image_page.dart';
import 'package:my_project/app/issues/w1_d2/life_cycle_page.dart';
import 'package:my_project/app/issues/w1_d3/go_router_page.dart';
import 'package:my_project/app/issues/w1_d3/product_detail_page.dart';
import 'package:my_project/app/issues/w2_d1/w2_d1_page.dart';
import 'package:my_project/app/issues/w2_d2/w2_d2_page.dart';
import 'package:my_project/app/issues/w2_d3/w2_d3_page.dart';
import 'package:my_project/app/issues/w2_d4/w2_d4_page.dart';
import 'package:my_project/app/issues/w3_d1/w3_d1_page.dart';
import 'package:my_project/app/issues/w3_d2/w3_d2_page.dart';
import 'package:my_project/data/model/flight_model.dart';
import 'package:my_project/data/model/hotel_model.dart';
import 'package:my_project/data/model/room_model.dart';
import 'package:my_project/data/model/user_model.dart';

class AppRouter {
  static onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case IssuesPage.routeName:
        return IssuesPage.route();
      case ResearchCommonWidgetPage.routeName:
        return ResearchCommonWidgetPage.route(
            title: settings.arguments as String);
      case LifeCyclePage.routeName:
        return LifeCyclePage.route(title: settings.arguments as String);
      case AssetsAndImagePage.routeName:
        return AssetsAndImagePage.route(title: settings.arguments as String);
      case GoRouterPage.routeName:
        return GoRouterPage.route(title: settings.arguments as String);
      case ProductDetailPage.routeName:
        return ProductDetailPage.route(productID: settings.arguments as String);
      case W2D1Page.routeName:
        return W2D1Page.route(title: settings.arguments as String);
      case W2D2Page.routeName:
        return W2D2Page.route(title: settings.arguments as String);
      case W2D3Page.routeName:
        return W2D3Page.route(title: settings.arguments as String);
      case W2D4Page.routeName:
        return W2D4Page.route(title: settings.arguments as String);
      case W3D1Page.routeName:
        return W3D1Page.route(title: settings.arguments as String);
      case W3D2Page.routeName:
        return W3D2Page.route(title: settings.arguments as String);

      //Travo
      case OnBoardingPage.routeName:
        return MaterialPageRoute(builder: (context) => OnBoardingPage());
      case SignUpPage.routeName:
        return MaterialPageRoute(builder: (context) => SignUpPage());
      case LoginPage.routeName:
        return MaterialPageRoute(builder: (context) => LoginPage());
      case ForgotPasswordPage.routeName:
        return MaterialPageRoute(
            builder: (context) => ForgotPasswordPage(
                  email: settings.arguments != null
                      ? settings.arguments as String
                      : null,
                ));
      case DefaultPage.routeName:
        return MaterialPageRoute(builder: (context) => DefaultPage());
      case HotelsPage.routeName:
        return MaterialPageRoute(builder: (context) => HotelsPage());
      case HotelDetailPage.routeName:
        return MaterialPageRoute(
            builder: (context) =>
                HotelDetailPage(hotel: settings.arguments as HotelModel));
      case HotelSearchPage.routeName:
        return MaterialPageRoute(builder: (context) => HotelSearchPage());
      case RoomsPage.routeName:
        return MaterialPageRoute(
            builder: (context) =>
                RoomsPage(hotelId: settings.arguments as String));
      case CheckoutPage.routeName:
        return MaterialPageRoute(
            builder: (context) => CheckoutPage(
                  room: settings.arguments as RoomModel,
                ));
      case PersonalInformationPage.routeName:
        return MaterialPageRoute(
            builder: (context) => PersonalInformationPage(
                  user: settings.arguments as UserModel,
                ));
      case BookingDetailPage.routeName:
        return MaterialPageRoute(
            builder: (context) => BookingDetailPage(
                  bookingId: settings.arguments as String,
                ));
      case FlightPage.routeName:
        final args = settings.arguments as Map<String, dynamic>;

        return MaterialPageRoute(
            builder: (context) => FlightPage(
                fromPlace: args["fromPlace"],
                toPlace: args["toPlace"],
                departureDate: args["departureDate"],
                seatType: args["seatType"]));
      case CheckoutFlightPage.routeName:
        return MaterialPageRoute(
            builder: (context) =>
                CheckoutFlightPage(flight: settings.arguments as FlightModel));
      case BookingFlightDetailPage.routeName:
        return MaterialPageRoute(
            builder: (context) => BookingFlightDetailPage(
                  id: settings.arguments as String,
                ));
      case FlightSearchPage.routeName:
        return MaterialPageRoute(builder: (context) => FlightSearchPage());

      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
        builder: (context) => Scaffold(
              appBar: AppBar(
                title: const Text("Some thing went wrong"),
              ),
            ));
  }
}
