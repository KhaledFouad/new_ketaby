import 'package:flutter/widgets.dart';

abstract class AuthenticationRepository {
  Future userRegister({
    required String email,
    required String password,
    required String confirmPassword,
    required String name,
  });
  Future<dynamic> userLogin({
    required BuildContext context,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  });
}
