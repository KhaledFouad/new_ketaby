import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_ketaby/core/animations/page_fade_transition.dart';
import 'package:new_ketaby/core/animations/page_slide_transition.dart';
import 'package:new_ketaby/core/api/api_services_implementation.dart';
import 'package:new_ketaby/core/utils/app_strings.dart';
import 'package:new_ketaby/feature/books/data/repository/book_repo_implementation.dart';
import 'package:new_ketaby/feature/books/presentation/cubit/books_cubit.dart';
import 'package:new_ketaby/feature/books/presentation/view/books_view.dart';
import 'package:new_ketaby/feature/layout.dart';
import 'package:new_ketaby/feature/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:new_ketaby/feature/onboarding/presentation/views/onboarding_view.dart';
import 'package:new_ketaby/feature/splash/presentation/views/splash_view.dart';

class Routes {
  static const String slashView = '/';
  static const String onBoardingView = '/onBoarding_view';
  static const String registerView = '/register_view';
  static const String loginView = '/login_view';
  static const String layout = '/layout';
  static const String homeView = '/home_view';
  static const String booksView = '/books_view';
  static const String bookDetailsView = '/book_details_view';
}

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.slashView:
        return MaterialPageRoute(builder: (context) => const SplashView());
      case Routes.onBoardingView:
        return PageFadeTransition(
          page: BlocProvider(
            create: (context) => OnBoardingCubit(),
            child: const OnBoardingView(),
          ),
        );

      case Routes.layout:
        return PageSlideTransition(
          direction: AxisDirection.left,
          page: const Layout(),
        );

      case Routes.booksView:
        return PageSlideTransition(
          page: BlocProvider(
            create:
                (context) => BooksCubit(
                  BookRepoImplementation(ApiServicesImplementation()),
                ),
            child: const BooksView(),
          ),
          direction: AxisDirection.left,
        );

      //   case Routes.appointmentDetailsView:
      // final appointment = settings.arguments as Appointment;
      // return PageSlideTransition(
      //   page: AppointmentDetailsView(appointment: appointment),
      //   direction: AxisDirection.left,
      // );
    }
    return undefinedRoute();
  }

  static Route undefinedRoute() {
    return MaterialPageRoute(
      builder:
          ((context) => const Scaffold(
            body: Center(child: Text(AppStrings.noRouteFound)),
          )),
    );
  }
}
