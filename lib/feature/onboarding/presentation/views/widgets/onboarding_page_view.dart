import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_ketaby/core/animations/fade_transition_animation.dart'
    show FadeTransitionAnimation;
import 'package:new_ketaby/core/utils/app_colors.dart';
import 'package:new_ketaby/core/utils/app_styles.dart';
import 'package:new_ketaby/feature/onboarding/presentation/cubit/onboarding_cubit.dart'
    show OnBoardingCubit;

import '../../../../../core/animations/slide_transition_animation.dart';
import '../../cubit/onboarding_state.dart';

class OnBoardingPageView extends StatelessWidget {
  const OnBoardingPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnBoardingCubit, OnBoardingState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Expanded(
          child: SlideTransitionAnimation(
            duration: const Duration(seconds: 2),
            begin: const Offset(0, 0.1),
            end: Offset.zero,
            child: FadeTransitionAnimation(
              duration: const Duration(seconds: 3),
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: OnBoardingCubit.get(context).pageController,
                itemCount: OnBoardingCubit.get(context).titles.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: Text(
                      OnBoardingCubit.get(context).titles[index],
                      textAlign: TextAlign.center,
                      style: AppStyles.textStyle20.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                  );
                },
                onPageChanged: (int index) {
                  OnBoardingCubit.get(context).onChangePageView(index);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
