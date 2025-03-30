import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_ketaby/feature/onboarding/presentation/cubit/onboarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(OnBoardingInitialState());

  static OnBoardingCubit get(context) => BlocProvider.of(context);

  final PageController pageController = PageController();

  List<String> titles = [
    "Stay informed with News App, your window to breaking stories and global updates.",
    "Discover the world at your fingertips trust News App for accurate, timely, and diverse news coverage.",
    "From headlines to deep dives, News App brings clarity to the chaos of today’s news.",
  ];

  bool isLast = false;

  void onChangePageView(int index) {
    if (index == titles.length - 1) {
      isLast = true;
      emit(OnChangePageViewState());
    } else {
      isLast = false;
      emit(OnChangePageViewState());
    }
  }
}
