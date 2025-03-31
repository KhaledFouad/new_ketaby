import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_ketaby/feature/authentication/data/Repo/authentication_repository.dart';
import 'package:new_ketaby/feature/authentication/presentation/cubit/login/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authenticationRepository) : super(LoginInitialState());

  final AuthenticationRepository authenticationRepository;
  TextEditingController emailController = TextEditingController(
    text: "khaled.fouad20@outlook.com",
  );
  TextEditingController passwordController = TextEditingController(
    text: "123456789",
  );

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isShowPassword = true;

  void changePasswordVisibility() {
    isShowPassword = !isShowPassword;
    emit(LoginChangePasswordVisibilityState());
  }

  Future<void> userLogin(dynamic context) async {
    emit(LoginLoadingState());
    final result = await authenticationRepository.userLogin(
      context: context,
      emailController: emailController,
      passwordController: passwordController,
    );
    result.fold(
      (failure) {
        emit(LoginFailureState(failure.message));
      },
      (user) {
        emit(LoginSuccessState());
      },
    );
  }
}
