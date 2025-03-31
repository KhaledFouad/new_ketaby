// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:new_ketaby/config/routes/app_routes.dart';
import 'package:new_ketaby/feature/authentication/data/Repo/authentication_repository_implementation.dart';
import 'package:new_ketaby/feature/authentication/presentation/widgets/Form.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: AuthForm(
        isLogin: false,
        onSubmit:
            (email, password) =>
                AuthenticationRepositoryImplementation().userRegister(
                  context: context,
                  name: _usernameController,
                  emailController: _emailController,
                  passwordController: _passwordController,
                  confirmPassword: _confirmPasswordController,
                ),
        onToggleAuthMode: () {
          Navigator.pushNamed(context, Routes.loginView);
        },
        usernameController: _usernameController,
        confirmpasswordController: _confirmPasswordController,
        emailController: _emailController,
        passwordController: _passwordController,
        formKey: _formKey,
      ),
    );
  }
}
