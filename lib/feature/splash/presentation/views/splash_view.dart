import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:new_ketaby/core/utils/app_constants.dart';
import 'package:new_ketaby/feature/splash/presentation/views/widgets/splash_view_body.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: AppConstants.systemUiOverlayStyleDark,
        child: SplashViewBody(),
      ),
    );
  }
}
