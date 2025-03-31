import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_ketaby/core/animations/page_fade_transition.dart';
import 'package:new_ketaby/core/animations/page_slide_transition.dart';
import 'package:new_ketaby/core/api/api_services_implementation.dart';
import 'package:new_ketaby/core/utils/app_strings.dart';
import 'package:new_ketaby/feature/authentication/presentation/RegisterScreen.dart';
import 'package:new_ketaby/feature/authentication/presentation/login_view.dart';
import 'package:new_ketaby/feature/news/data/repository/news_repo_implementation.dart';
import 'package:new_ketaby/feature/news/presentation/cubit/news_cubit.dart';
import 'package:new_ketaby/feature/news/presentation/view/news_view.dart';
import 'package:new_ketaby/feature/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:new_ketaby/feature/onboarding/presentation/views/onboarding_view.dart';
import 'package:new_ketaby/feature/splash/presentation/views/splash_view.dart';

class Routes {
  static const String slashView = '/';
  static const String onBoardingView = '/onBoarding_view';
  static const String registerView = '/register_view';
  static const String loginView = '/login_view';
  static const String newsView = '/news_view';
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
      case Routes.registerView:
        return PageSlideTransition(
          page: const RegisterScreen(),
          direction: AxisDirection.left,
        );
      case Routes.loginView:
        return PageSlideTransition(
          page: const LoginScreen(),
          direction: AxisDirection.left,
        );
      case Routes.newsView:
        return PageSlideTransition(
          page: BlocProvider(
            create:
                (context) => NewsCubit(
                  NewRepoImplementation(ApiServicesImplementation()),
                ),
            child: const NewsView(),
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
