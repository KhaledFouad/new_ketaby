import 'package:flutter/widgets.dart';

abstract class AuthenticationRepository {
  Future userRegister({
    required BuildContext context,
    required TextEditingController name,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required TextEditingController confirmPassword,
  });
  Future<dynamic> userLogin({
    required BuildContext context,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  });
}
