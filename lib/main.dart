import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:my_project/app/config/app_router.dart';
import 'package:my_project/app/config/app_theme.dart';
import 'package:my_project/app/features/default/bloc/user_cubit.dart';
import 'package:my_project/app/features/default/page/default_page.dart';
import 'package:my_project/app/features/default/widgets/bottombar/my_bottom_nav_bar_cubit.dart';
import 'package:my_project/app/features/login/login.dart';
import 'package:my_project/app/features/onboarding/onboarding.dart';
import 'package:my_project/app/issues/w2_d3/theme/bloc/theme_bloc.dart';
import 'package:my_project/data/dataprovider/auth/auth_dataprovider.dart';
import 'package:my_project/data/dataprovider/booking/booking_dataprovider.dart';
import 'package:my_project/data/dataprovider/booking_flight/booking_flight_dataprovider.dart';
import 'package:my_project/data/dataprovider/flight/flight_dataprovider.dart';
import 'package:my_project/data/dataprovider/hotel/hotel_dataprovider.dart';
import 'package:my_project/data/dataprovider/place/place_dataprovider.dart';
import 'package:my_project/data/dataprovider/promo/promo_dataprovider.dart';
import 'package:my_project/data/dataprovider/room/room_dataprovider.dart';
import 'package:my_project/data/dataprovider/service/service_dataprovider.dart';
import 'package:my_project/data/dataprovider/user/user_dataprovider.dart';
import 'package:my_project/data/repositories/auth/auth_repository.dart';
import 'package:my_project/data/repositories/booking/booking_repository.dart';
import 'package:my_project/data/repositories/booking_flight/booking_flight_repository.dart';
import 'package:my_project/data/repositories/flight/flight_repository.dart';
import 'package:my_project/data/repositories/hotel/hotel_repository.dart';
import 'package:my_project/data/repositories/place/place_repository.dart';
import 'package:my_project/data/repositories/promo/promo_repository.dart';
import 'package:my_project/data/repositories/room/room_repository.dart';
import 'package:my_project/data/repositories/service/service_repository.dart';
import 'package:my_project/data/repositories/user/user_repository.dart';
import 'package:path_provider/path_provider.dart';

import 'app/utils/simple_bloc_observer.dart';
import 'data/services/shared_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  await SharedService.init();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  Bloc.observer = SimpleBlocObserver();
  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en', 'US'), Locale('vi', 'VN')],
        path: 'assets/translations',
        fallbackLocale: Locale('en', 'US'),
        child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  String getInitialRoute() {
    if (SharedService.getIsFirstTime() == true) {
      return OnBoardingPage.routeName;
    } else if (SharedService.getUserId() == null) {
      return LoginPage.routeName;
    } else {
      return DefaultPage.routeName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
            create: (_) =>
                AuthRepository(authDataProvider: AuthDataProvider())),
        RepositoryProvider(
            create: (_) =>
                UserRepository(userDataProvider: UserDataProvider())),
        RepositoryProvider(
            create: (_) =>
                PlaceRepository(placeDataProvider: PlaceDataProvider())),
        RepositoryProvider(
            create: (_) =>
                HotelRepository(hotelDataProvider: HotelDataProvider())),
        RepositoryProvider(
            create: (_) =>
                RoomRepository(roomDataProvider: RoomDataProvider())),
        RepositoryProvider(
            create: (_) =>
                ServiceRepository(serviceDataProvider: ServiceDataProvider())),
        RepositoryProvider(
            create: (_) =>
                PromoRepository(promoDataProvider: PromoDataProvider())),
        RepositoryProvider(
            create: (_) => BookingRepository(
                bookingDataProvider: BookingDataProvider(),
                hotelDataProvider: HotelDataProvider(),
                roomDataProvider: RoomDataProvider(),
                promoDataProvider: PromoDataProvider())),
        RepositoryProvider(
            create: (_) =>
                FlightRepository(flightDataProvider: FlightDataProvider())),
        RepositoryProvider(
            create: (_) => BookingFlightRepository(
                bookingFlightDataProvider: BookingFlightDataProvider(),
                flightDataProvider: FlightDataProvider(),
                promoDataProvider: PromoDataProvider())),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ThemeBloc(),
          ),
          BlocProvider(
            create: (context) => UserCubit(
                userRepository: context.read<UserRepository>(),
                authRepository: context.read<AuthRepository>())
              ..loadUser(),
          ),
          BlocProvider(create: (context) => MyBottomNavBarCubit())
        ],
        child: Builder(builder: (context) {
          final isDark = context.watch<ThemeBloc>().state;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
            darkTheme: AppTheme.darkTheme,
            theme: AppTheme.lightTheme,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            onGenerateRoute: (settings) {
              return AppRouter.onGenerateRoute(settings);
            },
            initialRoute: getInitialRoute(),
            // home: BookingDetailPage(bookingId: "F66pqKzeVBiWJP5FXaWl",),
            builder: EasyLoading.init(),
          );
        }),
      ),
    );

    // return MaterialApp.router(
    //   debugShowCheckedModeBanner: false,
    //   theme: ThemeData(
    //     colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff16919c)),
    //     useMaterial3: true,
    //   ),
    //   routerConfig: MyGoRouter().router,
    // );
  }
}
