import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_ketaby/feature/authentication/data/Repo/authentication_repository.dart'
    show AuthenticationRepository;
import 'package:new_ketaby/feature/authentication/presentation/cubit/Register/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.authenticationRepository) : super(RegisterInitialState());

  final AuthenticationRepository authenticationRepository;
  TextEditingController nameController = TextEditingController(
    text: "Khaled Fouad",
  );
  TextEditingController emailController = TextEditingController(
    text: "khaled.fouad20@outlook.com",
  );
  TextEditingController passwordController = TextEditingController(
    text: "123456789",
  );
  TextEditingController confirmPasswordController = TextEditingController(
    text: "123456789",
  );

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool isShowPassword = true;
  bool isShowConfirmPassword = true;

  void changePasswordVisibility() {
    isShowPassword = !isShowPassword;
    emit(RegisterChangePasswordVisibilityState());
  }

  void changeConfirmPasswordVisibility() {
    isShowConfirmPassword = !isShowConfirmPassword;
    emit(RegisterChangeConfirmPasswordVisibilityState());
  }

  Future<void> userRegister(dynamic context) async {
    emit(RegisterLoadingState());
    final result = await authenticationRepository.userRegister(
      context: context,
      name: nameController,
      emailController: emailController,
      passwordController: passwordController,
      confirmPassword: confirmPasswordController,
    );
    result.fold(
      (failure) {
        emit(RegisterFailureState(failure.message));
      },
      (user) {
        emit(RegisterSuccessState());
      },
    );
  }
}
