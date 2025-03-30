abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginFailureState extends LoginState {
  final String error;

  LoginFailureState(this.error);
}

class LoginChangePasswordVisibilityState extends LoginState {}

class LoginChangeGenderState extends LoginState {}

class LoginChangeKeepMeLoggedInState extends LoginState {}
